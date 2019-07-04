//
//  File.swift
//  signInApp
//
//  Created by Marko Dimitrijevic on 30/12/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Realm
import RealmSwift

public struct Campaigns: Codable {
    var data: [Campaign]
}

public struct Campaign: Codable {
    var id: Int
    var name: String
    var description: String
    var user_id: Int
    var conference_id: Int
    var api_key: String
    var organization_id: Int
    var created_at: String // (Date)
    var primary_color: String? // oprez - ne vidim iz response koji je ovo type
    var color: String? // oprez - ne vidim iz response koji je ovo type
    var logo: String? // url
    // uklonio sam Settings... ( ne znam sta je unutra osim da je tipa {} )
    var imgData: Data? = nil
    var use_scandit_scanner: Bool?
    
    var questions: [Question]
    var codes: [Code]?
    var organization: Organization
    
    init(realmCampaign campaign: RealmCampaign) {
        self.id = campaign.id
        self.name = campaign.name
        self.description = campaign.desc
        self.user_id = campaign.user_id
        self.conference_id = campaign.conference_id
        self.api_key = campaign.api_key
        self.organization_id = campaign.organization_id
        self.created_at = campaign.created_at
        self.primary_color = campaign.primary_color
        self.color = campaign.color ?? "#ee9c00" // hard-coded
        self.logo = campaign.logo
        self.imgData = campaign.imgData
        self.use_scandit_scanner = campaign.useScanditScanner
        
        self.organization = Organization.init(realmOrganization: campaign.organization)
        
        self.questions = campaign.questions.toArray().map(Question.init)
        self.codes = campaign.codes.toArray().map(Code.init)
    }
}
