//
//  NotesManager.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//
//
//import SwiftUI
//import Combine
//
//class NotesManager: ObservableObject {
//    @Published var notes: [Note] = []
//}

import CoreData
import Combine

class NotesManager: ObservableObject {
    @Published var notes: [Note] = []
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchNotes()
    }

    func fetchNotes() {
        let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
        do {
            let noteDataArray = try context.fetch(request)
            self.notes = noteDataArray.map { Note(title: $0.title ?? "", body: $0.body ?? "") }
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }

    func saveNote(title: String, body: String) {
        let newNote = NoteData(context: context)
        newNote.title = title
        newNote.body = body
        newNote.timestamp = Date() // Assuming you have a timestamp attribute

        do {
            try context.save()
            fetchNotes() // Refresh the notes list
        } catch {
            print("Failed to save note: \(error)")
        }
    }
}
