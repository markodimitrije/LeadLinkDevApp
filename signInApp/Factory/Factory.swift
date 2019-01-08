////
////  Factory.swift
////  signInApp
////
////  Created by Marko Dimitrijevic on 03/01/2019.
////  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
////

import UIKit
import RxSwift

public class AppDependencyContainer {

    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    
    // MARK: - Properties

    // Long-lived dependencies
    let sharedUserSessionRepository: UserSessionRepository
    let sharedMainViewModel: MainViewModel
    let sharedCampaignsRepository: CampaignsRepository

    public init() {
        
        func makeUserSessionRepository() -> UserSessionRepository {
            let dataStore = makeUserSessionDataStore()
            let remoteAPI = makeAuthRemoteAPI()
            return LeadLinkUserSessionRepository.init(dataStore: dataStore, remoteAPI: remoteAPI)
        }

        func makeUserSessionDataStore() -> UserSessionDataStore {
            
            return FileUserSessionDataStore()

        }

        func makeAuthRemoteAPI() -> AuthRemoteAPI {
            return LeadLinkRemoteAPI.init()
        }

        func makeMainViewModel() -> MainViewModel {
            return MainViewModel()
        }
        
        // campaigns
        
        func makeCampaignsRepository() -> CampaignsRepository {
            
            //let userSession = sharedUserSessionRepository.readUserSession().value!! // oprez - ne valja ovo mislim....
            let userSession = makeUserSessionRepository().readUserSession().value
            let dataStore = RealmCampaignsDataStore.init()
            let questionsDataStore = RealmQuestionsDataStore.init()
            let remoteAPI = LeadLinkCampaignsRemoteAPI.shared
            
            return CampaignsRepository.init(userSession: userSession,
                                            dataStore: dataStore, // persist campaigns + rename...
                                            questionsDataStore: questionsDataStore, // persist questions
                                            remoteAPI: remoteAPI) // ovde nadji data
        }
        
        self.sharedUserSessionRepository = makeUserSessionRepository()
        self.sharedMainViewModel = makeMainViewModel()
        self.sharedCampaignsRepository = makeCampaignsRepository()

    }
    
    // Main
    // Factories needed to create a MainViewController.
    
        func makeLogoutViewController() -> LogoutVC {
            
            // ovde mozes da mu property inject recimo viewmodel, ili fabriku ili sta treba:
            return sb.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
            
        }

}
