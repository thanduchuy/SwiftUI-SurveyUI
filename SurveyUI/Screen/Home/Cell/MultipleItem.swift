//
//  MultipleItem.swift
//  SurveyUI
//
//  Created by than.duc.huy on 27/04/2021.
//

import SwiftUI

struct MultipleItem: View {
    var item: Multiple
    
    var body: some View {
        NavigationLink(destination: SurveySimpleView(viewModel: SurveySimpleViewModel())) {
            HStack {
                Image(item.image)
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack(alignment: .center) {
                    HStack {
                        Text(item.title)
                            .font(.system(size: 18, weight: .bold, design: .default))
                        
                        Spacer()
                        
                        Text("\(item.accomplished)/\(item.total)")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    GeometryReader { view in
                        ProgressBar(width:((Float(view.size.width) / Float(item.total)) * Float(item.accomplished)))
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}
