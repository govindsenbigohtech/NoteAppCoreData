//
//  ContentView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var notesManager = NotesManager()
    
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
                    
                    List {
                        ForEach(notesManager.notes) { note in
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(note.body)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: NotesView(notesManager: notesManager)) {
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
    @ObservedObject var notesManager: NotesManager
    
    @State private var titleText: String = ""
    @State private var bodyText: String = ""
    @State private var showAlert: Bool = false
    @State private var isDiscarding: Bool = false
    
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
                    .foregroundColor(titleText.isEmpty ? Color.gray : .white)
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
                    .foregroundColor(bodyText.isEmpty ? Color.gray : .white)
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
            .overlay(
                Group {
                    if showAlert {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20) {
                            Text(isDiscarding ? "Are you sure you want to discard your changes?" : "Save Changes?")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                            
                            HStack {
                                Button(action: {
                                    if isDiscarding {
                                        // Perform discard operation
                                        titleText = ""
                                        bodyText = ""
                                        presentationMode.wrappedValue.dismiss()
                                    } else {
                                        // Show discard confirmation
                                        isDiscarding = true
                                    }
                                }) {
                                    Text(isDiscarding ? "Discard" : "Discard")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.appRed)
                                        .cornerRadius(8)
                                }
                                
                                Spacer()
                                
                                if isDiscarding {
                                    Button(action: {
                                        showAlert = false
                                        isDiscarding = false
                                    }) {
                                        Text("Keep")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.appGreen)
                                            .cornerRadius(8)
                                    }
                                } else {
                                    Button(action: {
                                        saveNote()
                                        showAlert = false
                                    }) {
                                        Text("Save")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.appGreen)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: 300, height: 200)
                        .background(Color.appBlack)
                        .cornerRadius(12)
                        .shadow(radius: 20)
                    }
                }
            )
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
            showAlert = true
            isDiscarding = false
        }) {
            Image("save")
                .scaledToFit()
                .frame(width: 48, height: 48)
                .background(Color("appGray"))
                .cornerRadius(15)
        }
    }

    private func saveNote() {
        let newNote = Note(title: titleText, body: bodyText)
        notesManager.notes.append(newNote)
        
        titleText = ""
        bodyText = ""
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        let notesManager = NotesManager()
        return NotesView(notesManager: notesManager)
    }
}

#Preview {
    ContentView()
}
