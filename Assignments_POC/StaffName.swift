import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
       //         .foregroundColor(Color("Teal"))
       //         .background(Color("Grey"))

                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets.init(top: 0, leading: 30, bottom: 0, trailing: 20))
                        // Search icon
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }, label: {
                                Image(systemName: "multiply.circle")
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 30))
                                // Delete button
                            })
                        }
                    }
                ).onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing{
                Button(action: {
                    self.isEditing = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    // Hide delete button when search bar is not selected
                }){
                }
            }
        }
    }
}

struct ContentView: View {
    @State var searchText = ""
    var body: some View {
        SearchBar(text: $searchText)
            .frame(width: 222, height: 55).padding(.horizontal, 20)
            .border(.red)
    }
}
