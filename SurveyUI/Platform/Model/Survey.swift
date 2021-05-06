//
//  Survey.swift
//  SurveyUI
//
//  Created by than.duc.huy on 19/04/2021.
//

import Foundation
import SwiftUI

struct Survey: Identifiable {
    var id: Int
    var question: String
    var answer: [String]
    var correctAnswer: Int
}
