//
//  ProgressLoader.swift
//  Staff_Attendance
//
//  Created by Fazil on 2/2/23.
//  Copyright © 2023 adminstrator. All rights reserved.
//

import SwiftUI

struct ProgressLoader: ViewModifier {
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
                .disabled(self.isShowing)
            
            VStack {
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }
            .frame(width: 80, height: 80)
            .background(Color.black.opacity(0.5))
            .foregroundColor(Color.primary)
            .cornerRadius(10)
            .opacity(self.isShowing ? 1 : 0)
            
        }
    }
}

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(style: style)
        loader.color = UIColor.white
        return loader
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

extension View {
    func loader(isShown: Binding<Bool>) -> some View {
        modifier(ProgressLoader(isShowing: isShown))
    }
}
