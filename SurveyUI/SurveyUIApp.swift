//
//  SurveyUIApp.swift
//  SurveyUI
//
//  Created by than.duc.huy on 16/04/2021.
//

import SwiftUI

@main
struct SurveyUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
