//
//  File.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 23/05/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class ReportsDataSource: NSObject, UITableViewDataSource {
    
    weak var tableView: UITableView!
    var cellId: String
    private var reportsDataStore: ReportsDataStore

    var data = [Report]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    init(campaignId: Int, reportsDataStore: ReportsDataStore, cellId: String) {
        self.cellId = cellId
        self.reportsDataStore = reportsDataStore
        super.init()
        reportsDataStore.oReports
            .subscribe(onNext: { [weak self] realmReports in guard let sSelf = self else {return}
                sSelf.data = realmReports.map(Report.init)
            }).disposed(by: bag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReportsTVC
        cell.update(report: data[indexPath.row])
        return cell
    }
    
    private let bag = DisposeBag()
    
}

class ReportsDelegate: NSObject, UITableViewDelegate {
    weak var tableView: UITableView!
    var selectedIndex = BehaviorRelay.init(value: IndexPath.init())//.skip(1) at destination // dummy initialization
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex.accept(indexPath)
    }
}

struct Report {
    var code: String
    var date: Date?
    var sync: Bool
    var campaignId: Int
    init(realmReport: RealmWebReportedAnswers) {
        self.code = realmReport.code
        self.date = realmReport.date
        self.sync = realmReport.success
        self.campaignId = Int(realmReport.campaignId)!
    }
}
