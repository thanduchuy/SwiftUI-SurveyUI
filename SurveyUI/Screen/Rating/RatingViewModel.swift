//
//  RatingViewModel.swift
//  SurveyUI
//
//  Created by than.duc.huy on 27/04/2021.
//

import Foundation
import Combine

class RatingViewModel: ViewModelProtocol {
    struct Output {
        let suggets: AnyPublisher<[String], Never>
        let status: AnyPublisher<String, Never>
    }
    
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
        let rateTrigger: AnyPublisher<Int, Never>
        let suggetTrigger: AnyPublisher<Int, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        let suggets = input.loadTrigger
            .map {
                ["Pick Up", "Timing", "Politness", "Driving", "Payment", "Others"]
            }
            .eraseToAnyPublisher()
        
        let status = input.rateTrigger
            .map { index -> String in
                if index > 3 {
                    return "Good"
                } else if index > 1 {
                    return "Medium"
                } else {
                    return "Bad"
                }
            }
            .eraseToAnyPublisher()
        
        return Output(suggets: suggets,
                      status: status)
    }
}
