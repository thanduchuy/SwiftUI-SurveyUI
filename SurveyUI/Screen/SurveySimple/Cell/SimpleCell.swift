//
//  SimpleCell.swift
//  SurveyUI
//
//  Created by than.duc.huy on 27/04/2021.
//

import SwiftUI

struct SimpleCell: View {
    var item: String
    var isChoose: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Image(systemName: "checkmark")
                    .padding(.horizontal)
                    .opacity(isChoose ? 1.0 : 0.0)
                
                Text(item)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color("info"))
        }
        .frame(height: 70)
        .foregroundColor(Color.white)
        .background(isChoose ? Color("info") : Color("lightBlue"))
    }
}
