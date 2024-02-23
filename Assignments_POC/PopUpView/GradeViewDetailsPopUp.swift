//
//  GradeFinalizedPopUpView.swift
//  Assignments_POC
//
//  Created by Arjunan on 27/10/23.
//

import SwiftUI

struct GradeViewDetailsPopUp: View {
    @State var sessionStatusScrollSize: CGSize = .zero
    @State var sessionInprogressScrollSize: CGSize = .zero
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.1)
                .ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                VStack(alignment: .leading,spacing: 16){
                    VStack(alignment: .leading,spacing: 16){
                        descriptionImageView
                    }
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollSizePreferenceKey.self, value: geometry.frame(in: .named("sessionStatusScroll")).size)
                    })
                    .onPreferenceChange(ScrollSizePreferenceKey.self) { value in
                        self.sessionInprogressScrollSize = value
                    }
                    ScrollView(.vertical,showsIndicators: false) {
                        VStack(alignment: .leading,spacing: 16) {
                            assignmentNameView
                        }
                        .background(GeometryReader { geometry in
                            Color.clear
                                .preference(key: ScrollSizePreferenceKey.self, value: geometry.frame(in: .named("sessionStatusScroll")).size)
                        })
                        .onPreferenceChange(ScrollSizePreferenceKey.self) { value in
                            self.sessionStatusScrollSize = value
                        }
                        .padding(.bottom,40)
                    }
                    .frame(height: sessionStatusViewscrollHeight )
                    
                }
                .padding(.top)
                .padding(.horizontal, 24)
                .background(Color.white)
                .cornerRadius(16,corners: [.topLeft,.topRight])
            }            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
    
    
    
    
    @ViewBuilder var descriptionImageView: some View {
        VStack(alignment: .leading,spacing: 16) {
            ZStack(alignment: .top) {
                HStack(spacing: 5){
                    Image("gradeFinalized")
                        .resizable()
                        .frame(width: 56,height: 56)
                        .foregroundColor(Color(hex: "#16A34A"))
                }
                .padding(24)
                .frame(width: 92, height: 92, alignment: .center)
                .background(Color(hex: "#EFF9FB"))
                .cornerRadius(63)
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 14,height: 14)
                            .foregroundColor(Color.black)
                    })
                }
            }
            titleView
        }
    }
    
    @ViewBuilder var titleView: some View {
        VStack(alignment: .leading,spacing: 4){
            HStack{
                Text("FUND 222 - Fundamentals of Human Body ")
                    .font(
                        Font.custom("SF Pro Text", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
            }
            HStack {
                Text("Year 1")
                    .foregroundColor(Color(hex: "#6B7280"))
                Text("|")
                    .foregroundColor(Color(hex: "#9CA3AF"))
                Text("Level : 01")
                    .foregroundColor(Color(hex: "#6B7280"))
            }
            .font(
                Font.custom("SF Pro Text", size: 14)
                    .weight(.medium)
            )
        }
    }
    
    @ViewBuilder var assignmentNameView: some View {
        VStack(alignment: .leading,spacing: 16) {
            VStack(alignment: .leading,spacing: 4) {
                HStack{
                    Text("No. Of Assignment : 04")
                        .font(
                            Font.custom("SF Pro Text", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(hex: "#4B5563"))
                }
                
            }
            assignmentResultView
            gradeCutOffView
            assignmentDetailsView
        }
    }
    
    @ViewBuilder var assignmentResultView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Assignment Results")
                    .font(
                        Font.custom("SF Pro Text", size: 15)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
            }
        }
    }
    @ViewBuilder var gradeCutOffView: some View {
        VStack(alignment: .leading,spacing: 11) {
            gradeView
            cutOffStatusView
            obtainedMarkView
        }
    }
    
    @ViewBuilder var gradeView: some View {
        HStack {
            Text("Grade : ")
                .font(Font.custom("SF Pro Text", size: 11))
                .foregroundColor(Color(hex: "#6B7280"))
            Spacer()
            Text("A")
                .font(
                    Font.custom("SF Pro Text", size: 14)
                        .weight(.medium)
                )
                .foregroundColor(Color(hex: "#16A34A"))
        }
    }
    
    @ViewBuilder var cutOffStatusView: some View {
        HStack {
            Text("Cut Off Status : ")
                .font(Font.custom("SF Pro Text", size: 11))
                .foregroundColor(Color(hex: "#6B7280"))
            Spacer()
            Text("Achieved")
                .font(
                    Font.custom("SF Pro Text", size: 14)
                        .weight(.medium)
                )
                .foregroundColor(Color(hex:"#16A34A"))
        }
    }
    @ViewBuilder var obtainedMarkView: some View {
        HStack {
            Text("Obtained mark / % :")
                .font(Font.custom("SF Pro Text", size: 11))
                .foregroundColor(Color(hex: "#6B7280"))
            Spacer()
            HStack(spacing: 8){
                HStack(alignment: .center,spacing: 1){
                    Text("05")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151"))
                    Text("Out of 20")
                        .font(Font.custom("SF Pro Text", size: 12))
                        .foregroundColor(Color(hex: "#9CA3AF"))
                }
                Text("/")
                    .font(Font.custom("SF Pro Text", size: 14))
                    .foregroundColor(Color(hex: "#374151" ))
                Text("25%")
                    .font(Font.custom("SF Pro Text", size: 14))
                    .foregroundColor(Color(hex: "#374151"))
            }
        }
    }
    @ViewBuilder var assignmentDetailsView: some View {
        VStack(alignment: .leading,spacing: 16) {
            HStack {
                Text("Assignment Details")
                    .font(
                        Font.custom("SF Pro Text", size: 15)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
            }
            HStack {
                Text("Published By : ")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex:"#6B7280"))
                Spacer()
                Text("Dr. Staff name1")
                    .font(Font.custom("SF Pro Text", size: 14))
                    .foregroundColor(Color(hex: "#374151"))
            }
            obtainedMarkView2
            finalObtainedMarkView
            markEquivalanceView
            extraMarksView
            markAdjustmentView
            detuctMarksView
        }
    }
    
    @ViewBuilder var obtainedMarkView2: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Obtained mark / % :")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#6B7280"))
                Spacer()
                HStack(spacing: 8){
                    HStack(spacing: 1){
                        Text("05")
                            .font(Font.custom("SF Pro Text", size: 14))
                            .foregroundColor(Color(hex: "#374151"))
                        Text("Out of 20")
                            .font(Font.custom("SF Pro Text", size: 12))
                            .foregroundColor(Color(hex: "#9CA3AF"))
                    }
                    Text("/")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151" ))
                    Text("25%")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151"))
                }
                
            }
            HStack {
                Text("Before extra & deduction marks")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#9CA3AF"))
            }
        }
    }
    
    @ViewBuilder var finalObtainedMarkView: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Final Obtained mark / % :")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#6B7280"))
                Spacer()
                HStack(spacing: 8){
                    HStack(alignment: .center,spacing: 1){
                        Text("05")
                            .font(Font.custom("SF Pro Text", size: 14))
                            .foregroundColor(Color(hex: "#374151"))
                        Text("Out of 20")
                            .font(Font.custom("SF Pro Text", size: 12))
                            .foregroundColor(Color(hex: "#9CA3AF"))
                    }
                    Text("/")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151" ))
                    Text("25%")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151"))
                }
                
            }
            HStack {
                Text("After extra & deduction marks")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#9CA3AF"))
            }
        }
    }
    
    @ViewBuilder var markEquivalanceView: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Mark Equivalence :")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#6B7280"))
                Spacer()
                HStack(spacing: 8){
                    HStack(alignment: .center,spacing: 1){
                        Text("05")
                            .font(Font.custom("SF Pro Text", size: 14))
                            .foregroundColor(Color(hex: "#374151"))
                    }
                    Text("/")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151" ))
                    Text("25%")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#374151"))
                }
                
            }
            HStack {
                Text("Equivalent to 50 marks")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#9CA3AF"))
            }
        }
    }
    
    @ViewBuilder var extraMarksView: some View {
        HStack {
            Text("Extra marks :")
                .font(Font.custom("SF Pro Text", size: 11))
                .foregroundColor(Color(hex: "#6B7280"))
            Spacer()
            Text("02")
                .font(
                    Font.custom("SF Pro Text", size: 14)
                        .weight(.medium)
                )
                .foregroundColor(Color(hex: "#374151"))
        }
    }
    
    @ViewBuilder var markAdjustmentView: some View {
        VStack(alignment: .leading,spacing: 2) {
            HStack {
                Text("Marks Adjustment :")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#6B7280"))
                Spacer()
                Text("02")
                    .font(
                        Font.custom("SF Pro Text", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#374151"))
            }
            HStack {
                Text("Reason...")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#9CA3AF"))
            }
        }
    }
    
    @ViewBuilder var detuctMarksView: some View {
        VStack(alignment: .leading,spacing: 2) {
            HStack {
                Text("Deduct Marks")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#6B7280"))
                Spacer()
                Text("02")
                    .font(
                        Font.custom("SF Pro Text", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#374151"))
            }
            HStack {
                Text("Reason...")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#9CA3AF"))
            }
        }
    }
    
    var sessionStatusViewscrollHeight: CGFloat {
        let screenHeight:CGFloat = UIScreen.main.bounds.height - 44 - sessionInprogressScrollSize.height
        let height = sessionStatusScrollSize.height
        return height > screenHeight ? screenHeight : height
    }
}

struct GradeFinalizedPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        GradeViewDetailsPopUp()
    }
}

struct ScrollSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        
    }
}
