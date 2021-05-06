//
//  Notification.swift
//  SurveyUI
//
//  Created by than.duc.huy on 26/04/2021.
//

import SwiftUI
import Combine

struct Notification: View {
    
    var viewModel: NotificationModel
    var output: NotificationModel.Output
    let oneColumns = [ GridItem(.flexible())]
    
    @State var notifications = [Alert]()
    var deleteTrigger = PassthroughSubject<Int, Never>()
    
    init(viewModel: NotificationModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(NotificationModel.Input(loadTrigger: Just(()).eraseToAnyPublisher(),
                                                             deleteTrigger: deleteTrigger.eraseToAnyPublisher()))
    }
    
    var body: some View {
        let deleteBinding = Binding<Int>(get: {
            0
        }, set: { index in
            deleteTrigger.send(index)
        })
        
        VStack {
            LazyVGrid(columns: oneColumns) {
                ForEach(notifications, id: \.self) { item in
                    AlertCell(item: item, deleteBinding: deleteBinding)
                }
            }
        }
        .padding(.bottom, UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? CGFloat(0) + 10)
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
        .background(Color.white)
        .cornerRadius(25)
        .onReceive(output.notifications) {
            notifications = $0
        }
    }
}

struct Notification_Previews: PreviewProvider {
    static var previews: some View {
        Notification(viewModel: NotificationModel())
    }
}
