//
//  LoginViewModel.swift
//  SurveyUI
//
//  Created by than.duc.huy on 28/04/2021.
//
import Combine
import SwiftUI

class LoginViewModel: ViewModelProtocol {
    struct Input {
        let usenameTrigger: AnyPublisher<String, Never>
        let passwordTrigger: AnyPublisher<String, Never>
    }
    
    struct Output {
        let activeName: AnyPublisher<Bool, Never>
        let error: AnyPublisher<String, Never>
    }
    
    func bind(_ input: Input) -> Output {
        let activeName = input.usenameTrigger
            .removeDuplicates()
            .dropFirst()
            .map {
                $0.count > 8
            }
            .eraseToAnyPublisher()
        
        let error = input.passwordTrigger
            .removeDuplicates()
            .dropFirst()
            .map {
                $0.count < 8 ? "Invalid Password" : ""
            }
            .eraseToAnyPublisher()
        
        return Output(activeName: activeName,
            error: error)
    }
}

