//
//  NotesManager.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//
//
import SwiftUI
import Combine
import CoreData

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
        newNote.timestamp = Date()

        do {
            try context.save()
            fetchNotes()
        } catch {
            print("Failed to save note: \(error)")
        }
    }

    func deleteNote(at offsets: IndexSet) {
        offsets.map { notes[$0] }.forEach { note in
            // Find the corresponding NoteData object
            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@ AND body == %@", note.title, note.body)
            do {
                let noteDataArray = try context.fetch(request)
                for noteData in noteDataArray {
                    context.delete(noteData)
                }
                try context.save()
                fetchNotes() // Refresh the notes list
            } catch {
                print("Failed to delete note: \(error)")
            }
        }
    }
}
