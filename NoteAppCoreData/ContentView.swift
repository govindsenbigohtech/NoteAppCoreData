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
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(12)
            }
            .background(Color("appGray"))
            .cornerRadius(15)
            .frame(width: 50, height: 50)
            .padding(.trailing, 25)
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
                    .listRowBackground(Color.clear) // Clear row background
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)) // Add insets
            }
            .onDelete(perform: deleteNotes)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear) // Clear list background
        .onAppear {
            UITableView.appearance().backgroundColor = .clear // Clear UITableView background
            UITableViewCell.appearance().backgroundColor = .clear // Clear UITableViewCell background
        }
        .padding(.top, 10)
    }

    
//    private var notesListView: some View {
//        List {
//            ForEach(notesManager.notes) { note in
//                NoteCellView(note: note, notesManager: notesManager)
//                    .listRowBackground(Color.clear) // Ensure clear background for rows
//                    .listRowInsets(EdgeInsets())
//            }
//            .onDelete(perform: deleteNotes)
//        }
//        .listStyle(PlainListStyle())
//        .background(Color.clear) // Clear background for the entire list
//        .onAppear {
//            UITableView.appearance().backgroundColor = .clear // Clear table view background
//            UITableViewCell.appearance().backgroundColor = .clear // Clear cell background
//        }
//        .padding(.top, 10)
//    }

    
//    private var notesListView: some View {
//        List {
//            ForEach(notesManager.notes) { note in
//                NoteCellView(note: note, notesManager: notesManager)
//                    .listRowInsets(EdgeInsets())
//            }
//            .onDelete(perform: deleteNotes)
//        }
//        .listStyle(PlainListStyle())
//        .background(Color.clear)
//        .padding(.top, 10)
//    }
    
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

#Preview {
    ContentView()
}

