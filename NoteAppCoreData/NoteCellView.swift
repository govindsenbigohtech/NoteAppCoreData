//
//  NoteCellView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.


import SwiftUI

struct NoteCellView: View {
    var note: Note
    let colors: [Color] = [
        Color("appFaceColor"),
        Color("appLightGreen"),
        Color("appLightYellow"),
        Color("appPink"),
        Color("appPurple"),
        Color("appSky")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.custom("Nunito-Regular", size: 35))
                .foregroundColor(Color("appGray"))
                .lineLimit(1)
            Text(note.body)
                .font(.custom("Nunito-Regular", size: 23))
                .foregroundColor(Color("appGray"))
                .lineLimit(1)
        }
        .padding()
        .background(randomColor())
        .cornerRadius(10)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24) 
    }
    
    private func randomColor() -> Color {
        return colors.randomElement() ?? Color.white
    }
}
