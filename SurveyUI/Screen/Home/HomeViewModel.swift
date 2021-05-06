//
//  HomeViewModel.swift
//  SurveyUI
//
//  Created by than.duc.huy on 23/04/2021.
//
import Combine
import SwiftUI
import Foundation

class HomeViewModel: ViewModelProtocol {
    
    struct Input {
        let loadTrigger: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let listTopic: AnyPublisher<[String], Never>
        let listSurvey: AnyPublisher<[Multiple], Never>
    }
    
    
    func bind(_ input: Input) -> Output {
        let listTopic = input.loadTrigger
            .map {
                ["Science", "Social", "Tech", "Gaming", "History", "Analytics"]
            }
            .eraseToAnyPublisher()
        
        let listSurvey = input.loadTrigger
            .map {
                [Multiple(id: 1, image: "Thresh", title: "Business Survey", total: 15, accomplished: 4),
                 Multiple(id: 1, image: "Lucian", title: "Computer Survey", total: 10, accomplished: 1),
                 Multiple(id: 1, image: "Urgot", title: "Travel Survey", total: 5, accomplished: 4),
                 Multiple(id: 1, image: "Hecarim", title: "Marth Survey", total: 8, accomplished: 3)]
            }
            .eraseToAnyPublisher()
        
        return Output(listTopic: listTopic,
                      listSurvey: listSurvey)
    }
}
