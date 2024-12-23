//
//  CustomAlertView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//

//import SwiftUI
//
//struct CustomAlertView: View {
//    @Binding var isPresented: Bool
//    var title: String
//    var message: String
//    var primaryButtonTitle: String
//    var secondaryButtonTitle: String
//    var primaryButtonAction: () -> Void
//    var secondaryButtonAction: () -> Void
//
//    var body: some View {
//        if isPresented {
//            ZStack {
//                Color.black.opacity(0.4)
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 20) {
//                    Text(title)
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                    
//                    Text(message)
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//                        .padding()
//                    
//                    HStack {
//                        Button(action: {
//                            secondaryButtonAction()
//                            isPresented = false
//                        }) {
//                            Text(secondaryButtonTitle)
//                                .foregroundColor(.red)
//                                .padding()
//                                .background(Color.white.opacity(0.2))
//                                .cornerRadius(8)
//                        }
//                        
//                        Spacer()
//                        
//                        Button(action: {
//                            primaryButtonAction()
//                            isPresented = false
//                        }) {
//                            Text(primaryButtonTitle)
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.blue)
//                                .cornerRadius(8)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .frame(width: 300, height: 200)
//                .background(Color.gray)
//                .cornerRadius(12)
//                .shadow(radius: 20)
//            }
//        }
//    }
//}

import SwiftUI

struct CustomAlertView: View {
    @Binding var isPresented: Bool
    var title: String
    var message: String
    var primaryButtonTitle: String
    var secondaryButtonTitle: String
    var primaryButtonAction: () -> Void
    var secondaryButtonAction: () -> Void

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack {
                        Button(action: {
                            secondaryButtonAction()
                            isPresented = false
                        }) {
                            Text(secondaryButtonTitle)
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            primaryButtonAction()
                            isPresented = false
                        }) {
                            Text(primaryButtonTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(width: 300, height: 200)
                .background(Color.gray)
                .cornerRadius(12)
                .shadow(radius: 20)
            }
        }
    }
}
