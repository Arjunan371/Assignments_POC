//
//////
//////  ViewingComments.swift
//////  Assignments_POC
//////
//////  Created by Arjunan on 30/10/23.
//////
////
import SwiftUI
import AVFoundation
import AVKit

struct ViewingComments: View {

    @ObservedObject var viewModel:ViewingCommentsVM = ViewingCommentsVM()
    @State var fileType: FileType = .photos
    @State var contenTypes: ContentType = .text
    @State var documentUrl: URL?
    @State var selectedImageUrl: URL?
    @State var imageFromCameraUrl: URL?
    @State var previewImageString: String?
    @State var previewDocumentString: String?
    @State var isSelectFile: Bool = false
    @State var uploadNameDelete: Bool = false
    @State var actionSheetSelect: Bool = false
    @State var sendButtonIsSelect: Bool = false
    @State private var isVideoRecording: Bool = false
    @State private var videoURL: URL?
    @State var isImagePreview: Bool = false
    @State var isPreviewDocument:Bool = false
    @State var isRecord: Bool = false
    @State var isPlayVideo: Bool = false
    @State var addImageWithText: Bool = false
    @State var isplayVideoUrl: String = ""
    @State var searchText: String = ""
    @State var allFormatUrl: String = ""
//    @State var typeMessage: String = ""
//    @State var imageWithTextString: String = ""
    @State private var textEditorHeight : CGFloat = CGFloat()
    @State private var textEditorInitialHeight: CGFloat = 0
    @State var isShowGetImage: Bool = false
    @State var isShowGetCameraImage: Bool = false
    @State var attachmentIndex: Int = 0
    @State var contentSize: CGSize = .zero
    @State var scrollContentSize: CGFloat = .zero
    @State var isSelectManualScroll: Bool = false
    @State var isLoacalUrlPreview: Bool = false
    @State var permissionGranted: Bool = false
    @State var showAlert: Bool = false
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(.all)
            VStack(spacing: 0){
                headerView
                contentView
                    .onTapGesture {
                        hideKeyBoard()
                    }
                bottomView
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Microphone Permission Denied"),
                    message: Text("Please enable microphone access in settings."),
                    primaryButton: .default(Text("Go to Settings"), action: {
                        openSettings()
                    }),
                    secondaryButton: .default(Text("OK"))
                )
            }
            if isPlayVideo {
               PlayerView(videoLink: isplayVideoUrl, isPreviewVideo: $isPlayVideo)
            }
            if isLoacalUrlPreview {
                PreviewView(previewUrl: forpreviewLoacalUrl(url: viewModel.uploadFileName.first?.url ?? ""), isPreviewImage: $isLoacalUrlPreview)
            }
//            if isLoacalUrlPreview {
//               PlayerView(videoLink:forpreviewLoacalUrl(url: viewModel.uploadFileName.first?.url ?? ""), isPreviewVideo: $isLoacalUrlPreview)
//            }
//            if isImagePreview {
//                imagePreviewView(isImagePreview: $isImagePreview , imageString: previewImageString )
//            } else if isPreviewDocument {
//                PreviewView(previewDocumentUrl: previewDocumentString, isPreviewImage: $isPreviewDocument)
//            }

//            if isShowGetImage {
//                imageWithTextView(isShowGetImage: $isShowGetImage,typeMessage: typeMessage, imageString: imageWithTextString, isAddImageWithText: $addImageWithText) { status, imageUrl, messageText in
//                    if status {
////                        let model = AssignmentsModel(imageUrl: "\(imageUrl)")
////                                          viewModel.assignmentModelData.append(model)
////                        let message = AssignmentsModel(message: "\(messageText)")
////                        viewModel.assignmentModelData.append(message)
//                        if let urls = URL(string: imageUrl),let urlData = try? Data(contentsOf: urls){
//                            let fileName = urls.lastPathComponent
//                            let model = AssignmentUploadData(name: fileName)
//                            viewModel.uploadFileName.append(model)
//                            viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
//                                model in
//                                })
//                        }
//                    }
//                }
//            }

 //           if isShowGetCameraImage {
                
//                imageWithTextView(isShowGetImage: $isShowGetCameraImage,typeMessage: typeMessage, imageString: imageWithTextString, isAddImageWithText: $addImageWithText) { status, imageUrl, messageText in
//                    if status {
////                        let model = AssignmentsModel(imageUrl: "\(imageUrl)")
////                                          viewModel.assignmentModelData.append(model)
////                        let message = AssignmentsModel(message: "\(messageText)")
////                        viewModel.assignmentModelData.append(message)
//                        if let urls = URL(string: imageUrl),let urlData = try? Data(contentsOf: urls){
//                            let fileName = urls.lastPathComponent
//                            let model = AssignmentUploadData(name: fileName)
//                            viewModel.uploadFileName.append(model)
//                            viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
//                                model in
//                                })
//                        }
//                    }
//                }
//            }
        }
//        .onChange(of: viewModel.filterDateModel, perform: { _ in
//            print("onchangeWork====>")
//        })
        .edgesIgnoringSafeArea([.leading,.trailing])
        .onAppear {
            FacultyUserDefaults.setAccessToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0NTQ0NDQ1NDkiLCJpYXQiOjE3MDMxNTgwNjEsImV4cCI6MTcwMzE5NDA2MX0.hYpVJnxDutfUCgvuNj1btOgLcu1IuoihufvduM9-Ayw")
        }
        .fullScreenCover(isPresented: $isSelectFile, content: {
            if fileType == .document {
                DocumentPicker(url: $documentUrl) { documentUrl in
//                    let model = AssignmentsModel(documentUrl: "\(documentUrl)")
//                    viewModel.assignmentModelData.append(model)
                    if let urls = URL(string: "\(documentUrl)"),let urlData = try? Data(contentsOf: urls){
                        let fileName = urls.lastPathComponent
                        let model = AssignmentUploadData(name: fileName,url: "\(documentUrl)")
                        viewModel.uploadFileName.removeAll()
                        viewModel.uploadFileName.append(model)
                        isSelectManualScroll = true
                        viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
                            model in
                            })
                    }
                }
            } else if fileType == .photos {
                ImagePicker(Selectedimage: $selectedImageUrl) { imageUrl in
             //       imageWithTextString = "\(imageUrl)"
                    if let urls = URL(string: "\(imageUrl)"),let urlData = try? Data(contentsOf: urls){
                                     let fileName = urls.lastPathComponent
                                     let model = AssignmentUploadData(name: fileName,url: "\(imageUrl)")
                        viewModel.uploadFileName.removeAll()
                                     viewModel.uploadFileName.append(model)
                        isSelectManualScroll = true
                                     viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
                                         model in
                                         })
                                 }
                }
            } else if fileType == .camera {
                ImageFromCameraPicker(SelectedimageUrl: $imageFromCameraUrl){ imageUrl in
            //        imageWithTextString = "\(imageUrl)"
                    if let urls = URL(string: "\(imageUrl)"),let urlData = try? Data(contentsOf: urls){
                                     let fileName = urls.lastPathComponent
                                     let model = AssignmentUploadData(name: fileName,url: "\(imageUrl)")
                        viewModel.uploadFileName.removeAll()
                                     viewModel.uploadFileName.append(model)
                        isSelectManualScroll = true
                                     viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
                                         model in
                                         })
                                 }
                }
            }

        })
        .loader(isShown: $viewModel.isShowLoader)
        .overlay(
                    Group {
                        if viewModel.showToast {
                            ToastView(message: viewModel.toastMessage)
                                .padding(.top, 30)
                        }
                    }
                )
    }

    @ViewBuilder var headerView: some View {
            ZStack {
                HStack(alignment: .top,spacing: 16){
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 24,height: 24)
                            .foregroundColor(Color(hex: "#374151"))
                    })
                    viewingCommentView
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .padding(.bottom,10)
                .background(Color.white.shadow(color: Color.gray.opacity(0.5), radius: 0.9, y: 2))
            }
    }

    @ViewBuilder var viewingCommentView: some View {
        VStack(alignment: .leading,spacing: 4) {
            HStack(alignment: .top) {
                Text("Viewing Comments")
                    .font(
                        Font.custom("SF Pro Text", size: 20)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(hex: "#374151"))
            }
            HStack {
                Text("Course code - name / Peer Assessment: Assignment Title ")
                    .font(Font.custom("SF Pro Text", size: 15))
                    .foregroundColor(Color(hex: "#6B7280"))
            }
        }
    }

    @ViewBuilder var contentView: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(0..<viewModel.filterDateModel.count,id: \.self) { index in
                        let model = viewModel.filterDateModel[index]
                        HStack {
                            Text("\(model.title ?? "")")
                                .font(Font.custom("SF Pro Text", size: 12))
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#EDF6FF"))
                        .cornerRadius(8)
                        .id(model.id)
                        ForEach(0..<viewModel.filterDateModel[index].data.count ,id: \.self) { indexI in
                            let rowModel = model.data[indexI]
                            if formatFinderUsingExtension(model: rowModel).1 == .image {
                                imageUploadView(model: rowModel)
                                    .id(rowModel.id)
                            } else if formatFinderUsingExtension(model: rowModel).1 == .documentWithPhoto {
                                documentWithImageView(model: rowModel)
                                    .id(rowModel.id)
                            } else if formatFinderUsingExtension(model: rowModel).1 == .audioRecord {
                                audioRecordView(model: rowModel,index: index,audioIndex:indexI)
                                    .id(rowModel.id)
                            }  else if formatFinderUsingExtension(model: rowModel).1 == .text && rowModel.message != "" {
                                messageChatView(model: rowModel)
                                    .id(rowModel.id)
                            } else if formatFinderUsingExtension(model: rowModel).1 == .documents{
                                pdfFileView(model: rowModel)
                                    .id(rowModel.id)
                            } else if formatFinderUsingExtension(model: rowModel).1 == .video {
                                videoView(model: rowModel)
                                    .id(rowModel.id)
                            } else if formatFinderUsingExtension(model: rowModel).1 == .staffComment {
                                commentUploadView(model: rowModel)
                                    .id(rowModel.id)
                            }
                        }
                    }
                }
                .padding([.top,.bottom],16)             
                    .onChange(of: viewModel.filterDateModel, perform: { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            withAnimation(.spring()) {
                                scrollViewProxy.scrollTo(viewModel.filterDateModel.last?.data.last?.id,anchor: .bottom)
                            }
                        })
                    })
                }
        }

        }
        .padding(.horizontal)
        if !sendButtonIsSelect && isSelectManualScroll && viewModel.uploadFileName.count > 0 {
                    manuallyUploadFileName
        }
    }
    
    @ViewBuilder var manuallyUploadFileName: some View {
        ScrollView(.vertical,showsIndicators: false){
        VStack( spacing: 10) {
            ForEach(0..<viewModel.uploadFileName.count, id: \.self){ uploadIndex in
                let model = viewModel.uploadFileName[uploadIndex]
                uploadDataShowView(model: model)
            }
        }
        .padding([.top,.bottom],16)
        .frame(maxWidth: .infinity)
        .overlay(
            GeometryReader { geo in
                Color.clear.onAppear {
                    contentSize = geo.size
                }
            }
        )
    }
        .frame( height: contentSize.height * 1)
    .background(Color.white.shadow(color: Color.black.opacity(0.1), radius: 0.9, x: 0, y: -2))
    }

    @ViewBuilder func imageUploadView(model:AssignmentsDataComment) -> some View {
        VStack {
            HStack {
                Spacer()
                imageAndTimeView(model: model)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder func commentUploadView(model:AssignmentsDataComment) -> some View {
        VStack(spacing: 16) {
            staffCommentView(model: model)
        }
        .padding(.horizontal)
    }

    @ViewBuilder func staffCommentView(model:AssignmentsDataComment) -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading,spacing: 4) {
                HStack {
                    Text("\(model.staffName ?? "")")
                        .font(Font.custom("SF Pro Text", size: 12))
                        .foregroundColor(Color(hex: "#147AFC"))
                    Spacer()
                }
                HStack {
                    Text("\(model.message ?? "")")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#4B5563"))
                    Spacer()
                }

            }
            .padding(10)
            .background(Color(hex: "#F9FAFB"))
            .cornerRadius(4)
            .shadow(color: Color.black.opacity(0.2), radius: 1.5, x: 0, y: 1)
            HStack{
                Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                    .font(Font.custom("SF Pro Text", size: 10))
                    .foregroundColor(Color(hex: "#F9FAFB"))
                    .padding(.horizontal,10)
            }
        }
        .padding(.trailing,30)
    }

    @ViewBuilder func documentWithImageView(model:AssignmentsDataComment) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {

//                    Image("")
//                        .resizable()
//                        .frame(width: 240,height: 100)
                }
                HStack(spacing: 4) {
                    Image(viewModel.documentImage(url: model.attachments?.first?.url ?? ""))
                    VStack(alignment: .leading,spacing: 4) {
                        Text("\(model.attachments?.first?.name ?? "")")
                            .font(Font.custom("SF Pro Text", size: 14))
                            .foregroundColor(Color(hex: "#374151"))
                        HStack(spacing: 4) {
                            Text("1\(model.attachments?.first?.size ?? 0) ●")
                                .font(Font.custom("SF Pro Text", size: 12))
                                .foregroundColor(Color(hex: "#6B7280"))
                            Text("\(formatFinderUsingExtension(model:model).2)")
                                .font(Font.custom("SF Pro Text", size: 12))
                                .foregroundColor(Color(hex: "#6B7280"))
                        }
                    }
                }
                .padding(4)
            }
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: -0.5)
                    .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .onTapGesture {
   //         displayMedia(url: formatFinderUsingExtension(model: model).0)
        }
    }

    @ViewBuilder func audioRecordView(model:AssignmentsDataComment, index: Int,audioIndex: Int) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .leading,spacing: 5) {
                HStack(spacing: 5) {
                    Button(action: {
                        let playId = model.id
                        if viewModel.audioPlayer.isNewFile(newId: playId ?? "") {
                            let url = "\(formatFinderUsingExtension(model: model).0)"
                            viewModel.audioPlayer.setupPlayer(url: url, id: playId ?? "")
                        } else {
                            if viewModel.audioPlayer.isPlaying() {
                                viewModel.audioPlayer.pause()
                            } else {
                                viewModel.audioPlayer.play()
                            }
                        }
                        if  viewModel.filterDateModel[index].data[audioIndex].isSelect == false {
                            forAudioPlay(model: model,index: index)
                        } else {
                            viewModel.filterDateModel[index].data[audioIndex].isSelect = false
                        }

                    }, label: {
                        Image(systemName: (!viewModel.audioPlayer.isNewFile(newId: model.id ?? "") && viewModel.currentTime != 0 && viewModel.audioPlayer.isPlaying() ) ? "pause" : "play.fill")
                            .resizable()
                            .frame(width: 18,height: 18)
                            .foregroundColor(Color(hex: "#4B5563"))
                            .padding(10)
                    })
                    audioRecordingRectangleBuildingView(model: model)
                }
                .padding(.vertical,8)
                durationTimeView(model: model,index: index,audioIndex: audioIndex)
            }
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: -0.5)
                    .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }

    @ViewBuilder func audioRecordingRectangleBuildingView(model:AssignmentsDataComment) -> some View {
        HStack(spacing: 1) {
            ForEach(0..<model.bricksHeight.count,id: \.self) { item in
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 6, height: CGFloat(model.bricksHeight[item]))
                    .foregroundColor(viewModel.brickColorForTime(item,model: model))
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }

    @ViewBuilder func durationTimeView(model:AssignmentsDataComment,index: Int,audioIndex: Int) -> some View {
        HStack{
            
            Text("\(!viewModel.audioPlayer.isNewFile(newId: model.id ?? "" ) ? viewModel.timeString(time: viewModel.audioPlayer.currentTime ) : viewModel.timeString(time: 0 ) )")
                    .font(Font.custom("SF Pro Text", size: 12))
                    .foregroundColor(Color(hex: "#333333"))

            Spacer()
            Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                .font(Font.custom("SF Pro Text", size: 10))
                .foregroundColor(Color(hex: "#6B7280"))
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F7FCFD"))
        .cornerRadius(4)
    }

    @ViewBuilder func imageAndTimeView(model:AssignmentsDataComment) -> some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                    if #available(iOS 15.0, *) {
                        AsyncImageView(url: URL(string: "\(formatFinderUsingExtension(model: model).0)")!)
                            .onTapGesture {
                                //             displayMedia(url: formatFinderUsingExtension(model: model).0)
                            }
                    } else {
                        ImageLoaderView(url: URL(string: "\(formatFinderUsingExtension(model: model).0)")!)
                            .onTapGesture {
                                //                         displayMedia(url: formatFinderUsingExtension(model: model).0)
                            }
                    }
               
                if model.message == "" {
                        Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                            .font(Font.custom("SF Pro Text", size: 10))
                            .foregroundColor(Color.black)
                            .padding(10)
                }
            }
            .frame(height: 250)
            if model.message != "" {
                HStack {
                    Text("\(model.message ?? "")" )
                    Spacer()
                    Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                        .font(Font.custom("SF Pro Text", size: 10))
                }
                .padding(.horizontal,5)
                .padding(.vertical,10)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#F7FCFD"))
            }
        }
        .frame(width: 236)
        .cornerRadius(4)
        .shadow(color: Color(hex: "#C2EBFA").opacity(0.2), radius: 1.5, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .inset(by: -1)
                .stroke(Color(hex: "#C2EBFA"), lineWidth: 2)

        )
    }

    @ViewBuilder func messageChatView(model:AssignmentsDataComment) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .leading,spacing: 4) {
                HStack{
                    Text("\(model.message ?? "" ) ")
                        .font(Font.custom("SF Pro Text", size: 14))
                        .foregroundColor(Color(hex: "#4B5563"))
                }
                HStack {
                    Spacer()
                    Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                        .font(Font.custom("SF Pro Text", size: 10))
                        .foregroundColor(Color(hex: "#6B7280"))
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: -0.5)
                    .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }

    @ViewBuilder func pdfFileView(model:AssignmentsDataComment) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .leading,spacing: 4) {
                HStack(spacing: 4) {
                    Image(viewModel.documentImage(url: model.attachments?.first?.url ?? ""))
                        .resizable()
                        .frame(width: 24, height: 24)
                    VStack(alignment: .leading,spacing: 4) {
                        Text("\(model.attachments?.first?.name ?? "")")
                            .font(Font.custom("SF Pro Text", size: 14))
                            .foregroundColor(Color(hex: "#374151"))
                        HStack(spacing: 4) {

                            Text("\(viewModel.documentSizeText) ●")
                                .font(Font.custom("SF Pro Text", size: 12))
                                .foregroundColor(Color(hex: "#6B7280"))
                                .onAppear{
                                    if let urlString = model.attachments?.first?.signedURL, let url = URL(string: urlString) {
                                        DispatchQueue.main.async {
                                            viewModel.fetchDocumentSize(from: url)                                            
                                        }
                                    } else {
                                        print("Invalid URL or URL not available")
                                    }
                                }

                            Text("\(formatFinderUsingExtension(model:model).2)")
                                .font(Font.custom("SF Pro Text", size: 12))
                                .foregroundColor(Color(hex: "#6B7280"))
                        }
                    }
                    Spacer()
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#F9FAFB"))
                .cornerRadius(4)
//                .onTapGesture {
//                    isPreviewDocument = true
//                    previewDocumentString = "\(formatFinderUsingExtension(model: model).0)"
//                }
                .onTapGesture {
      //              displayMedia(url: formatFinderUsingExtension(model: model).0)
                }
                HStack {
                    Spacer()
                    Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                        .font(Font.custom("SF Pro Text", size: 10))
                        .foregroundColor(Color(hex: "#6B7280"))
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: -0.5)
                    .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }

    @ViewBuilder func videoView(model:AssignmentsDataComment) -> some View {
        VStack {
            HStack {
                Spacer()
                videoImageDesignView(model: model)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder func videoImageDesignView(model: AssignmentsDataComment) -> some View {
        VStack {
            ZStack(alignment: .center) {
                ZStack(alignment: .bottom) {
                    if let videoURL = URL(string: formatFinderUsingExtension(model: model).0) {
                        VideoThumbnailView(videoURL: videoURL  )
                            .frame(width: 236, height: 252)
                            .clipped()
                    }
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)

                    HStack(spacing: 4) {
                        Image(systemName: "video.fill")
                            .foregroundColor(Color.white)
                            .padding(4)
                        Text("video")
                            .font(Font.custom("SF Pro Text", size: 10))
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("\(DateManager.shared.utcToLocal("\(model.time ?? "")", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "hh:mm a"))")
                            .font(Font.custom("SF Pro Text", size: 10))
                            .foregroundColor(Color.white)
                            .padding(10)
                    }
                }
                .padding(.horizontal)
                HStack {
                    Button(action: {
                        isPlayVideo = true
                        isplayVideoUrl = "\(formatFinderUsingExtension(model: model).0)"
                    }, label: {
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 24,height: 24)
                            .foregroundColor(Color.white)
                            .padding(16)
                            .frame(width: 48, height: 48, alignment: .center)
                            .background(Color.white.opacity(0.35))
                            .cornerRadius(128)
                    })
                }
            }
//            HStack {
//                Text("sampleText....")
//                Spacer()
//                Text("01:20 pm")
//                    .font(Font.custom("SF Pro Text", size: 10))
//            }
//            .padding(.horizontal,5)
//            .padding(.vertical,10)
//            .frame(maxWidth: .infinity)
//            .background(Color(hex: "#F7FCFD"))
        }
        .frame(width: 236)
        .cornerRadius(4)
        .shadow(color: Color(hex: "#C2EBFA").opacity(0.2), radius: 1.5, x: 0, y: 1)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .inset(by: -1)
                .stroke(Color(hex: "#C2EBFA"), lineWidth: 2)

        )
    }

    @ViewBuilder func uploadDataShowView(model: AssignmentUploadData) -> some View {
            HStack {
                Spacer()
                VStack(alignment: .leading,spacing: 4) {
                    HStack(spacing: 4) {
                        VStack(alignment: .leading,spacing: 4) {
                            Text("\(model.name)")
                                .font(Font.custom("SF Pro Text", size: 14))
                                .foregroundColor(Color(hex: "#374151"))
                        }
                        Spacer()
                        Button(action: {
                            uploadNameDelete = true
                            viewModel.uploadFileName.remove(at: Int(model.id) ?? 0)
                            viewModel.uploadFileName.removeAll()
                        }, label: {
                            Image(systemName: "trash.circle")
                                .resizable()
                                .frame(width: 22,height: 22)
                                .foregroundColor(Color(hex: "#6B7280"))
                        })
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#F9FAFB"))
                    .cornerRadius(4)
                    .onTapGesture {
                       isLoacalUrlPreview = true
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(4)
                .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .inset(by: -0.5)
                        .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
                )
            }
            .padding(.horizontal)
        }

    @ViewBuilder var bottomView: some View {
        VStack {
            HStack(spacing: 12) {
                HStack(alignment: textEditorInitialHeight == textEditorHeight ? .center : .bottom,spacing: 16) {
                    ZStack {
                        TextEditor(text: $searchText)
                            .frame(height: textEditorHeight)
                        Text(searchText).opacity(0).padding(.all, 8)
                            .background(GeometryReader {
                                Color.clear.preference(key: ViewHeightKey.self,
                                                       value: $0.frame(in: .local).size.height)
                            })
                    }
                    .foregroundColor(Color.black.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
                    .onAppear {
                        textEditorInitialHeight = textEditorHeight
                    }

                    HStack(spacing: 12){
                        Button(action: {
                            actionSheetSelect.toggle()
                        }, label: {
                            Image(systemName: "paperclip")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(hex: "#6B7280"))
                                .rotationEffect(Angle(degrees: 180))
                        })
                        .actionSheet(isPresented: $actionSheetSelect) {
                        ActionSheet(
                                title: Text("Select Your file"),
                                buttons: [
                                    .default(Text("Document")) {
                                        isSelectFile = true
                                        fileType = .document
                                        contenTypes = .documents
                                    },
                                    .default(Text("Photos")) {
                                        isSelectFile = true
                                        fileType = .photos
                                        contenTypes = .image
                                    },
                                    .default(Text("Camera")) {
                                        isSelectFile = true
                                        fileType = .camera
                                        contenTypes = .image
                                    },
                                    .cancel(Text("Cancel").foregroundColor(Color.red))
                                ]
                            )
                        }
                        
                        Button(action: {
                            contenTypes = .video
                            isVideoRecording = true
                        }, label: {
                            Image(systemName: "video.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(hex: "#9CA3AF"))
                        })
                        .fullScreenCover(isPresented: $isVideoRecording, content: {
                            VideoPicker(selectedURL: $videoURL) { recordVideoUrl in
                                if let urls = URL(string: "\(recordVideoUrl)"),let urlData = try? Data(contentsOf: urls){
                                    let fileName = urls.lastPathComponent
                                    let model = AssignmentUploadData(name: fileName,url: "\(recordVideoUrl)")
                                    viewModel.uploadFileName.removeAll()
                                    viewModel.uploadFileName.append(model)
                                    isSelectManualScroll = true
                                    viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
                                        model in
                                        })
                                }
                            }
                        })

                        Button(action: {
                            if permissionGranted {
                                toggleRecording()
                            } else {
                                requestPermission()
                            }
                        }, label: {
                            Image(systemName: !isRecord ? "mic.fill" : "mic.slash.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor( isRecord ? (Color.blue) : Color(hex: "#9CA3AF"))
                        })
                        .onAppear {
                                      checkPermission()
                                  }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .inset(by: 0.5)
                        .stroke(Color(hex: "#F3F4F6"), lineWidth: 1)

                )
                sendButtonView
                    .dismissingGesture(direction: .right){
                                   
                               }
            }
            .padding(.horizontal)
        }
        .padding(16)
        .background(Color.white.shadow(color: Color.black.opacity(0.1), radius: 0.9, x: 0, y: -2))
    }

    @ViewBuilder var sendButtonView: some View {
        HStack {
            Button(action: {
                sendButtonIsSelect = true
                isSelectManualScroll = false
                if searchText != ""   {
                    if contenTypes == .video {
                        searchText = ""
                    } else if contenTypes == .audioRecord {
                        searchText = ""
                    } else if contenTypes == .image && viewModel.uploadFileName.count > 0 {
                        contenTypes = .image
                    }
                        contenTypes = .text
                    viewModel.submitAssignmentApi(message: searchText) {
                        contenTypes = .text
                        DispatchQueue.main.async {
                            viewModel.uploadDataForAttachment = nil
                        }
                    }
                    viewModel.uploadFileName.removeAll()
                    searchText = ""
                } else if viewModel.uploadFileName.count > 0 && searchText == ""{
                    if contenTypes == .video {
                        contenTypes = .video
                    } else if contenTypes == .audioRecord {
                        contenTypes = .audioRecord
                    } else if contenTypes == .image {
                        contenTypes = .image
                    }
                    viewModel.submitAssignmentApi(message: ""){
                        contenTypes = .text
                        DispatchQueue.main.async {
                            viewModel.uploadDataForAttachment = nil
                        }
                    }
                    viewModel.uploadFileName.removeAll()
                }
                sendButtonIsSelect = false
            }, label: {
                Image(systemName: "location.north.fill")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color(hex: "#147AFC"))
                    .rotationEffect(Angle(degrees: 90))
            })
        }
    }

    func forAudioPlay(model:AssignmentsDataComment,index:Int) {
        for indexI in 0..<viewModel.filterDateModel[index].data.count {
            if viewModel.filterDateModel[index].data[indexI].id == model.id {
                viewModel.filterDateModel[index].data[indexI].isSelect = true
            } else {
                viewModel.filterDateModel[index].data[indexI].isSelect = false
            }
        }
    }

//    func displayMedia(url: String) {
//        guard let topVC = UIApplication.topViewController()?.navigationController else {
//            return
//        }
//        let previewController = AppFlow.getViewController(type: PreviewUrlController.self, storyboard: "Main")
//        previewController.RemoteUrl = url
//        topVC.pushViewController(previewController, animated: true)
//    }

    func formatFinderUsingExtension(model:AssignmentsDataComment) -> (String, ContentType,String) {
        
        var url = ""
        var extensions = ""
        var contentType:ContentType  = .text
        for attachIndex in 0..<(model.attachments?.count ?? 0) {
            let formatUrl = URL(string: model.attachments?[attachIndex].signedURL ?? "" )
            switch formatUrl?.pathExtension.lowercased() {
            case "m4a", "mp3", "wav", "wma", "aac", "mpeg" :
                url = model.attachments?[attachIndex].signedURL ?? ""
                contentType = .audioRecord
                extensions = formatUrl?.pathExtension ?? ""
            case "mov", "mp4", "mpeg4", "wmv", "mkv", "Webm", "flv", "3gb":
                url = model.attachments?[attachIndex].signedURL ?? ""
                contentType = .video
                extensions = formatUrl?.pathExtension ?? ""
            case "jpeg", "jpg", "png", "gif", "tiff", "bmp", "heic":
                url = model.attachments?[attachIndex].signedURL ?? ""
                contentType = .image
                extensions = formatUrl?.pathExtension ?? ""
            case "doc", "docx", "xls", "xlsx", "ppt", "pptx","xml","pdf":
               url = model.attachments?[attachIndex].signedURL ?? ""
                contentType = .documents
                extensions = formatUrl?.pathExtension.uppercased() ?? ""
//            case "pdf" :
//                url = model.attachments?[attachIndex].signedURL ?? ""
//                 contentType = .documentWithPhoto
//                 extensions = formatUrl?.pathExtension.uppercased() ?? ""
            default:
               url = model.attachments?[attachIndex].signedURL ?? ""
                contentType = .text
            }
        }
        return (url, contentType,extensions)
    }
    
    func forpreviewLoacalUrl(url: String) -> String {
        let localUrl = URL(string: url)
        var localUrls = ""
        switch localUrl?.pathExtension.lowercased() {
            case "m4a", "mp3", "wav", "wma", "aac", "mpeg" :
            localUrls = url
            case "mov", "mp4", "mpeg4", "wmv", "mkv", "Webm", "flv", "3gb":
             localUrls = url
            isPlayVideo = true
            isplayVideoUrl = url
            case "jpeg", "jpg", "png", "gif", "tiff", "bmp", "heic":
localUrls = url
            case "doc", "docx", "xls", "xlsx", "ppt", "pptx", "pdf","xml":
localUrls = url
            default:
localUrls = url
        }
        return localUrls
    }
    
    func hideKeyBoard(){
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }

    func checkPermission() {
           switch AVAudioSession.sharedInstance().recordPermission {
           case .granted:
               permissionGranted = true
           case .denied, .undetermined:
               permissionGranted = false
           @unknown default:
               permissionGranted = false
           }
       }

       func requestPermission() {
           AVAudioSession.sharedInstance().requestRecordPermission { granted in
               DispatchQueue.main.async {
                   permissionGranted = granted
                   if !granted {
                       showAlert = true // Show alert if permission is denied after request
                   }
               }
           }
       }

       func toggleRecording() {
           contenTypes = .audioRecord
           isRecord.toggle()
           if !viewModel.record.isRecording {
               viewModel.record.startRecording()
                  } else {
                      viewModel.record.stopRecording()
                      if let urls = viewModel.record.audioRecordUrl ,let urlData = try? Data(contentsOf: urls){
                       let fileName = urls.lastPathComponent
                       let model = AssignmentUploadData(name: fileName,url: "\(urls)")
                          viewModel.uploadFileName.removeAll()
                       viewModel.uploadFileName.append(model)
                          isSelectManualScroll = true
                       viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
                           model in
                           })
                   }
           }
       }
   
    func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }

    
}

struct ViewingComments_Previews: PreviewProvider {
    static var previews: some View {
        ViewingComments()
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct PlayerView: View {

    var videoLink : String

    @State private var player : AVPlayer?
    @Binding var isPreviewVideo: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                    headerView
                VideoPlayer(player: player) {
                    
                }
                
                .onAppear() {
                    guard let url = URL(string: videoLink) else {
                        return
                    }
                    player = AVPlayer(url: url)
                    player?.play()
                }
                .onDisappear() {
                    player?.pause()
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    @ViewBuilder var headerView: some View {
        HStack {
            Button(action: {
                isPreviewVideo = false
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .foregroundColor(Color.blue)
            })
            Spacer()
        }
        .padding(10)
        .padding(.horizontal)
        .foregroundColor(Color.white)
        .background(Color.white)
        .onTapGesture {
        }
    }
}

struct PreviewView: View {
    var previewUrl : String?
    @Binding var isPreviewImage: Bool

    var body: some View {
        ZStack {
            Color.white
            VStack {
                headerView
                contentView
            }
        }
    }

    @ViewBuilder var headerView: some View {
        HStack {
            Button(action: {
                isPreviewImage = false
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .foregroundColor(Color.blue)
            })
            Spacer()
        }
        .padding(10)
        .padding(.horizontal)
        .background(Color.white)
    }

    @ViewBuilder var contentView: some View {
        VStack {
            if let url = URL(string: previewUrl ?? "") {
                PreviewController(url:url)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

struct imagePreviewView: View {
    @Binding var isImagePreview: Bool
    @State var imageString : String?

    var body: some View {

        ZStack {
            Color.black
            VStack {
                    headerView
                    contentView
            }
        }
    }

    @ViewBuilder var headerView: some View {
        HStack {
            Button(action: {
                isImagePreview = false
            }, label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .foregroundColor(Color.blue)
            })
            Spacer()
        }
        .padding(10)
        .padding(.horizontal)
        .background(Color.white)
    }

    @ViewBuilder var contentView: some View {
        VStack {
            if #available(iOS 15.0, *) {
                           AsyncImageView(url: URL(string: "\(imageString ?? "")")!)
                       } else {
                           ImageLoaderView(url: URL(string: "\(imageString ?? "")")!)
                       }
//                .resizable()
//                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    }

extension UIImage {

    func upOrientationImage() -> UIImage? {
        switch imageOrientation {
        case .up:
            return self
        default:
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return result
        }
    }
}
//


//Button(action: {
//    // Check permission and toggle recording
//    checkAndToggleRecording()
//}, label: {
//    Image(systemName: !isRecord ? "mic.fill" : "mic.slash.fill")
//        .resizable()
//        .frame(width: 16, height: 16)
//        .foregroundColor(isRecord ? (Color.blue) : Color(hex: "#9CA3AF"))
//})




//            if fileType == .document {
//                DCDocumentPickerView(uTType: [.text, .pdf, .folder, .gif, .exe, .data]) { documentUrl in
//                    if let urls = URL(string: "\(documentUrl)"),let urlData = try? Data(contentsOf: urls){
//                        let fileName = urls.lastPathComponent
//                        let model = ViewingCommentsModel.AssignmentUploadData(url: "\(documentUrl)",name: fileName)
//                        viewModel.uploadFileName.removeAll()
//                        viewModel.uploadFileName.append(model)
//                        isSelectManualScroll = true
//                        viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
//                            model in
//                            })
//                    }
//                }
//            } else

//extension UIView {
//    enum TooltipPosition {
//        case top
//        case bottom
//    }
//
//    func displayTooltip(_ message: String, fromView view: UIView, position: TooltipPosition = .top,leadingView: UIView, completion: (() -> Void)? = nil) {
//        let tooltipTopPadding: CGFloat = 4
//        let tooltipBottomPadding: CGFloat = 8
//        let tooltipCornerRadius: CGFloat = 6
//        let tooltipAlpha: CGFloat = 0.95
//
//        if let existingTooltip = (superview ?? self).subviews.first(where: { $0.tag == 999 }) {
//            // Tooltip is already visible, hide it
//            hideTooltip(existingTooltip)
//            return
//        }
//        let tooltip = UIView()
//        tooltip.tag = 999
//        tooltip.backgroundColor = UIColor.white.withAlphaComponent(0.3)
//
//        let tooltipLabel = UILabel()
//        tooltipLabel.text = "  \(message)  "
//        tooltipLabel.font = UIFont(name: "SFProText-Regular", size: 14)
//        tooltipLabel.textColor = .white
//        tooltipLabel.textAlignment = .center
//        tooltipLabel.numberOfLines = 0
//        tooltipLabel.layer.backgroundColor = UIColor(red: 44 / 255, green: 44 / 255, blue: 44 / 255, alpha: 1).cgColor
//        tooltipLabel.layer.cornerRadius = tooltipCornerRadius
//
//        tooltip.addSubview(tooltipLabel)
//        tooltipLabel.translatesAutoresizingMaskIntoConstraints = false
//        tooltipLabel.topAnchor.constraint(equalTo: tooltip.topAnchor, constant: tooltipTopPadding).isActive = true
//        tooltipLabel.bottomAnchor.constraint(equalTo: tooltip.bottomAnchor, constant: -tooltipBottomPadding).isActive = true
//        tooltipLabel.leadingAnchor.constraint(equalTo: tooltip.leadingAnchor).isActive = true
//        tooltipLabel.trailingAnchor.constraint(equalTo: tooltip.trailingAnchor).isActive = true
//
//        // Set tooltip height dynamically based on the content
//        let tooltipHeight = message.height(withWidth: UIScreen.main.bounds.width - 20, font: UIFont.systemFont(ofSize: 13)) + tooltipTopPadding + tooltipBottomPadding
//        tooltip.heightAnchor.constraint(equalToConstant: tooltipHeight + 20).isActive = true
//
//        tooltip.layer.cornerRadius = tooltipCornerRadius
//
//        (superview ?? self).addSubview(tooltip)
//        tooltip.translatesAutoresizingMaskIntoConstraints = false
//
//        // Set tooltip width based on the label's intrinsic content size
//        tooltip.widthAnchor.constraint(equalTo: tooltipLabel.widthAnchor, constant: 10).isActive = true
//
//        // Set tooltip trailing anchor to the trailing anchor of the tooltip's superview
//        tooltip.trailingAnchor.constraint(equalTo: leadingView.trailingAnchor,constant: -10).isActive = true
//        tooltip.leadingAnchor.constraint(equalTo: leadingView.leadingAnchor, constant: 20).isActive = true
//        // Ensure tooltip stays within the screen bounds
//        switch position {
//        case .top:
//            tooltip.topAnchor.constraint(equalTo: view.topAnchor, constant: -tooltipHeight - tooltipTopPadding - 10).isActive = true
//        case .bottom:
//            tooltip.topAnchor.constraint(equalTo: view.bottomAnchor, constant: tooltipTopPadding).isActive = true
//        }
//
//        tooltip.alpha = 0
//        UIView.animate(withDuration: 0.2, animations: {
//            tooltip.alpha = tooltipAlpha
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.5, delay: 10, animations: {
//                tooltip.alpha = 0
//            }, completion: { _ in
//                self.hideTooltip(tooltip)
//                completion?()
//            })
//        })
//    }
//
//    private func hideTooltip(_ tooltip: UIView) {
//        // Hide the tooltip
//        UIView.animate(withDuration: 0.5, animations: {
//            tooltip.alpha = 0
//        }, completion: { _ in
//            tooltip.removeFromSuperview()
//        })
//    }
//    
//    //    func displayMultipleContentTooltip(fromView: UIView,message: String) {
//    //
//    //        if let existingTooltip = subviews.first(where: { $0.tag == 2 }) {
//    //            hideTooltip(existingTooltip)
//    //            return
//    //        }
//    //
//    //        func hideTooltip(_ tooltip: UIView) {
//    //            // Hide the tooltip
//    //            UIView.animate(withDuration: 0.5, animations: {
//    //                tooltip.alpha = 0
//    //            }, completion: { _ in
//    //                tooltip.removeFromSuperview()
//    //            })
//    //        }
//    //
//    //        let toolTipHeaderView = UIView()
//    //        let toolTipHeaderLabel1 = UILabel()
//    //        let toolTipHeaderLAbel2 = UILabel()
//    //        let toolTipHeaderLAbel3 = UILabel()
//    //        let toolTipContentView = UIView()
//    //        let toolTipContentViewLabel1 = UILabel()
//    //        let toolTipContentViewLabel2 = UILabel()
//    //        let toolTipContentViewLabel3 = UILabel()
//    //        let toolTipContentViewBelowLabel = UILabel()
//    //
//    //        toolTipHeaderView.translatesAutoresizingMaskIntoConstraints = false
//    //        toolTipHeaderView.layer.backgroundColor = UIColor(red: 0.122, green: 0.161, blue: 0.216, alpha: 1).cgColor
//    //        addSubview(toolTipHeaderView)
//    //
//    //        toolTipHeaderLabel1.translatesAutoresizingMaskIntoConstraints = false
//    //        toolTipHeaderLabel1.font = UIFont(name: "SFProText-Regular", size: 12)
//    //        toolTipHeaderLabel1.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    //        toolTipHeaderLabel1.textAlignment = .left
//    //        toolTipHeaderLabel1.backgroundColor = .clear
//    //        toolTipHeaderLabel1.numberOfLines = 0
//    //        toolTipHeaderLabel1.text = "Late Label"
//    //        toolTipHeaderView.addSubview(toolTipHeaderLabel1)
//    //
//    //        toolTipHeaderLAbel2.translatesAutoresizingMaskIntoConstraints = false
//    //        toolTipHeaderLAbel2.font = UIFont(name: "SFProText-Regular", size: 12)
//    //        toolTipHeaderLAbel2.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    //        toolTipHeaderLAbel2.textAlignment = .center
//    //        toolTipHeaderLAbel2.backgroundColor = .clear
//    //        toolTipHeaderLAbel2.numberOfLines = 0
//    //        toolTipHeaderLAbel2.text = "No of Late"
//    //        toolTipHeaderView.addSubview(toolTipHeaderLAbel2)
//    //
//    //        toolTipHeaderLAbel3.translatesAutoresizingMaskIntoConstraints = false
//    //        toolTipHeaderLAbel3.font = UIFont(name: "SFProText-Regular", size: 12)
//    //        toolTipHeaderLAbel3.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    //        toolTipHeaderLAbel3.textAlignment = .center
//    //        toolTipHeaderLAbel3.backgroundColor = .clear
//    //        toolTipHeaderLAbel3.numberOfLines = 0
//    //        toolTipHeaderLAbel3.text = "Absence"
//    //        toolTipHeaderView.addSubview(toolTipHeaderLAbel3)
//    //
//    //        toolTipContentView.translatesAutoresizingMaskIntoConstraints = false
//    //        toolTipContentView.layer.backgroundColor = UIColor(red: 0.122, green: 0.161, blue: 0.216, alpha: 0.9).cgColor
//    //        addSubview(toolTipContentView)
//    //
//    //            toolTipContentViewLabel1.translatesAutoresizingMaskIntoConstraints = false
//    //            toolTipContentViewLabel1.font = UIFont(name: "SFProText-Regular", size: 12)
//    //            toolTipContentViewLabel1.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    //            toolTipContentViewLabel1.textAlignment = .left
//    //            toolTipContentViewLabel1.backgroundColor = .clear
//    //            toolTipContentViewLabel1.numberOfLines = 0
//    //            toolTipContentViewLabel1.text = "Late Label 2"
//    //            toolTipContentView.addSubview(toolTipContentViewLabel1)
//    //
//    //            toolTipContentViewLabel2.translatesAutoresizingMaskIntoConstraints = false
//    //            toolTipContentViewLabel2.font = UIFont(name: "SFProText-Regular", size: 12)
//    //            toolTipContentViewLabel2.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    //            toolTipContentViewLabel2.textAlignment = .center
//    //            toolTipContentViewLabel2.backgroundColor = .clear
//    //            toolTipContentViewLabel2.numberOfLines = 0
//    //            toolTipContentViewLabel2.text = "03"
//    //            toolTipContentView.addSubview(toolTipContentViewLabel2)
//    //
//    //            toolTipContentViewLabel3.translatesAutoresizingMaskIntoConstraints = false
//    //            toolTipContentViewLabel3.font = UIFont(name: "SFProText-Regular", size: 12)
//    //            toolTipContentViewLabel3.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//    //            toolTipContentViewLabel3.textAlignment = .center
//    //            toolTipContentViewLabel3.backgroundColor = .clear
//    //            toolTipContentViewLabel3.numberOfLines = 0
//    //            toolTipContentViewLabel3.text = "01"
//    //            toolTipContentView.addSubview(toolTipContentViewLabel3)
//    //
//    //            toolTipContentViewBelowLabel.translatesAutoresizingMaskIntoConstraints = false
//    //            toolTipContentViewBelowLabel.font = UIFont(name: "SFProText-Regular", size: 12)
//    //            toolTipContentViewBelowLabel.textColor = UIColor(red: 0.961, green: 0.62, blue: 0.043, alpha: 1)
//    //            toolTipContentViewBelowLabel.textAlignment = .left
//    //            toolTipContentViewBelowLabel.backgroundColor = .clear
//    //            toolTipContentViewBelowLabel.numberOfLines = 0
//    //            toolTipContentViewBelowLabel.text = "Setting*(2 Late = 1 Absent)"
//    //            toolTipContentView.addSubview(toolTipContentViewBelowLabel)
//    //
//    //        NSLayoutConstraint.activate([
//    //            toolTipHeaderView.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 10),
//    //            toolTipHeaderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//    //            toolTipHeaderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//    //            toolTipHeaderView.heightAnchor.constraint(equalToConstant: 45),
//    //
//    //            toolTipHeaderLAbel3.trailingAnchor.constraint(equalTo: toolTipHeaderView.trailingAnchor, constant: -10),
//    //            toolTipHeaderLAbel3.topAnchor.constraint(equalTo: toolTipHeaderView.topAnchor, constant: 8),
//    //            toolTipHeaderLAbel3.bottomAnchor.constraint(equalTo: toolTipHeaderView.bottomAnchor, constant: -8),
//    //
//    //            toolTipHeaderLAbel2.trailingAnchor.constraint(equalTo: toolTipHeaderLAbel3.leadingAnchor, constant: -10),
//    //            toolTipHeaderLAbel2.topAnchor.constraint(equalTo: toolTipHeaderView.topAnchor, constant: 8),
//    //            toolTipHeaderLAbel2.bottomAnchor.constraint(equalTo: toolTipHeaderView.bottomAnchor, constant: -8),
//    //
//    //            toolTipHeaderLabel1.leadingAnchor.constraint(equalTo: toolTipHeaderView.leadingAnchor, constant: 10),
//    //            toolTipHeaderLabel1.trailingAnchor.constraint(equalTo: toolTipHeaderLAbel2.leadingAnchor, constant: -20),
//    //            toolTipHeaderLabel1.topAnchor.constraint(equalTo: toolTipHeaderView.topAnchor, constant: 8),
//    //            toolTipHeaderLabel1.bottomAnchor.constraint(equalTo: toolTipHeaderView.bottomAnchor, constant: -8),
//    //            toolTipHeaderLabel1.widthAnchor.constraint(equalToConstant: 150),
//    //
//    //            toolTipContentView.topAnchor.constraint(equalTo: toolTipHeaderView.bottomAnchor),
//    //            toolTipContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//    //            toolTipContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//    //
//    //            toolTipContentViewLabel3.trailingAnchor.constraint(equalTo: toolTipContentView.trailingAnchor, constant: -50),
//    //            toolTipContentViewLabel3.topAnchor.constraint(equalTo: toolTipContentView.topAnchor, constant: 8),
//    //
//    //            toolTipContentViewLabel2.trailingAnchor.constraint(equalTo: toolTipHeaderLAbel3.leadingAnchor, constant: -10),
//    //            toolTipContentViewLabel2.topAnchor.constraint(equalTo: toolTipContentView.topAnchor, constant: 8),
//    //
//    //            toolTipContentViewLabel1.leadingAnchor.constraint(equalTo: toolTipContentView.leadingAnchor, constant: 10),
//    //            toolTipContentViewLabel1.trailingAnchor.constraint(equalTo:toolTipContentViewLabel2.leadingAnchor, constant: -10),
//    //            toolTipContentViewLabel1.topAnchor.constraint(equalTo: toolTipContentView.topAnchor, constant: 8),
//    //
//    //            toolTipContentViewBelowLabel.leadingAnchor.constraint(equalTo: toolTipContentView.leadingAnchor, constant: 10),
//    //            toolTipContentViewBelowLabel.topAnchor.constraint(equalTo: toolTipContentViewLabel1.bottomAnchor, constant: 2),
//    //            toolTipContentViewBelowLabel.bottomAnchor.constraint(equalTo: toolTipContentView.bottomAnchor, constant: -10),
//    //            toolTipContentViewBelowLabel.trailingAnchor.constraint(equalTo: toolTipContentViewLabel1.trailingAnchor, constant: -10),
//    //            toolTipContentViewBelowLabel.widthAnchor.constraint(equalToConstant: 150)
//    //
//    //        ])
//    //    }
//}


struct AttendanceStatusPopUpView: View {
    
    @State var textContents: [SelectImage] = []
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.1)
            VStack {
                attendanceStatusContentView
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .onAppear {
            getData()
        }
    }
    
    @ViewBuilder var attendanceStatusContentView: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Attendance Status")
                    .foregroundColor(Color.black)
                    .font(.fontSFProText(ofSize: 20, weight: .bold))
                Spacer()
            }

            ForEach(0..<textContents.count,id: \.self) {
                index in
                attendanceStatusButtonView(model: textContents[index])
            }
            attendanceStatusBottomView
        }
        .padding(.horizontal)
    }

    @ViewBuilder func attendanceStatusButtonView(model: SelectImage) -> some View {
        Button(action: {
            selectImageUsingId(model: model)
        }, label: {
            HStack(spacing: 12) {
                Image(systemName: model.isSelectImage ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(model.isSelectImage ? Color.blue : Color.black)
                Text("\(model.text)")
                    .foregroundColor(Color.black)
                    .font(.fontSFProText(ofSize: 12, weight: .regular))
                Spacer()
            }
        })
    }
    
    @ViewBuilder var attendanceStatusBottomView: some View {
        VStack(spacing: 12) {
            Divider()
                .padding(.bottom,5)
            HStack {
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Cancel")
                            .foregroundColor(Color.black)
                            .font(.fontSFProText(ofSize: 18, weight: .regular))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(5, corners: .allCorners)
                })
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("Submit")
                            .foregroundColor(Color.white)
                            .font(.fontSFProText(ofSize: 18, weight: .regular))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5, corners: .allCorners)
                })
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func getData() {
        textContents.append(SelectImage(text: "Mark as Present"))
        textContents.append(SelectImage(text: "Exclude Late Absences for this Session"))
    }
    
    func selectImageUsingId(model: SelectImage) {
        for index in 0..<textContents.count {
            if textContents[index].id == model.id {
                textContents[index].isSelectImage = true
            } else {
                textContents[index].isSelectImage = false
            }
        }
    }
}

struct SelectImage {
    var id = UUID().uuidString
    var isSelectImage = false
    var text = ""
}



//extension LectureSessionVC : CBCentralManagerDelegate, CBPeripheralDelegate {
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        
//        switch central.state {
//            case .unknown:
//            log("State is unknown")
//            case .resetting:
//            log("State is resetting")
//            case .unsupported:
//            log("State is unsupported")
//            case .unauthorized:
//            log("State is unauthorized")
//                enableBluetoothView.isHidden = false
//            case .poweredOff:
//            log("State is poweredOff")
//            case .poweredOn:
//            log("State is poweredOn")
//                //Provide the serviceUUID in 'withServices' argument if you have to filter and scan for particular UUID.
//                //
//                centralManager?.scanForPeripherals(withServices: [service], options: nil)
//                
//            @unknown default:
//            log("default")
//                fatalError()
//                
//        }
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        
//        central.stopScan()
//        self.peripheralDev = peripheral
//        central.connect(peripheral)
//        
//    }
//    
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        log("Connecting failed",error.debugDescription)
//    }
//    
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//          guard let scheduleModel = originalDS.filter({ $0.status == .ongoing }).first else {
//            return
//        }
//        joinSessionView?.updateJoinSession()
//        scheduleModel.isMarkAttandance.isEnabled = true
//        setFilteredDS()
//        startAdvertising()
//        //peripheral.discoverServices([service])
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        //Code after the peripheral is disconnected
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral,
//                    didModifyServices invalidatedServices: [CBService]) {
//        
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        guard let services = peripheral.services else { return }
//        
//        for service in services{
//             peripheral.discoverCharacteristics(nil, for: service)
//        }
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        guard let characteristics = service.characteristics else { return }
//        
//        for characteristic in characteristics{
//            // To read, write and notify the characteristic values
//            if characteristic.properties.contains(.read) {
//                peripheral.readValue(for: characteristic)
//            }
//            
//            if characteristic.properties.contains(.notify) {
//                peripheral.setNotifyValue(true, for: characteristic)
//            }
//            
//        }
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//        
//        let value = characteristic.value
//        let unicodeString = String(data: characteristic.value!, encoding: String.Encoding.utf8)
//        //Use this value as per your need
//        let message = "Connected to peripheral with".localized() + " \(String(describing: peripheralDev?.identifier)) ID " + "and".localized() + " \(String(describing: value)) " + "data".localized()
//        showAlert(title: "Connected!".localized(), message: message)
//        startAdvertising()
//    }
//    func stopScaning() {
//        
//        if centralManager?.isScanning == true {
//            centralManager?.stopScan()
//        }
//        
//    }
//}
//
////MARK:- BLE Peripheral
//extension LectureSessionVC: CBPeripheralManagerDelegate {
//    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
//        switch peripheral.state {
//            case .unknown:
//                log("Bluetooth Device is UNKNOWN")
//            case .unsupported:
//                log("Bluetooth Device is UNSUPPORTED")
//            case .unauthorized:
//                log("Bluetooth Device is UNAUTHORIZED")
//            case .resetting:
//                log("Bluetooth Device is RESETTING")
//            case .poweredOff:
//                log("Bluetooth Device is POWERED OFF")
//            case .poweredOn:
//                log("Bluetooth Device is POWERED ON")
//                addServices()
//            @unknown default:
//                log("default")
//                fatalError()
//                
//        }
//    }

extension View {
     func dismissingGesture(tolerance: Double = 24, direction: DragGesture.Value.Direction, action: @escaping () -> ()) -> some View {
        gesture(DragGesture()
            .onEnded { value in
                let swipeDirection = value.detectDirection(tolerance)
                if swipeDirection == direction {
                    action()
                }
            }
        )
    }
}

extension DragGesture.Value {
    func detectDirection(_ tolerance: Double = 24) -> Direction? {
        if startLocation.x < location.x - tolerance { return .left }
        if startLocation.x > location.x + tolerance { return .right }
        if startLocation.y > location.y + tolerance { return .up }
        if startLocation.y < location.y - tolerance { return .down }
        return nil
    }

    enum Direction {
        case left
        case right
        case up
        case down
    }
}
