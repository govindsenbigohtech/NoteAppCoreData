//
//  NoteCellView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.


import SwiftUI

struct NoteCellView: View {
    var note: Note
    @ObservedObject var notesManager: NotesManager
    let colors: [Color] = [
        Color("appFaceColor"),
        Color("appLightGreen"),
        Color("appLightYellow"),
        Color("appPink"),
        Color("appPurple"),
        Color("appSky")
    ]
    
    var body: some View {
        NavigationLink(destination: NotesView(notesManager: notesManager, note: note)) {
            VStack(alignment: .leading, spacing: 10) {
                Text(note.title)
                    .font(Font.customFont(family: .nunito, sizeFamily: .regular, size: 35))
                    .foregroundColor(Color("appGray"))
                    .lineLimit(1)
                
                Text(note.body)
                    .font(Font.customFont(family: .nunito, sizeFamily: .regular, size: 23))

                    .foregroundColor(Color("appGray"))
                    .lineLimit(1)
            }
            .padding()
            .background(Color.clear)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
        }
        .background(randomColor().opacity(0.8))
        .cornerRadius(10)
    }
    
    private func randomColor() -> Color {
        return colors.randomElement() ?? Color.clear
    }
}

