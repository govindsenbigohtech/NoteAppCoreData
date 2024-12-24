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
                
                // Main Content
                VStack {
                    headerView
                    
                    if notesManager.notes.isEmpty {
                        emptyStateView
                    } else {
                        notesListView
                            .padding(.bottom, 50)
                    }
                }
                
                VStack {
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
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 24, bottom: 25, trailing: 24))
            }
            .onDelete(perform: deleteNotes)
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
        .padding(.top, 10)
    }
    
    private var addButton: some View {
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
    }
}

#Preview {
    ContentView()
}

