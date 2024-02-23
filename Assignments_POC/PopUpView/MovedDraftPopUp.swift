//
//  MovedDraftPopUpView.swift
//  Assignments_POC
//
//  Created by Arjunan on 26/10/23.
//

import SwiftUI

struct MovedDraftPopUpView: View {
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea(edges: .all)
            VStack(alignment: .center,spacing: 40) {
                popUpImageView
                AssignmentMoveToDraftView
                doneButtonViewView
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .padding(24)
        }
    }
    
    @ViewBuilder var popUpImageView: some View {
        HStack(alignment: .center, spacing: 10) {
            Image("draftImage")
                .resizable()
                .frame(width: 56,height: 56)
        }
        .padding(24)
        .frame(width: 92, height: 92, alignment: .center)
        .background(Color(hex: "#F3F4F6"))
        .cornerRadius(63)                
    }
    
    @ViewBuilder var AssignmentMoveToDraftView: some View {
        VStack(alignment: .center,spacing: 16) {
            HStack {
                Text("Assignment Moved to Draft")
                    .font(
                        Font.custom("SF Pro Text", size: 22)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#374151"))
                
            }
            HStack {
                Text("Thank you for your effort. Your assignment has been successfully moved to the Draft state. You can make further edits and submit it later")
                
                    .font(Font.custom("SF Pro Text", size: 15))
                    .foregroundColor(Color(hex: "#9CA3AF"))
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder var doneButtonViewView: some View {
        
        HStack {
            Button(action: {
                
            }, label: {
                Text("Done")
                    .font(
                        Font.custom("SF Pro Text", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(.white)
                    .padding(16)
                    .frame(height: 40)
                    .padding(.horizontal,30)
                    .background(Color(hex: "#147AFC"))
                    .cornerRadius(40)
            })
            
        }
    }
}

struct MovedDraftPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        MovedDraftPopUpView()
    }
}
