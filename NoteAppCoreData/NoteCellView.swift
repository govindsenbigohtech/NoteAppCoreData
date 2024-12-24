//
//  NoteCellView.swift
//  NoteAppCoreData
//
//  Created by Govind-BigOh on 23/12/24.


//import SwiftUI
//
//struct NoteCellView: View {
//    var note: Note
//    @ObservedObject var notesManager: NotesManager // Add this line
//    let colors: [Color] = [
//        Color("appFaceColor"),
//        Color("appLightGreen"),
//        Color("appLightYellow"),
//        Color("appPink"),
//        Color("appPurple"),
//        Color("appSky")
//    ]
//    
//    var body: some View {
//        NavigationLink(destination: NotesView(notesManager: notesManager, note: note)) { // Pass notesManager here
//            VStack(alignment: .leading) {
//                Text(note.title)
//                    .font(.custom("Nunito-Regular", size: 35))
//                    .foregroundColor(Color("appGray"))
//                    .lineLimit(1)
//                Text(note.body)
//                    .font(.custom("Nunito-Regular", size: 23))
//                    .foregroundColor(Color("appGray"))
//                    .lineLimit(1)
//            }
//            .padding()
//            .background(randomColor().opacity(0.8))
//            .cornerRadius(10)
//            .frame(maxWidth: .infinity)
//            .padding(.vertical, 10)
//            .padding(.horizontal, 24)
//        }
//    }
//    
//    private func randomColor() -> Color {
//        return colors.randomElement() ?? Color.clear
//    }
//}

//import SwiftUI
//
//struct NoteCellView: View {
//    var note: Note
//    @ObservedObject var notesManager: NotesManager
//    let colors: [Color] = [
//        Color("appFaceColor"),
//        Color("appLightGreen"),
//        Color("appLightYellow"),
//        Color("appPink"),
//        Color("appPurple"),
//        Color("appSky")
//    ]
//    
//    var body: some View {
//        NavigationLink(destination: NotesView(notesManager: notesManager, note: note)) {
//            VStack(alignment: .leading) {
//                Text(note.title)
//                    .font(.custom("Nunito-Regular", size: 35))
//                    .foregroundColor(Color("appGray"))
//                    .lineLimit(1)
//                Text(note.body)
//                    .font(.custom("Nunito-Regular", size: 23))
//                    .foregroundColor(Color("appGray"))
//                    .lineLimit(1)
//            }
//            .padding()
//            .background(randomColor().opacity(0.8))
//            .cornerRadius(10)
//            .frame(maxWidth: .infinity) // This line ensures the cell takes the full width
//            .padding(.horizontal, 24) // Add horizontal padding here
//            .padding(.vertical, 10) // Maintain vertical padding
//        }
//    }
//    
//    private func randomColor() -> Color {
//        return colors.randomElement() ?? Color.clear
//    }
//}


import SwiftUI
//
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
            .background(Color.clear) // Set the background to clear
            .cornerRadius(10)
            .frame(maxWidth: .infinity) // Ensure the cell takes the full width
            .padding(.horizontal, 24) // Add horizontal padding
            .padding(.vertical, 10) // Maintain vertical padding
        }
        .background(randomColor().opacity(0.8)) // Apply the random color to the NavigationLink background
        .cornerRadius(10) // Ensure the corner radius is applied to the NavigationLink
        .padding(.bottom, 20)
    }
    
    private func randomColor() -> Color {
        return colors.randomElement() ?? Color.clear
    }
}

//import SwiftUI
//
//struct NoteCellView: View {
//    var note: Note
//    @ObservedObject var notesManager: NotesManager
//    let colors: [Color] = [
//        Color("appFaceColor"),
//        Color("appLightGreen"),
//        Color("appLightYellow"),
//        Color("appPink"),
//        Color("appPurple"),
//        Color("appSky")
//    ]
//    
//    var body: some View {
//        NavigationLink(destination: NotesView(notesManager: notesManager, note: note)) {
//            VStack(alignment: .leading) {
//                Text(note.title)
//                    .font(.custom("Nunito-Regular", size: 35))
//                    .foregroundColor(Color("appGray"))
//                    .lineLimit(1)
//                Text(note.body)
//                    .font(.custom("Nunito-Regular", size: 23))
//                    .foregroundColor(Color("appGray"))
//                    .lineLimit(1)
//            }
//            .padding() // Padding inside the cell
//            .background(randomColor().opacity(0.8)) // Background color for the cell
//            .cornerRadius(10)
//            .frame(maxWidth: .infinity) // Ensure the cell takes the full width
//        }
////        .padding(.horizontal, 24) // Leading and trailing padding for the cell
////        .padding(.vertical, 10) // Maintain vertical padding for the cell
//        .padding(.bottom, 20) // Add bottom padding to create space between cells
//    }
//    
//    private func randomColor() -> Color {
//        return colors.randomElement() ?? Color.clear
//    }
//}
