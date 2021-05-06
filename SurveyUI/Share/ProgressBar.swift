//
//  ProgressBar.swift
//  SurveyUI
//
//  Created by than.duc.huy on 19/04/2021.
//

import SwiftUI

struct ProgressBar: View {
    var width: Float
    
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                Capsule().fill(Color("gray"))
                    .frame(height: 10)
            }
            Capsule()
                .fill(Color("lightBlue"))
                .frame(width: CGFloat(width), height: 10)
        }
        .padding()
        .cornerRadius(15)
    }
}
