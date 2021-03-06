//
//  LoginViewControllerFactory.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 21/06/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import Foundation

class LoginViewControllerFactory {
    
    var appDependancyContainer: AppDependencyContainer
    
    init(appDependancyContainer: AppDependencyContainer) {
        self.appDependancyContainer = appDependancyContainer
    }
    
    func makeVC() -> LoginViewController {
        
        let viewController = LoginViewController.instantiate(using: appDependancyContainer.sb)
        viewController.logInViewModel = LoginViewModelFactory(appDependancyContainer: factory).makeLoginViewModel()

        return viewController
    }
}
