//
//  MyAnswer.swift
//  tryLeadLinkModularComponent
//
//  Created by Marko Dimitrijevic on 08/05/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct MyAnswer: Answering {
    var campaignId = 0
    var questionId = 0
    var code = ""
    var id = ""
    var content = [String]()
    var optionIds: [Int]?
    
    var compositeId: String {
        return "\(campaignId)" + "\(questionId)" + code
    }
    
    init(campaignId: Int, questionId: Int, code: String, content: [String], optionIds: [Int]?) {
        self.campaignId = campaignId
        self.questionId = questionId
        self.code = ""
        self.id = "\(campaignId)" + "\(questionId)" + code
        self.content = content
        self.optionIds = optionIds
    }
    
    init?(realmAnswer: RealmAnswer?) {
        guard let realmAnswer = realmAnswer, realmAnswer.id != "" else {
            return nil
        }
        self.campaignId = realmAnswer.campaignId
        self.questionId = realmAnswer.questionId
        self.code = realmAnswer.code
        self.id = realmAnswer.id
        self.content = Array(realmAnswer.content)
        self.optionIds = Array(realmAnswer.optionIds)
    }
    
    static func emptyContent(question: PresentQuestion) -> MyAnswer {
        return MyAnswer.init(campaignId: question.campaignId,
                             questionId: question.id,
                             code: "",
                             content: [],
                             optionIds: [])
        
    }
    
}