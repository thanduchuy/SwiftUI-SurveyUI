//
//  AlertCell.swift
//  SurveyUI
//
//  Created by than.duc.huy on 26/04/2021.
//

import SwiftUI

struct AlertCell: View {
    var item: Alert
    @Binding var deleteBinding: Int
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                Spacer()
                
                Image(item.type)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(item.type))
                    .scaledToFit()
                    .frame(width: 30, height: 30, alignment: .center)
                
                Spacer()
            }
            .padding()
            .background(Color(item.type).opacity(0.5))
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 20, weight: .medium, design: .default))
                    
                    Spacer()
                    
                    Button {
                        deleteBinding = item.id
                    } label: {
                        Image("close")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.gray)
                            .scaledToFit()
                            .frame(width: 20, height: 20, alignment: .center)
                    }

                }
                .padding(.trailing)
                
                Text(item.content)
                    .foregroundColor(Color.gray)
            }
        }
        .background(Color.white)
        .clipped()
        .cornerRadius(4.0)
        .shadow(radius: 4.0)
        .padding()
    }
}
