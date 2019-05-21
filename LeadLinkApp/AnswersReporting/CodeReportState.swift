//
//  Code.swift
//  tryWebApiAndSaveToRealm
//
//  Created by Marko Dimitrijevic on 04/11/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Realm


class CodeReportsState { // ovo je trebalo da zoves viewModel-om !
    
    private var codeReports: Results<AnswersReport>? {
        
        guard let realm = try? Realm.init() else {return nil} // ovde bi trebalo RealmError!
        
        return realm.objects(AnswersReport.self)
    }
    
    private var shouldReportToWeb: Bool {
        
        guard let reports = codeReports else {return false} // ovde bi trebalo RealmError!
        
        return reports.isEmpty
    }
    
    private var timer: Timer?
    
    private let bag = DisposeBag()
    
    // INPUT
    
    let report = BehaviorRelay<AnswersReport?>.init(value: nil)
    
    // OUTPUT
    
    let webNotified = BehaviorRelay<(AnswersReport, Bool)?>.init(value: nil)
    
    init() {
        
        bindInputWithOutput()
        
    }
    
    private func bindInputWithOutput() { print("CodeReportsState.bindInputWithOutput")
        
        report
            .asObservable()
            .subscribe(onNext: { [weak self] report in guard let sSelf = self else {return}
                
                let obs = sSelf.reportImidiatelly(report: sSelf.report.value)
                obs
                    .subscribe(onNext: { (code, success) in

                        sSelf.webNotified.accept((code, success)) // postavi na svoj Output

                        if success {
                            print("jesam success, implement save to realm!")
                            
                            RealmDataPersister.shared.save(codesAcceptedFromWeb: [code])
                                .subscribe(onNext: { saved in
                                    print("code successfully reported to web, save in your archive")
                                }).disposed(by: sSelf.bag)
                        }

                        if !success {
                            sSelf.codeReportFailed(code) // izmestac code
                        }

                    })
                    .disposed(by: sSelf.bag)
            })
            .disposed(by: bag)
        
    }
    
    private func codeReportFailed(_ report: AnswersReport) {
        
        fatalError("codeReportFailed implement me!")
        
        //print("codeReportFailed/ snimi ovaj report.code \(report.code) u realm")
        
//        _ = RealmDataPersister().saveToRealm(codeReport: report)
//        // okini process da javljas web-u sve sto ima u realm (codes)
//        if codesDumper == nil {
//            codesDumper = CodesDumper() // u svom init, zna da javlja reports web-u...
//            codesDumper.oCodesDumped
//                .asObservable()
//                .subscribe(onNext: { (success) in
//                    if success {
//                        codesDumper = nil
//                    }
//                })
//                .disposed(by: bag)
//        }
        
    }
    
    private func reportImidiatelly(report: AnswersReport?) -> Observable<(AnswersReport, Bool)> {
        
        guard let report = report else {return Observable.empty()}
        
        print("prijavi ovaj report = \(report)")
        
        return AnswersApiController.shared.notifyWeb(withCodeReport: report)
        
        //return ApiController.shared.reportSingleCode(report: report)
        
      
        
        
        
    }
    
    // implement me...
    private func reportToWeb(codeReports: Results<AnswersReport>?) {
        
        // sviranje... treba mi servis da javi sve.... za sada posalji samo jedan...
        
        guard let report = codeReports?.first else {
            print("nemam ni jedan code da report!...")
            return
        }
        
        print("CodeReportsState/ javi web-u za ovaj report:")
        print("code.payload = \(report.payload)")

    }
    
}
