//
//  GridItem.swift
//  SurveyUI
//
//  Created by than.duc.huy on 16/04/2021.
//

import SwiftUI

struct GridTopicItem: View {
    var item: String
    
    var body: some View {
        NavigationLink(destination: SurveyView(viewModel: SurveyViewModel())) {
            HStack {
                Image(item)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ConstantHomeView.sizeIcon,
                           height: ConstantHomeView.sizeIcon,
                           alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                    .foregroundColor(.white)
                    .background(ConstantHomeView.backgroundColors.randomElement())
                    .cornerRadius(ConstantHomeView.radiusIcon)
                
                Text(item)
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: ConstantHomeView.radiusTopic)
                    .stroke(Color(.systemGray4), lineWidth: ConstantHomeView.borderWidth)
            )
        }
    }
}
