//
//  NoteDataModel.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.
//

import Foundation

struct Note: Identifiable {
    let id = UUID()
    var title: String
    var body: String
    var timestamp: Date
}
