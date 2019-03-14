//
//  NavigationViewModel.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 14/03/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import RxSwift

// this class is observing navigationController and decides upon its knowledge, which btns to display in navBar

class NavigationViewModel: NSObject {
    
    var navBarItems: [NavBarItem]
    var viewControllerTypes: [UIViewController.Type]
    var logOutViewModel: LogOutViewModel
    private let disposeBag = DisposeBag()
    
    var navBarItemsPublisher = PublishSubject<[NavBarItem: Bool]>() // publish this dictionary
    
    init(navBarItems: [NavBarItem], viewControllerTypes: [UIViewController.Type], logOutViewModel: LogOutViewModel) {
        self.navBarItems = navBarItems
        self.viewControllerTypes = viewControllerTypes
        self.logOutViewModel = logOutViewModel
        super.init()
    }
    
}

extension NavigationViewModel: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("willShow/viewController.implement me....")
        viewController.navigationItem.setRightBarButtonItems(getNavBarItems(typeName: viewController.myTypeName), animated: false)
        
    }
    
    private func getNavBarItems(typeName: String) -> [UIBarButtonItem] {
        
        let selector = #selector(NavigationViewModel.navBtnTapped(_:))
        
        let logoutItem = UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: selector); logoutItem.tag = 1
        let statsItem = UIBarButtonItem.init(title: "Stats", style: .plain, target: self, action: selector); statsItem.tag = 0
        
        switch typeName {
        case "LoginViewController": return [ ]
        case "CampaignsVC": return [logoutItem]
        case "ScanningVC": return [logoutItem, statsItem]
        default: break
        }
        return [ ]
    }
    
    @objc func navBtnTapped(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0: print("open statsVC")
        case 1:
            logOutViewModel.signOut()
            Timer.scheduledTimer(timeInterval: 0.0,
                                 target: UIApplication.shared.delegate as? AppDelegate,
                                 selector: #selector(AppDelegate.logoutBtnTapped),
                                 userInfo: nil,
                                 repeats: false)
        default: break
        }
    }
    
//    private func observe(userSessionState: Observable<MainViewState>) { // navigation...
//        userSessionState
//            .skip(1) // jer je inicijano set-ovan na signOut
//            .subscribe(onNext: { state in
//                switch state {
//                case .signOut:
//                    print("grab navigation and pop")
//
//                default: break
//                }
//            }).disposed(by: disposeBag)
//    }
    
}

extension UIViewController {

    static private func getTypeName<T: UIViewController>(type: T.Type) -> String {
        return "\(type)"
    }
    
    private func getMyTypeName<T: UIViewController>(object: T) -> String {
        return "\(type(of: object))"
    }
    
    static var typeName: String {
        let s = getTypeName(type: self)
//        print("typeName = ", s)
        return s
    }
    
    var myTypeName: String {
        let s = getMyTypeName(object: self)
        print("typeName = ", s)
        return s
    }
    
}