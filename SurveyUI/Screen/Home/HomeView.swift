//
//  ContentView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 16/04/2021.
//

import SwiftUI
import Combine

enum ConstantHomeView {
    static let backgroundColors = [Color("blue"), Color("pink"), Color("green")]
    static let oneColumns = [ GridItem(.flexible())]
    static let twoColumns = [ GridItem(.flexible(), spacing: 20),
                              GridItem(.flexible(), spacing: 20)]
    static let gridSpacing: CGFloat = 20
    static let sizeIcon: CGFloat = 20
    static let radiusIcon: CGFloat = 10
    static let radiusTopic: CGFloat = 21
    static let borderWidth: CGFloat = 1
}

struct HomeView: View {
    
    var viewModel: HomeViewModel
    var output: HomeViewModel.Output
    
    @State var listTopic = [String]()
    @State var listSurvey = [Multiple]()
    @State var showSheet = false
    @State var showLogin = false
    @State var showRating = false
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(HomeViewModel.Input(loadTrigger: Just<Void>(()).eraseToAnyPublisher()))
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            Text("5 upcoming surveys")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.leading, 24)
                        
                        LazyVGrid(columns: ConstantHomeView.twoColumns,
                                  alignment: .center,
                                  spacing: ConstantHomeView.gridSpacing) {
                            ForEach(listTopic, id: \.self) { item in
                                GridTopicItem(item: item)
                            }
                        }.padding()
                        
                        VStack {
                            HStack {
                                Text("All Surveys")
                                    .font(.system(size: 24, weight: .black, design: .default))
                                
                                Spacer()
                            }
                            .padding(.leading, 24)
                            
                            LazyVGrid(columns: ConstantHomeView.oneColumns,
                                      alignment: .center, spacing: 0) {
                                ForEach(listSurvey, id: \.self) { item in
                                    MultipleItem(item: item)
                                }
                            }
                        }
                        
                        NavigationLink(destination: RatingView(viewModel: RatingViewModel()), isActive: $showRating) {
                            EmptyView()
                        }
                        
                        NavigationLink(destination: LoginView(viewModel: LoginViewModel()), isActive: $showLogin) {
                            EmptyView()
                        }
                    }
                }
                .navigationBarTitle("Todays Surveys")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showSheet.toggle()
                        }, label: {
                            Image(systemName: "bell")
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu {
                            Button {
                                self.showRating.toggle()
                            } label: {
                                Label("Rate App", systemImage: "star.circle")
                            }
                            
                            Button(action: {
                                self.showLogin.toggle()
                            }) {
                                Label("Login", systemImage: "person.circle")
                            }
                        }
                        label: {
                            Image(systemName: "list.dash")
                        }
                    }
                }
            }
            .accentColor(.black)
            .onReceive(output.listTopic) {
                listTopic = $0
            }
            .onReceive(output.listSurvey) {
                listSurvey = $0
            }
            
            VStack {
                Spacer()
                
                Notification(viewModel: NotificationModel())
                    .offset(y: self.showSheet ? 0 : UIScreen.main.bounds.height)
            }
            .background((self.showSheet ? Color.black.opacity(0.3): Color.clear)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.showSheet.toggle()
                            })
            .edgesIgnoringSafeArea(.bottom)
        }
        .animation(.default)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
