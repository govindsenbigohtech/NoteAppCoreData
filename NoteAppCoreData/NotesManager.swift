//
//  NotesManager.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//
//
//import SwiftUI
//import Combine
//import CoreData
//
//class NotesManager: ObservableObject {
//    @Published var notes: [Note] = []
//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//        fetchNotes()
//    }
//
//    func fetchNotes() {
//        let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
//        do {
//            let noteDataArray = try context.fetch(request)
//            self.notes = noteDataArray.map { Note(title: $0.title ?? "", body: $0.body ?? "") }
//        } catch {
//            print("Failed to fetch notes: \(error)")
//        }
//    }
//
//    
//    func saveNote(title: String, body: String, noteToUpdate: Note? = nil) {
//        if let noteToUpdate = noteToUpdate {
//            // Update existing note
//            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
//            request.predicate = NSPredicate(format: "title == %@ AND body == %@", noteToUpdate.title, noteToUpdate.body)
//            do {
//                let noteDataArray = try context.fetch(request)
//                if let noteData = noteDataArray.first {
//                    noteData.title = title
//                    noteData.body = body
//                    noteData.timestamp = Date()
//                    try context.save()
//                    fetchNotes() // Refresh the notes list after saving
//                }
//            } catch {
//                print("Failed to update note: \(error)")
//            }
//        } else {
//            // Create new note
//            let newNote = NoteData(context: context)
//            newNote.title = title
//            newNote.body = body
//            newNote.timestamp = Date()
//
//            do {
//                try context.save()
//                fetchNotes()
//            } catch {
//                print("Failed to save note: \(error)")
//            }
//        }
//    }
//
//    func deleteNote(at offsets: IndexSet) {
//        offsets.map { notes[$0] }.forEach { note in
//            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
//            request.predicate = NSPredicate(format: "title == %@ AND body == %@", note.title, note.body)
//            do {
//                let noteDataArray = try context.fetch(request)
//                for noteData in noteDataArray {
//                    context.delete(noteData)
//                }
//                try context.save()
//                fetchNotes() 
//            } catch {
//                print("Failed to delete note: \(error)")
//            }
//        }
//    }
//}

//import SwiftUI
//import Combine
//import CoreData
//
//class NotesManager: ObservableObject {
//    @Published var notes: [Note] = []
//    private let context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.context = context
//        fetchNotes()
//    }
//    
//    func fetchNotes() {
//        let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
//        do {
//            let noteDataArray = try context.fetch(request)
//            // Sort notes by timestamp in descending order
//            self.notes = noteDataArray.map { Note(title: $0.title ?? "", body: $0.body ?? "", timestamp: $0.timestamp ?? Date()) }
//                .sorted(by: { $0.timestamp > $1.timestamp }) // Sort by timestamp
//        } catch {
//            print("Failed to fetch notes: \(error)")
//        }
//    }
//
////    func fetchNotes() {
////        let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
////        do {
////            let noteDataArray = try context.fetch(request)
////            // Sort notes by timestamp in descending order
////            self.notes = noteDataArray.map { Note(title: $0.title ?? "", body: $0.body ?? "", timestamp: <#Date#>) }
////                .sorted(by: { $0.timestamp > $1.timestamp }) // Assuming Note has a timestamp property
////        } catch {
////            print("Failed to fetch notes: \(error)")
////        }
////    }
//
//    func saveNote(title: String, body: String, noteToUpdate: Note? = nil) {
//        if let noteToUpdate = noteToUpdate {
//            // Update existing note
//            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
//            request.predicate = NSPredicate(format: "title == %@ AND body == %@", noteToUpdate.title, noteToUpdate.body)
//            do {
//                let noteDataArray = try context.fetch(request)
//                if let noteData = noteDataArray.first {
//                    noteData.title = title
//                    noteData.body = body
//                    noteData.timestamp = Date()
//                    try context.save()
//                    // Update the notes array to reflect the changes
//                    if let index = notes.firstIndex(where: { $0.id == noteToUpdate.id }) {
//                        notes[index] = Note(title: title, body: body, timestamp: <#Date#>)
//                    }
//                }
//            } catch {
//                print("Failed to update note: \(error)")
//            }
//        } else {
//            // Create new note
//            let newNote = NoteData(context: context)
//            newNote.title = title
//            newNote.body = body
//            newNote.timestamp = Date()
//
//            do {
//                try context.save()
//                // Add the new note to the beginning of the notes array
//                notes.insert(Note(title: title, body: body), at: 0)
//            } catch {
//                print("Failed to save note: \(error)")
//            }
//        }
//    }
//
//    func deleteNote(at offsets: IndexSet) {
//        offsets.map { notes[$0] }.forEach { note in
//            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
//            request.predicate = NSPredicate(format: "title == %@ AND body == %@", note.title, note.body)
//            do {
//                let noteDataArray = try context.fetch(request)
//                for noteData in noteDataArray {
//                    context.delete(noteData)
//                }
//                try context.save()
//                fetchNotes() // Refresh the notes list after saving
//            } catch {
//                print("Failed to delete note: \(error)")
//            }
//        }
//    }
//}

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
            // Sort notes by timestamp in descending order
            self.notes = noteDataArray.map { Note(title: $0.title ?? "", body: $0.body ?? "", timestamp: $0.timestamp ?? Date()) }
                .sorted(by: { $0.timestamp > $1.timestamp }) // Sort by timestamp
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }

    func saveNote(title: String, body: String, noteToUpdate: Note? = nil) {
        if let noteToUpdate = noteToUpdate {
            // Update existing note
            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@ AND body == %@", noteToUpdate.title, noteToUpdate.body)
            do {
                let noteDataArray = try context.fetch(request)
                if let noteData = noteDataArray.first {
                    noteData.title = title
                    noteData.body = body
                    noteData.timestamp = Date() // Update timestamp to current date
                    try context.save()
                    
                    // Update the notes array to reflect the changes
                    if let index = notes.firstIndex(where: { $0.title == noteToUpdate.title && $0.body == noteToUpdate.body }) {
                        notes[index] = Note(title: title, body: body, timestamp: noteData.timestamp ?? Date()) // Use the updated timestamp
                    }
                }
            } catch {
                print("Failed to update note: \(error)")
            }
        } else {
            // Create new note
            let newNote = NoteData(context: context)
            newNote.title = title
            newNote.body = body
            newNote.timestamp = Date() // Set timestamp to current date

            do {
                try context.save()
                // Add the new note to the beginning of the notes array
                notes.insert(Note(title: title, body: body, timestamp: newNote.timestamp ?? Date()), at: 0) // Use the new note's timestamp
            } catch {
                print("Failed to save note: \(error)")
            }
        }
    }

    func deleteNote(at offsets: IndexSet) {
        offsets.map { notes[$0] }.forEach { note in
            let request: NSFetchRequest<NoteData> = NoteData.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@ AND body == %@", note.title, note.body)
            do {
                let noteDataArray = try context.fetch(request)
                for noteData in noteDataArray {
                    context.delete(noteData)
                }
                try context.save()
                fetchNotes() // Refresh the notes list after saving
            } catch {
                print("Failed to delete note: \(error)")
            }
        }
    }
}
