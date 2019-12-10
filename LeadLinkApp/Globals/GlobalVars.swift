//
//  GlobalVars.swift
//  tryLeadLinkModularComponent
//
//  Created by Marko Dimitrijevic on 10/05/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import Foundation
import RxSwift

let factory: AppDependencyContainer = AppDependencyContainer.init()

var surveyInfo: SurveyInfo?

var reportsDumper: ReportsDumper! // prazni codes (saved in Realm), koji su failed da se prijave pojedinacno na web

var tableRowHeightCalculator: QuestionsAnswersTableRowHeightCalculating = {

    guard let deviceType = getDeviceType() else { fatalError("cant determine device type!?!") }
    
    switch deviceType {
    case DeviceType.iPhone: return IphoneQuestionsAnswersTableRowHeightCalculator()
    case DeviceType.iPad: return IpadQuestionsAnswersTableRowHeightCalculator()
    }
}()

var tableHeaderFooterCalculator: QuestionsAnswersTableViewHeaderFooterCalculating {
    
    guard let deviceType = getDeviceType() else { fatalError("cant determine device type!?!") }
    
    switch deviceType {
    case DeviceType.iPhone: return IphoneQuestionsAnswersTableViewHeaderFooterCalculator()
    case DeviceType.iPad: return IpadQuestionsAnswersTableViewHeaderFooterCalculator()
    }
}

//var confApiKeyState = ConferenceApiKeyState()
var confApiKeyState: ConferenceApiKeyState? = {
    
    let authToken = UserDefaults.standard.value(forKey: UserDefaults.keyConferenceAuth) as? String ?? ""
    var selectedCampaign: Campaign?
    
    if let campaignId = UserDefaults.standard.value(forKey: UserDefaults.keyConferenceId) as? Int {
        let sharedCampaignsRepository = factory.sharedCampaignsRepository
        sharedCampaignsRepository.dataStore.readCampaign(id: campaignId)
            .done { campaign in
                selectedCampaign = campaign
        }
    }
    return ConferenceApiKeyState(authToken: authToken, selectedCampaign: selectedCampaign)
}()

var selectedCampaignId: Int? {
    get {
        return UserDefaults.standard.value(forKey: "campaignId") as? Int
    }
    set {
        UserDefaults.standard.setValue(newValue, forKey: "campaignId")
    }
}

var allowedQuestionsWidth: CGFloat {
    let myAllowedWidth = UIScreen.main.bounds.width - 16
    return myAllowedWidth
}
