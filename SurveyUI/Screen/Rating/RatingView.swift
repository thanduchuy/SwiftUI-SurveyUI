//
//  Rating.swift
//  SurveyUI
//
//  Created by than.duc.huy on 27/04/2021.
//
import Combine
import SwiftUI

struct RatingView: View {
    let colums = [ GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    @Environment(\.presentationMode) var presentationMode
    @State var point = 0
    @State var suggets = [String]()
    @State var rate = 0
    @State var status = ""
    @State var selectSugget = Int.max
    
    var viewModel: RatingViewModel
    var output: RatingViewModel.Output
    var rateTrigger = CurrentValueSubject<Int, Never>(0)
    var suggetTrigger = CurrentValueSubject<Int, Never>(0)
    
    init(viewModel: RatingViewModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(RatingViewModel.Input(loadTrigger: CurrentValueSubject<Void, Never>(()).eraseToAnyPublisher(),
                                                           rateTrigger: rateTrigger.eraseToAnyPublisher(),
                                                           suggetTrigger: suggetTrigger.eraseToAnyPublisher()))
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color.black.opacity(0.8))
                }
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text(status)
                .foregroundColor(.gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .padding()
            
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(index <= rate ? Color("warning") : Color("gray"))
                        .onTapGesture {
                            rate = index
                            rateTrigger.send(index)
                        }
                }
            }
            .padding()
            
            VStack {
                Text("What we can di better?")
                    .font(.system(size: 17, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                    .padding()
                
                LazyVGrid(columns: colums, spacing: 10) {
                    ForEach(0..<suggets.count, id: \.self) { item in
                        Button {
                            selectSugget = item
                        } label: {
                            HStack {
                                Spacer()
                                
                                Text(suggets[item])
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(item == selectSugget ? Color("warning") : Color.gray, lineWidth: 2)
                        )
                        .background(item == selectSugget ? Color("warning") : Color.clear)
                    }
                }
                .padding()
            }
            .padding(.vertical)
            .background(Color("gray"))
            
            Spacer()
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Spacer()
                    
                    Text("SUBMIT")
                        .font(.system(size: 25, weight: .bold, design: .default))
                    
                    Spacer()
                }
            }
            .padding()
            .background(Color("success").opacity(0.8))
            .foregroundColor(Color.white)
            

        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onReceive(output.status) {
            status = $0
        }
        .onReceive(output.suggets) {
            suggets = $0
        }
        .animation(.default)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(viewModel: RatingViewModel())
    }
}
