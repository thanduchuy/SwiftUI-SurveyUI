//
//  SurveyModelView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 19/04/2021.
//

import SwiftUI
import Combine

protocol ViewModelProtocol: ObservableObject {
    associatedtype Output
    associatedtype Input
    
    func bind(_ input: Input) -> Output
}

class SurveyViewModel: ViewModelProtocol {
    struct Output {
        let survey: AnyPublisher<[Survey], Never>
        let point: AnyPublisher<Int, Never>
        let selectAnswer: AnyPublisher<Int, Never>
    }
    
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
        let selectTrigger: AnyPublisher<Int, Never>
        let buttonTrigger: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func bind(_ input: Input) -> Output {
        var pointDefault = -1
        
        let point = input.buttonTrigger
            .map { _ -> Int in
                pointDefault += 1
                return pointDefault
            }
            
        
        let selectAnswer = input.selectTrigger
        
        let surveys = input.loadTrigger
            .map { [
                Survey(id: 1,
                       question: "Bằng cái nồi rang. Cả làng phơi thóc?", answer: [
                        "Mặt trời", "Bánh đa", "Cái ao", "Cái chiếu"
                       ], correctAnswer: 1),
                Survey(id: 2,
                       question: "Chẳng ai biết mặt ra sao. Chỉ nghe tiếng thét trên cao ầm ầm?", answer: [
                        "Mưa", "Nắng", "Sấm", "Mây"
                       ], correctAnswer: 3),
                Survey(id: 3,
                       question: "Chặt không đứt, bứt không rời. Phơi không khô, chụm không cháy?", answer: [
                        "Cỏ", "Nhà", "Cây", "Nước"
                       ], correctAnswer: 4),
                Survey(id: 4,
                       question: "Không ai đắp cả mà cao?", answer: [
                        "Ngôi nhà", "Cái bàn", "Núi", "Cái gối"
                       ], correctAnswer: 3),
                Survey(id: 5,
                       question: "Không ai đào mà sâu?", answer: [
                        "Mây", "Tiền", "Điện thoại", "Biển"
                       ], correctAnswer: 4)
            ]}
        
        return Output(survey: surveys.eraseToAnyPublisher(),
                      point: point.eraseToAnyPublisher(),
                      selectAnswer: selectAnswer.eraseToAnyPublisher())
    }
}
