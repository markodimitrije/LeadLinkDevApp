//
//  CodesVC.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 20/03/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import RxSwift

class CodesVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    var codesDataSource: CodesDataSource?
    var codesDelegate: CodesDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codesDataSource?.tableView = self.tableView
        codesDelegate?.tableView = self.tableView
        self.tableView.dataSource = codesDataSource
        self.tableView.delegate = codesDelegate
        
        listenTapEvents()
    }
    
    deinit {
        print("CodesVC.deinit")
    }
    
    private func listenTapEvents() {
        codesDelegate?.selectedIndex.skip(1)
            .subscribe(onNext: { [weak self] indexPath in guard let sSelf = self else {return}
            let index = indexPath.row
                guard let code = sSelf.codesDataSource?.data[index] else {return}
                print("selected code na CodesVC je: \(code.value)")
                let nextVC = sSelf.factory.makeQuestionsAnswersViewController(code: code)
                //sSelf.navigationController!.pushViewController(nextVC, animated: true)
                guard let statsVC = sSelf.parent as? StatsVC else { fatalError() }
                statsVC.navigationController?.pushViewController(nextVC, animated: true)
        }).disposed(by: bag)
    }
    
    private let factory = AppDependencyContainer()
    private let bag = DisposeBag()
}
