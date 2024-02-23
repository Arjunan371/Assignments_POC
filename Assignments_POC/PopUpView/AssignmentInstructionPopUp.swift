//
//  AssignmentDescriptionView.swift
//  Assignments_POC
//
//  Created by Arjunan on 27/10/23.
//

import SwiftUI

struct AssignmentInstructionPopUpView: View {
    @State var sessionStatusScrollSize: CGSize = .zero
    @State var sessionInprogressScrollSize: CGSize = .zero
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.3)
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
                .padding([.top,.horizontal])
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
                HStack(alignment: .center, spacing: 5){
                    Image("draftImage")
                        .resizable()
                        .frame(width: 56,height: 56)
                        .foregroundColor(Color(hex: "#147AFC"))
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
                    Text("Assignment name")
                        .font(
                            Font.custom("SF Pro Text", size: 16)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(hex: "#4B5563"))
                }
                HStack {
                    Text("Subject")
                        .font(
                            Font.custom("SF Pro Text", size: 14)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(hex: "#4B5563"))
                }
            }
            totalAttemptsOutcomeView
            instructionDescriptionView
        }
    }
    
    @ViewBuilder var totalAttemptsOutcomeView: some View {
        VStack(alignment: .leading,spacing: 11) {
            HStack{
                Text("Total Attempts : ")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex:
                                            "#6B7280"))
                Spacer()
                Text("3")
                    .font(
                        Font.custom("SF Pro Text", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
            }
            HStack {
                Text("Learning Outcome : ")
                    .font(Font.custom("SF Pro Text", size: 11))
                    .foregroundColor(Color(hex: "#6B7280"))
                Spacer()
                Text("CLO 1.1, CLO 1.2, CLO 1.3")
                    .font(
                        Font.custom("SF Pro Text", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
            }
        }
    }
    
    @ViewBuilder var instructionDescriptionView: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Text("Instructions/Description")
                    .font(
                        Font.custom("SF Pro Text", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
            }
            HStack {
                ScrollView(.vertical,showsIndicators: false) {
                    Text("Assignment Guidelines: flow-01Objective: The objective of this assignment is to [state the main goal or learning outcome of the assignment].Topic: [Provide a brief description of the topic or subject matter of the assignment].Instructions:\nWord Limit: The assignment should be between [word limit range] words, excluding references and citations.\nFormatting: Use a standard font (e.g., Times New Roman, Arial) and font size (e.g., 12pt), with 1.5 line spacing. Set 1-inch margins on all sides.\nReferences: Use appropriate citations and references for all sources used. Follow [cite the specific citation style, e.g., APA, MLA] formatting guidelines for in-text citations and the reference list.\nPlagiarism: Plagiarism will not be tolerated. Ensure all content is properly paraphrased, and direct quotes, if used, are appropriately cited.\nSubmission Format: Submit the assignment as a [state the acceptable format, e.g., Word document, PDF] via [submission method, e.g., email, online platform].\nDeadline: The assignment is due on [deadline date] by [submission time].\nLate Submissions: Late submissions may be subject to a penalty of [state the penalty, e.g., deduction of marks].\nAcademic Integrity: Your work must be entirely your own, and collaboration with others is not permitted unless explicitly stated otherwise.\nAssignment Structure: Organize your assignment with the following sections: a. Introduction: Provide a brief introduction to the topic and the purpose of the assignment. b. Main Content: Divide the main content into appropriate subheadings and address each aspect of the assignment's topic. c. Conclusion: Summarize the key points discussed in the assignment and draw conclusions based on the findings. d. References: List all the sources you cited in the assignment, following the specified citation style.")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#4B5563"))
                        .frame(maxHeight: .infinity)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
    
    
    var sessionStatusViewscrollHeight: CGFloat {
        let screenHeight:CGFloat = UIScreen.main.bounds.height - 100 - sessionInprogressScrollSize.height
        let height = sessionStatusScrollSize.height
        return height > screenHeight ? screenHeight : height
    }
}

struct AssignmentDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentInstructionPopUpView()
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

