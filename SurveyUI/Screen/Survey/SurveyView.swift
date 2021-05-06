//
//  SurveyView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 19/04/2021.
//

import SwiftUI
import Combine

struct SurveyView: View {
    @State var surveys = [Survey]()
    
    var selectTrigger = CurrentValueSubject<Int, Never>(0)
    var buttonTrigger = CurrentValueSubject<Void, Never>(())
    
    @Environment(\.presentationMode) var presentationMode
    @State var point = 0
    @State var selectAnswer = 0
    @State var widthProgress: Float = 0.0
    
    var viewModel: SurveyViewModel
    var output: SurveyViewModel.Output
    
    init(viewModel: SurveyViewModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(SurveyViewModel.Input(loadTrigger: CurrentValueSubject<Void, Never>(()).eraseToAnyPublisher(),
                                                           selectTrigger: selectTrigger.eraseToAnyPublisher(),
                                                           buttonTrigger: buttonTrigger.eraseToAnyPublisher()))
    }
    
    var body: some View {
        ScrollView {
            if !surveys.isEmpty {
                VStack {
                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("\(point + 1)")
                                .bold()
                            Text("of \(surveys.count)")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    ProgressBar(width: widthProgress)
                        .animation(.default)
                    
                    Text(surveys[point].question)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 30, weight: .heavy, design: .monospaced))
                        .padding()
                    
                    VStack(spacing: 8) {
                        ForEach(0..<surveys[point].answer.count, id: \.self) { index in
                            AnswerView(content: surveys[point].answer[index], isSelect: index == selectAnswer)
                                .onTapGesture {
                                    selectTrigger.send(index)
                                }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        if point < surveys.count - 1 {
                            buttonTrigger.send()
                        } else {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(point == surveys.count - 1 ? "Complete" : "Next")
                            Spacer()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("blue"))
                        .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            point = 0
            widthProgress = ((Float(UIScreen.main.bounds.width) / Float(surveys.count)) * Float(point + 1)) - 32
        }
        .onReceive(output.point) { value in
            point = value
            withAnimation(.easeInOut(duration: 1.0)) {
                widthProgress = ((Float(UIScreen.main.bounds.width) / Float(surveys.count)) * Float(point + 1)) - 32
            }
        }
        .onReceive(output.survey) { value in
            surveys = value
        }
        .onReceive(output.selectAnswer) { value in
            selectAnswer = value
        }
    }
}
