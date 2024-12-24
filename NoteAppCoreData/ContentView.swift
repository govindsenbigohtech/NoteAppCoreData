//
//  ContentView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var notesManager: NotesManager
    
    init() {
        _notesManager = StateObject(wrappedValue: NotesManager(context: PersistenceController.shared.container.viewContext))
    }
    
    private func deleteNotes(at offsets: IndexSet) {
        notesManager.deleteNote(at: offsets)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("appBlack")
                    .ignoresSafeArea()
                
                VStack {
                    headerView
                    
                    if notesManager.notes.isEmpty {
                        emptyStateView
                    } else {
                        notesListView
                    }
                    
                    Spacer()
                    
                    addButton
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Notes")
                .font(.system(size: 43, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
            }) {
                Image("search")
                    .scaledToFill()
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
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image("notesImg")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 286.73) 
                
            Text("Create your first note!")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 20)
    }
    
    private var notesListView: some View {
        List {
            ForEach(notesManager.notes) { note in
                NoteCellView(note: note, notesManager: notesManager)
                    .listRowInsets(EdgeInsets())
            }
            .onDelete(perform: deleteNotes)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
        .padding(.top, 10)
    }
    
    private var addButton: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: NotesView(notesManager: notesManager)) {
                Image("add")
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

struct NotesView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var notesManager: NotesManager
    
    @State private var titleText: String = ""
    @State private var bodyText: String = ""
    @State private var showAlert: Bool = false
    @State private var isDiscarding: Bool = false
    @State private var isEditing: Bool = false
    var note: Note?

    init(notesManager: NotesManager, note: Note? = nil) {
        self.notesManager = notesManager
        self.note = note
        if let note = note {
            _titleText = State(initialValue: note.title)
            _bodyText = State(initialValue: note.body)
        }
    }

    var body: some View {
        ZStack {
            Color("appBlack")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    backButton
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    if note == nil {
                        Button(action: {
                            saveNote()
                        }) {
                            Image("save")
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .background(Color("appGray"))
                                .cornerRadius(15)
                        }
                        .padding(.trailing, 25)
                    } else {
                        Button(action: {
                            if isEditing {
                                showAlert = true
                            }
                            isEditing.toggle()
                        }) {
                            Image(isEditing ? "save" : "edit")                                 .scaledToFit()
                                .frame(width: 48, height: 48)
                                .background(Color("appGray"))
                                .cornerRadius(15)
                        }
                        .padding(.trailing, 25)
                    }
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
                    .disabled(note != nil && !isEditing)
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
                    .disabled(note != nil && !isEditing)
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
                            Image("info")
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.top)
                            
                            Text(isDiscarding ? "Are you sure you want to discard your changes?" : "Save Changes?")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()

                            HStack {
                                Button(action: {
                                    if isDiscarding {
                                        titleText = ""
                                        bodyText = ""
                                        presentationMode.wrappedValue.dismiss()
                                    } else {
                                        isDiscarding = true
                                    }
                                }) {
                                    Text(isDiscarding ? "Discard" : "Discard")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
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
                                            .background(Color.green)
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
                                            .background(Color.green)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: 300, height: 300)
                        .background(Color("appBlack"))
                        .cornerRadius(12)
                        .shadow(radius: 20)
                        .padding()
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
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
    }
    
    private func saveNote() {
        notesManager.saveNote(title: titleText, body: bodyText, noteToUpdate: note)
        
        titleText = ""
        bodyText = ""
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController(inMemory: true)
        let notesManager = NotesManager(context: persistenceController.container.viewContext)
        
        return NotesView(notesManager: notesManager)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

#Preview {
    ContentView()
}

