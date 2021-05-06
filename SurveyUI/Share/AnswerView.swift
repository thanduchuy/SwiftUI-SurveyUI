//
//  AnswerView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 19/04/2021.
//

import SwiftUI

struct AnswerView: View {
    var content: String
    var isSelect: Bool
    
    var body: some View {
        HStack {
            Text(content)
                .foregroundColor(isSelect ? Color("blue") : Color.black)
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelect ? Color("blue") : Color("gray"), lineWidth: 1)
        )
        .padding()
    }
}

