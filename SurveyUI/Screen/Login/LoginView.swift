//
//  LoginView.swift
//  SurveyUI
//
//  Created by than.duc.huy on 28/04/2021.
//
import Combine
import SwiftUI

struct LoginView: View {
    var nameTextField = CurrentValueSubject<String, Never>("")
    var passwordTextField = CurrentValueSubject<String, Never>("")
    
    var viewModel: LoginViewModel
    var output: LoginViewModel.Output

    @Environment(\.presentationMode) var presentationMode
    @State var error = ""
    @State var isSecured = true
    @State var activeName = false
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        self.output = viewModel.bind(LoginViewModel.Input(usenameTrigger: nameTextField.eraseToAnyPublisher(),
                                                          passwordTrigger: passwordTextField.eraseToAnyPublisher()))
    }
    
    
    var body: some View {
        let nameUser = Binding<String>(get: {
            self.nameTextField.value
        }, set: {
            self.nameTextField.send($0)
        })
        
        let password = Binding<String>(get: {
            self.passwordTextField.value
        }, set: {
            self.passwordTextField.send($0)
        })
        
        return VStack {
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
            
            Text("Login")
                .foregroundColor(.white)
                .font(.system(size: 35, weight: .bold, design: .default))
                .padding(.vertical, 40)
            
            HStack(alignment: .center) {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                
                TextField("Enter user name", text: nameUser)
                
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color("success").opacity(0.6))
                    .opacity(activeName ? 1.0 : 0.0)
            }
            .modifier(BorderCapsule(backgroundColor: Color.white))
            
            HStack(alignment: .center) {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
                
                if isSecured {
                    SecureField("Enter password", text: password)
                } else {
                    TextField("Enter password", text: password)
                }
                
                
                Image(systemName: isSecured ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isSecured.toggle()
                    }
            }
            .modifier(BorderCapsule(backgroundColor: Color.white))
            
            if !error.isEmpty {
                Text(error)
                    .foregroundColor(Color("error"))
            }
            
            Button(action: {
                
            }, label: {
                HStack {
                    Spacer()
                    
                    Text("Login")
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .modifier(BorderCapsule(backgroundColor: Color("purple")))
            })
            
            NavigationLink(
                destination: HomeView(viewModel: HomeViewModel()),
                label: {
                    Text("Forgot your password?")
                        .foregroundColor(.white)
                })
            
            Spacer()
            
            VStack(spacing: 20) {
                Text("or connect with")
                    .foregroundColor(.gray)
                
                HStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Image("facebook")
                            .renderingMode(.template)
                        
                        Text("Facebook")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("lightBlue"))
                    .clipped()
                    .clipShape(Capsule())
                    
                    HStack {
                        Image("twitter")
                            .renderingMode(.template)
                        
                        Text("Twitter")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("blue"))
                    .clipped()
                    .clipShape(Capsule())
                }
                .padding()
                
                
                HStack {
                    Text("Don't have account?")
                        .foregroundColor(.white)
                    
                    NavigationLink(
                        destination: HomeView(viewModel: HomeViewModel()),
                        label: {
                            Text("Sign up")
                                .foregroundColor(Color("blue"))
                        })
                }
            }
            
            Spacer()
        }
        .background(
            Image("bgLogin")
        )
        .onReceive(output.activeName) {
            activeName = $0
        }
        .onReceive(output.error) {
            error = $0
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .animation(.default)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
