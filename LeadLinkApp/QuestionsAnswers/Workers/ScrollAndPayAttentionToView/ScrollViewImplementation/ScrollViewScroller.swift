//
//  ScrollViewScroller.swift
//  LeadLinkApp
//
//  Created by Marko Dimitrijevic on 13/12/2019.
//  Copyright © 2019 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class ScrollViewScroller: ScrollingToField {
    
    private var scrollView: QuestionsScrollView
    private var questions: [PresentQuestion]
    
    init(scrollView: QuestionsScrollView, questions: [PresentQuestion]) {
        self.scrollView = scrollView
        self.questions = questions
    }
    
    func scrollTo(question: PresentQuestion) {
        
        guard let viewToScrollTo = scrollView.getQuestionView(question: question) else {
            return
        }
        
        let destinationPoint = scrollView.convert(viewToScrollTo.frame.origin, to: scrollView)
        self.scrollView.contentOffset = destinationPoint
        
    }
}
