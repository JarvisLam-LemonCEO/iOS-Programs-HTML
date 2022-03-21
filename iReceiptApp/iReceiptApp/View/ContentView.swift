//
//  ContentView.swift
//  iReceiptApp
//
//  Created by Jarvis Lam on 2/18/22.
//

import SwiftUI

struct ContentView: View {
    @State var showImagePicker: Bool = false
    @StateObject var imageData = ImageData()
    
    var body: some View {
        NavigationView {
            VStack {
                if imageData.imageNote.isEmpty {
                    Text("Try adding a receipt!")
                        .italic()
                        .foregroundColor(.gray)
                } else {
                    HomeView()
                }
            }
            .navigationTitle("iReceipt")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) {
                    image in
                    imageData.addNote(image: image, title: "Edit me!", desc: "")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        Label("Image", systemImage: "photo.on.rectangle.angled")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            imageData.resetUserData()
                        }
                    } label : {
                        Label("Trash", systemImage: "trash")
                    }
                    .tint(.red)
                }
                
            }
        }
        .environmentObject(imageData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
