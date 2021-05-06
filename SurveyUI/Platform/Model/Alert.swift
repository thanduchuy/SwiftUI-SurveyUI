//
//  Alert.swift
//  SurveyUI
//
//  Created by than.duc.huy on 26/04/2021.
//

import Foundation

struct Alert: Identifiable, Hashable {
    var id: Int
    var title: String
    var content: String
    var type: String
}
