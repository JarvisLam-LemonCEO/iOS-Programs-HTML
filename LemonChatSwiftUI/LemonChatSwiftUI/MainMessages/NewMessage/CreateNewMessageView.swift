//
//  NewMessageView.swift
//  LemonChatSwiftUI
//
//  Created by Jarvis Lam on 12/29/21.
//

import SwiftUI
import SDWebImageSwiftUI

class CreateNewMessageViewMosel: ObservableObject {
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers(){
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documunetsSnapshot, error in
                if let error = error {
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                documunetsSnapshot?.documents.forEach({ snapshot in
                    snapshot.data()
                    let data = snapshot.data()
                    let user = ChatUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                })
                self.errorMessage = "Fetched users successfully"
            }
    }
}

struct CreateNewMessageView: View {
    
    let didSelectNewUser: (ChatUser)-> ()
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = CreateNewMessageViewMosel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(vm.errorMessage)
                
                ForEach(vm.users) { user in
                    Button{
                        presentationMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
                    } label: {
                        
                        HStack {
                            WebImage(url: URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(50)
                                .overlay(RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color(.label), lineWidth: 2
                                                   ))
                            Text(user.email)
                                .foregroundColor(Color(.label))
                            Spacer()
                        }.padding(.horizontal)
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
            }.navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        //CreateNewMessageView()
        MainMessagesView()
    }
}
