//
//  SurveySimpleView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 27/04/2021.
//

import SwiftUI
import Combine

struct SurveySimpleView: View {
    @State var point = 0
    @State var surveys = [Survey]()
    @State var selectAnswer = 0
    
    var viewModel: SurveySimpleViewModel
    var output: SurveySimpleViewModel.Output
    var nextQuestion = PassthroughSubject<Void, Never>()
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: SurveySimpleViewModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(SurveySimpleViewModel.Input(loadTrigger: CurrentValueSubject<Void, Never>(()).eraseToAnyPublisher(),
                                                                 nextTrigger: nextQuestion.eraseToAnyPublisher()))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if !surveys.isEmpty {
                HStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text("\(point + 1) of \(surveys.count)")
                        Spacer()
                    }
                    .padding(20)
                    .background(Color("gray"))
                    
                    Button {
                        if point < surveys.count - 1 {
                            nextQuestion.send()
                        } else {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Next")
                            .foregroundColor(Color.white)
                    }
                    .padding(20)
                    .background(Color("info").opacity(0.7))
                }
                
                ProgressSurvey(total: surveys.count, current: point + 1)
                
                Spacer(minLength: 40)
                
                Text(surveys[point].question)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, weight: .heavy, design: .monospaced))
                
                Spacer(minLength: 40)
                
                ForEach(0..<surveys[point].answer.count, id: \.self) { item in
                    SimpleCell(item: surveys[point].answer[item], isChoose: selectAnswer == item)
                        .onTapGesture {
                            selectAnswer = item
                        }
                }
                
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            point = 0
        }
        .onReceive(output.survey) {
            surveys = $0
        }
        .onReceive(output.point) {
            point = $0
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .animation(.default)
    }
}

struct SurveySimpleView_Previews: PreviewProvider {
    static var previews: some View {
        SurveySimpleView(viewModel: SurveySimpleViewModel())
    }
}
