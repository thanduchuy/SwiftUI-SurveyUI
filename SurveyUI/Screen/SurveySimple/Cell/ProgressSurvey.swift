//
//  SwiftUIView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 27/04/2021.
//

import SwiftUI

struct ProgressSurvey: View {
    var total: Int
    var current: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<total, id: \.self) { index in
                Rectangle()
                    .foregroundColor(index < current ? Color("blue") : Color("lightBlue"))
            }
        }
        .frame(height: 10)
        .padding(.horizontal)
        
    }
}
