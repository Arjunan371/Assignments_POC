//
//  SubmittedPopUpView.swift
//  Assignments_POC
//
//  Created by Arjunan on 26/10/23.
//

import SwiftUI

struct SubmittedPopUpView: View {
    var body: some View {
        ZStack{
            Color.black.opacity(0.3)
                .ignoresSafeArea(edges: .all)
            
            VStack(alignment: .center, spacing: 40){
                congratulationsImageView
                congratulationsTextContentView
                doneButtonViewView
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            .padding(24)
        }
    }
    @ViewBuilder var congratulationsImageView: some View {
        VStack(alignment: .center){
            Image("submitCompleteImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 180)
        }
    }
    
    @ViewBuilder var congratulationsTextContentView: some View {
        VStack(alignment: .center,spacing: 16) {
            HStack {
                Text("Congratulations!")
                    .font(                                         Font.custom("SF Pro Text", size: 22)
                        .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#374151" ))
            }
            HStack {
                VStack {
                    Text("Your assignment has been successfully submitted. Thank you for your hard work and dedication")
                }
                .font(Font.custom("SF Pro Text", size: 15))
                .foregroundColor(Color(hex: "#9CA3AF"))
                .multilineTextAlignment(.center)
            }
        }
    }
    
    @ViewBuilder var doneButtonViewView: some View {
        HStack {
            Button(action: {}, label: {
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

struct SubmittedPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        SubmittedPopUpView()
    }
}
