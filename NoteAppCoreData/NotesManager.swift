//
//  NotesManager.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//

import SwiftUI
import Combine

class NotesManager: ObservableObject {
    @Published var notes: [Note] = []
}
