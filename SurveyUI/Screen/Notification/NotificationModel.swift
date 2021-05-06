//
//  NotificationModel.swift
//  SurveyUI
//
//  Created by than.duc.huy on 26/04/2021.
//
import SwiftUI
import Combine
import Foundation

class NotificationModel: ViewModelProtocol {
    private var cancellable = Set<AnyCancellable>()
    
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
        let deleteTrigger: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let notifications: AnyPublisher<[Alert], Never>
    }
    
    func bind(_ input: Input) -> Output {
        let savedTime = PassthroughSubject<[Alert], Never>()
        
        input.loadTrigger
            .map {
                [Alert(id: 1, title: "Error", content: "Can we help you recover data?", type: "error"),
                 Alert(id: 2, title: "Warning", content: "Looks like you've exceeded yout limit.", type: "warning"),
                 Alert(id: 3, title: "Info", content: "We've updated a few things.", type: "info"),
                 Alert(id: 4, title: "Success", content: "Survey added to cart. Yay!", type: "success")]
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
            .sink(receiveValue: {
                savedTime.send($0)
            })
            .store(in: &cancellable)
            
        input.deleteTrigger
            .combineLatest(savedTime) { index, item in
                item.filter { $0.id != index }
            }
            .sink(receiveValue: {
                savedTime.send($0)
            })
            .store(in: &cancellable)
        
        return Output(notifications: savedTime.eraseToAnyPublisher())
    }
}
