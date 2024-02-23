////
////  ContentView.swift
////  Assignments_POC
////
////  Created by Arjunan on 25/10/23.
////
//
import SwiftUI
//
//struct AssignmentRubricsView: View {
//
//    @ObservedObject var viewModel:ViewingCommentsVM = ViewingCommentsVM()
//    @State var isRecord: Bool = false
//    @State var scoreCount = 0
//    @State var audioUrl = ""
//
//
//    var body: some View {
//        ZStack{
//            Color.white
//            VStack(spacing: 16){
//                headerView
//                    .background(Color.white.shadow(color: Color.gray.opacity(0.5), radius: 0.9, y: 2))
//                horizontalScrollview
//            }
//        }
//
//    }
//
//
//    @ViewBuilder var horizontalScrollview: some View {
//        VStack {
//            VStack(alignment: .leading,spacing: 16){
//                ScrollView(.horizontal,showsIndicators: false){
//                    titleViewContent
//                }
//                HStack{
//                    Text("Score:")
//                        .font(.custom("SF Pro Text", size: 16))
//                        .foregroundColor(Color(hex: "#9CA3AF"))
//                    Text("\(scoreCount)")
//                        .font(.custom("SF Pro Text", size: 20))
//                        .foregroundColor(Color(hex: "#374151"))
//                }
//                .padding(.leading,16)
//            }
//            contentView
//        }
//    }
//
//    @ViewBuilder var contentView: some View {
//        ScrollView(.vertical,showsIndicators: false) {
//            VStack{
//                ForEach(0..<(viewModel.audioPlay.count),id: \.self) {
//                    index in
//                    let model = viewModel.audioPlay[index]
//                    HStack {
//                      //  contentViewContent(model: model)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .shadow(radius: 2)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .inset(by: 0.5)
//                            .stroke(model.isSelect ? Color(hex: "#147AFC") : Color.white)
//                    )
//                    .onTapGesture {
//                 //       contentSelectCell(model: viewModel.filterDateModel[index])
//
//                    }
//                    audioRecordView(model: model, index: index)
//                }
//                .padding(.top,16)
//                .padding(.horizontal,16)
//            }
//        }
//    }
//
//    @ViewBuilder func audioRecordView(model:AudioUrl, index: Int) -> some View {
//        HStack {
//            Spacer()
//            VStack(alignment: .leading,spacing: 5) {
//                HStack(spacing: 5) {
//                    Button(action: {
//                        let playId = model.id
//                        if viewModel.audioPlayer.isNewFile(newId: playId) {
//                            let url = "\(model.url)"
//                            viewModel.audioPlayer.setupPlayer(url: url, id: playId)
//                        } else {
//                            if viewModel.audioPlayer.isPlaying() {
//                                viewModel.audioPlayer.pause()
//                            } else {
//                                viewModel.audioPlayer.play()
//                            }
//                        }
//                        if   viewModel.audioPlay[index].isSelect == false {
//                            forAudioPlay(model: model,index: index)
//                        }
//                        else {
//                            viewModel.audioPlay[index].isSelect = false
//                        }
//
//                    }, label: {
//                        Image(systemName: model.isSelect ? "pause" : "play.fill")
//                            .resizable()
//                            .frame(width: 18,height: 18)
//                            .foregroundColor( Color(hex: "#4B5563"))
//                            .padding(10)
//                    })
//
//                    audioRecordingRectangleBuildingView(model: model)
//                }
//                .padding(.vertical,8)
//            }
//            .background(Color.white)
//            .cornerRadius(4)
//            .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
//            .overlay(
//                RoundedRectangle(cornerRadius: 4)
//                    .inset(by: -0.5)
//                    .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
//            )
//        }
//        .padding(.horizontal)
//    }
//
//    @ViewBuilder func audioRecordingRectangleBuildingView(model:AudioUrl) -> some View {
//        HStack(spacing: 1) {
//            ForEach(0..<model.bricksHeight.count,id: \.self) { item in
//                RoundedRectangle(cornerRadius: 2)
//                    .frame(width: 6, height: CGFloat(model.bricksHeight[item]))
//                    .foregroundColor(viewModel.brickColorForTime(item,model: model))
//            }
//        }
//        .frame(maxWidth: .infinity,alignment: .leading)
//    }
//
//
//    @ViewBuilder var titleViewContent: some View {
//        HStack(spacing: 16){
//            ForEach(0..<(viewModel.filterDateModel.count ),id: \.self){ index in
//                let model = viewModel.filterDateModel[index]
//                Button(action: {
//                                 //               contenTypes = .audioRecord
//                                                if !isRecord{
//                                                    self.viewModel.record.startRecording()
//                                                    isRecord = true
//                                                } else {
//                                                    self.viewModel.record.stopRecording()
//                                                    viewModel.record.audioUrl = { recordUrl in
//                                                        if let urls = URL(string: recordUrl),let urlData = try? Data(contentsOf: urls){
//                                                            let fileName = urls.lastPathComponent
//                                                            let model = AudioUrl(url: "\(recordUrl)")
//                                                            viewModel.audioPlay.append(model)
//                                                            viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
//                                                                model in
//                                                                })
//                                                        }
//
//                    //                                    let model = AssignmentsModel(audioUrl: "\(recordUrl )")
//                    //                                    viewModel.assignmentModelData.append(model)
//                                                    }
//
//                                                    isRecord = false
//                                                }
//
//                                            }, label: {
//                    Image(systemName: "mic.fill")
//                        .resizable()
//                        .frame(width: 16, height: 16)
//                        .foregroundColor( isRecord ? (Color.blue) : Color(hex: "#9CA3AF"))
//                })
//
//            }
//        }
//        .padding(.horizontal,16)
//    }
//
//    func contentSelectCell(model: AudioUrl){
//        for index in 0..<viewModel.assignmentModelData.count {
//            if viewModel.assignmentModelData[index].id == model.id {
//                viewModel.filterDateModel[index].isSelect.toggle()
//                if viewModel.filterDateModel[index].isSelect {
//              //      scoreCount += viewModel.filterDateModel[index].count ?? 0
//                } else {
//               //     scoreCount -= viewModel.filterDateModel[index].count ?? 0
//                }
//            }
//
//        }
//    }
//
//    func selectedTitleContent(model: AudioUrl) {
//        for index in 0..<viewModel.audioPlay.count {
//            if viewModel.assignmentModelData[index].id == model.id {
//                viewModel.assignmentModelData[index].isSelectCollectionCell = true
//
//            } else {
//                viewModel.assignmentModelData[index].isSelectCollectionCell = false
//            }
//        }
//    }
//    func forAudioPlay(model:AudioUrl,index: Int) {
//        for index in 0..<viewModel.audioPlay.count {
//            if viewModel.audioPlay[index].id == model.id {
//                viewModel.audioPlay[index].isSelect = true
//            } else {
//                viewModel.audioPlay[index].isSelect = false
//            }
//        }
//    }
    
//    @ViewBuilder func contentViewContent(model: AudioUrl) -> some View {
//        VStack(alignment: .leading,spacing: 8){
//            HStack{
//                Text("\("model.title" )")
//                    .font(.custom("SF Pro Text", size: 15))
//                    .foregroundColor(Color(hex: "#4B5563"))
//                Spacer()
//                if model.isSelect && viewModel.assignmentModelData.filter({$0.isSelect}).count > 1 {
//                    Text("\("model.title" )")
//                        .padding(5)
//                        .font(Font.custom("SF Pro Text", size: 12))
//                        .foregroundColor(Color(hex: "#374151"))
//                        .background(Color(hex: "#F3F4F6"))
//                        .cornerRadius(4)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 4)
//                                .inset(by: 0.5)
//                                .stroke( model.isSelect ? Color(hex: "#E5E7EB") : Color.white )
//                        )
//                }
//            }
//            Text("\("model.title" )")
//                .font(.custom("SF Pro Text", size: 15))
//                .foregroundColor(Color(hex: "#374151"))
//        }
//        .padding(16)
//        Spacer()
//    }
    
//    @ViewBuilder var headerView: some View {
//        ZStack {
//            HStack(alignment: .top,spacing: 16){
//                backButtonView
//                VStack(alignment: .leading,spacing: 4) {
//                    Text("Rubrics")
//                        .font(.custom("SF Pro Text", size: 20))
//                        .foregroundColor(Color(hex: "#374151"))
//                    assignMentNameView
//                }
//            }
//            .padding(.top, 8)
//            .padding(.horizontal, 16)
//        }
//    }
//
//    @ViewBuilder var backButtonView: some View {
//        Button(action: {
//
//        }, label: {
//            Image(systemName: "arrow.left")
//                .resizable()
//                .frame(width: 24,height: 24)
//                .foregroundColor(Color(hex: "#374151"))
//        })
//    }
//
//    @ViewBuilder var assignMentNameView: some View {
//        HStack{
//            Text("Assignment name ●")
//                .font(.custom("SF Pro Text", size: 15))
//                .foregroundColor(Color(hex: "#6B7280"))
//            ZStack{
//                Image("dollarImage")
//                    .resizable()
//                    .frame(width: 14 ,height: 14)
//                Image("dollarImage")
//                    .resizable()
//                    .frame(width: 14 ,height: 14)
//                    .padding(.leading,6)
//            }
//            Text("10/25 Pts")
//                .font(.custom("SF Pro Text", size: 13))
//            Spacer()
//        }
//        .padding(.bottom,8)
//    }
//    func checkAudioFileExists(audioURL: String) -> Bool {
//        if let fileURL = URL(string: audioURL) {
//            return FileManager.default.fileExists(atPath: fileURL.path)
//        }
//        return false
//    }
    
//    func formatFinderUsingExtension(model:AudioUrl,index: Int) -> (String, ContentType) {
//        var url = ""
//        var contentType:ContentType  = .text
//        for attachIndex in 0..<(model.data[index].attachments?.count ?? 0) {
//            let formatUrl = URL(string: model.data[index].attachments?[attachIndex].url ?? "" )
//            switch formatUrl?.pathExtension.lowercased() {
//            case "m4a", "mp3", "wav", "wma", "aac", "mpeg" :
//                url = model.data[index].attachments?[attachIndex].url ?? ""
//                contentType = .audioRecord
//            case "mov", "mp4", "mpeg4", "wmv", "mkv", "Webm", "flv", "3gb":
//                url = model.data[index].attachments?[attachIndex].url ?? ""
//                contentType = .video
//            case "jpeg", "jpg", "png", "gif", "tiff", "bmp", "heic":
//                url = model.data[index].attachments?[attachIndex].url ?? ""
//                contentType = .image
//            case "doc", "docx", "xls", "xlsx", "ppt", "pptx", "pdf":
//               url = model.data[index].attachments?[attachIndex].url ?? ""
//                contentType = .documents
//            default:
//               url = model.data[index].attachments?[attachIndex].url ?? ""
//                contentType = .text
//            }
//        }
//        return (url, contentType)
//    }
// }
//
//struct AssignmentRubricsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AssignmentRubricsView()
//    }
//}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
