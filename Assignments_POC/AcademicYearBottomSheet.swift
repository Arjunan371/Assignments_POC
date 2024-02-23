//
//  AcademicYearBottomSheet.swift
//  Assignments_POC
//
//  Created by Arjunan on 30/10/23.
//

import SwiftUI
import AVFoundation

struct AcademicYearBottomSheet: View {
    @ObservedObject var viewModel: ViewingCommentsVM = ViewingCommentsVM()
    @State private var contentSize: CGSize = .zero
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.1)
                .ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                VStack(alignment: .leading,spacing: 16){
                    titleView
                }
                .padding([.top,.bottom],16)
                .background(Color.white)
                .cornerRadius(16,corners: [.topLeft,.topRight])
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
    }
    
    @ViewBuilder var titleView: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center,spacing: 10){
                Text("Academic Year")
                    .font(
                        Font.custom("SF Pro Text", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#333333"))
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(hex: "#374151"))
                })
            }
            .padding(.horizontal)
            contentView
            buttonView
        }
    }
    
    @ViewBuilder var contentView: some View {
        VStack(alignment: .leading,spacing: 16) {
            Divider()
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(0..<viewModel.filterDateModel.count,id:\.self) {
                        index in
                        HStack {
                            let model = viewModel.filterDateModel[index]
                            VStack{
                                HStack(alignment: .center) {
                                    Text("Academic Year \("model.title" )")
                                        .font(
                                            Font.custom("SF Pro Text", size: 14)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(Color(hex: "#374151"))
                                    
                                    Spacer()
                                    Button(action: {
                                        buttonImageSelection(model: model)
                                    }, label: {
                                        Image(systemName: model.isSelect ?  "largecircle.fill.circle" : "circle")
                                            .foregroundColor(model.isSelect ? Color(hex: "#2F80ED") : Color(hex: "#4B5563"))
                                    })
                                    
                                }
                                .padding([.top,.bottom],7)
                            }
                        }
                    }
                }
                .overlay(
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            contentSize = geo.size
                        }
                    }
                )
                
            }
            .frame(maxHeight: contentSize.height)
            Divider()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder var buttonView: some View {
        HStack(alignment: .center,spacing: 24){
            Button(action: {}, label: {
                Text("Cancel")
                    .font(
                        Font.custom("SF Pro Text", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#4B5563"))
                    .padding(.vertical,10)
                    .padding(.horizontal,40)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .inset(by: 0.5)
                            .stroke(Color(hex: "#4B5563"), lineWidth: 1)
                    )
            })
            Button(action: {}, label: {
                Text("Apply")
                    .font(
                        Font.custom("SF Pro Text", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,40)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#147AFC"))
                    .cornerRadius(20)
            })
        }.padding(.horizontal,30)
    }
    
    func buttonImageSelection(model:AssignmentSection) {
        for index in 0..<viewModel.assignmentModelData.count {
            if viewModel.assignmentModelData[index].id == model.id {
                viewModel.assignmentModelData[index].isSelect = true
            } else {
                viewModel.assignmentModelData[index].isSelect = false
            }
        }
    }
    

    
}


struct AcademicYearBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        AcademicYearBottomSheet()
    }
}
