//
//  ContentView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("appBlack")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Notes")
                            .font(.system(size: 43, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            // Action for search button
                        }) {
                            Image("search")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .padding()
                        }
                        .background(Color("appGray"))
                        .cornerRadius(15)
                        .padding(.trailing, 25)
                        .frame(width: 50, height: 50)

                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 47)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: NotesView()) {
                            Image("add")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .background(Color("appBlack"))
                                .cornerRadius(35)
                                .shadow(color: .black, radius: 10, x: -5, y: 0)
                                .shadow(color: .black, radius: 10, x: 0, y: 5)
                        }
                        .frame(width: 70, height: 70)
                        .padding(.bottom, 49)
                        .padding(.trailing, 35)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .navigationBarHidden(false)
        }
    }
}

struct NotesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var titleText: String = ""
    @State private var bodyText: String = ""
    
    var body: some View {
        ZStack {
            Color("appBlack")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    backButton
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    saveButton
                        .padding(.trailing, 25)
                }
                .frame(height: 50)
                
                TextEditor(text: $titleText)
                    .foregroundColor(titleText.isEmpty ? Color.gray : .black)
                    .font(.system(size: 35, weight: .regular))
                    .padding()
                    .frame(height: 100)
                    .background(.clear)
                    .onAppear {
                        UITextView.appearance().backgroundColor = .clear
                    }
                    .onDisappear {
                        UITextView.appearance().backgroundColor = nil
                    }
                    .cornerRadius(10)
                    .onTapGesture {
                        if titleText.isEmpty {
                            titleText = ""
                        }
                    }
                    .overlay(
                        Group {
                            if titleText.isEmpty {
                                Text("Title")
                                    .foregroundColor(Color.gray)
                                    .padding(.leading, 5)
                                    .padding(.top, 8)
                            }
                        }
                    )

                TextEditor(text: $bodyText)
                    .foregroundColor(bodyText.isEmpty ? Color.gray : .black)
                    .font(.system(size: 23, weight: .regular))
                    .padding()
                    .background(Color("appBlack"))
                    .cornerRadius(10)
                    .onTapGesture {
                        if bodyText.isEmpty {
                            bodyText = ""
                        }
                    }
                    .overlay(
                        Group {
                            if bodyText.isEmpty {
                                Text("Type something...")
                                    .foregroundColor(Color.gray)
                                    .padding(.leading, 5)
                                    .padding(.top, 8)
                            }
                        }
                    )

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image("chevron_left")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            saveNote()
        }) {
            Image("save")
                .scaledToFit()
                .frame(width: 48, height: 48)
                .background(Color("appGray"))
                .cornerRadius(15)
        }
    }

    private func saveNote() {
        print("Note saved with title: \(titleText) and body: \(bodyText)")
        // Here you can add functionality to save the note to a database or file
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}

#Preview {
    ContentView()
}
