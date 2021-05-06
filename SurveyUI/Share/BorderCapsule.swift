//
//  BorderCapsule.swift
//  SurveyUI
//
//  Created by than.duc.huy on 28/04/2021.
//
import Foundation
import SwiftUI

struct BorderCapsule: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .clipped()
            .clipShape(Capsule())
            .padding()
            .shadow(color: Color("purple").opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5.0, y: 5.0)
    }
}
