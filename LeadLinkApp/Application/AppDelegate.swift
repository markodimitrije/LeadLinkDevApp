//
//  AppDelegate.swift
//  signInApp
//
//  Created by Marko Dimitrijevic on 30/12/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationViewModel: NavigationViewModel!
    var startVCProvider: StartViewControllerProviding!
    lazy var logOutViewModel = LogoutViewModelFactory(appDependancyContainer: factory).makeViewModel()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let dataBaseMigrator: DataBaseMigrating = RealmSchemaMigrator.init(newVersion: 1)
        dataBaseMigrator.migrate()

        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("Realm url: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        startVCProvider = StartViewControllerProvider(factory: factory)
        
        let navigationViewModelFactory = NavigationViewModelFactory(appDependancyContainer: factory)
        
        navigationViewModel = navigationViewModelFactory.makeViewModel()
        
        let navVC = UINavigationController()
        
        bindNavigationViewModelWithNavigationViewController(navViewModel: navigationViewModel,
                                                            navVC: navVC)
        
        let startingVCs = startVCProvider.getStartViewControllers()
        
        _ = startingVCs.map { vc -> Void in
            navVC.pushViewController(vc, animated: false)
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        downloadCampaignsQuestionsAndLogos()
    }
    
    @objc func logoutBtnTapped() {
        
        guard let topController = UIApplication.topViewController() else { fatalError() }
        let centerPt = CGPoint.init(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        let centerSize = CGSize.init(width: 1, height: 1)
        let centerView = UIView.init(frame: CGRect.init(center: centerPt, size: centerSize))
        topController.view.addSubview(centerView)
            
        topController.alert(alertInfo: AlertInfo.getInfo(type: .logout), sourceView: centerView)
            .subscribe(onNext: { [weak self] index in
                if index == 0 { // logout
                    (self?.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
                    self?.logOutViewModel.signOut()
                } else { // cancel
                    topController.dismiss(animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    func loadLoginVC() {
        (self.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
    }
    
    @objc func statsBtnTapped(_ notification: NSNotification) {
        guard let info = notification.userInfo, let id = info["campaignId"] as? Int else {
            fatalError("no campaignId sent from statsBtn")
        }
        
        let statsVcFactory = StatsViewControllerFactory.init(appDependancyContainer: factory)
        
        let statsVC = statsVcFactory.makeVC(campaignId: id)
        
        (window?.rootViewController as? UINavigationController)?.pushViewController(statsVC, animated: true)
    }
    
    func downloadCampaignsQuestionsAndLogos() {
        
        guard confApiKeyState != nil else {return}
        
        let campaignsViewmodel = CampaignsViewModel.init(campaignsRepository: factory.sharedCampaignsRepository, downloadImageAPI: factory.downloadImageAPI)
        
        print("downloadCampaignsQuestionsAndLogos.calling getCampaignsFromWeb.... .... ....")
        
        campaignsViewmodel.getCampaignsFromWeb()
        
    }
    
    private func bindNavigationViewModelWithNavigationViewController(navViewModel: NavigationViewModel, navVC: UINavigationController?) {
        navVC?.delegate = navViewModel
        navViewModel.navBarItemsPublisher
        .subscribe(onNext: { dict in
            print("publisher has navBarDict = \(dict)")
        })
        .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
    
}
