//
//  ReportsDataStoreFactory.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 24/06/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import Foundation

class ReportsDataStoreFactory {
    
    var appDependancyContainer: AppDependencyContainer
    
    init(appDependancyContainer: AppDependencyContainer) {
        self.appDependancyContainer = appDependancyContainer
    }
    
    func makeReportsDataStore() -> ReportsDataStore {
        guard let campaignId = selectedCampaignId else { // TODO: global var!?!
            fatalError("no campaign id ?!?")
        }
        return RealmReportsDataStore.init(campaignId: campaignId)
    }
}
