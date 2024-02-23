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

struct Viewing: View {

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
    @State var isDeleteButton: Bool = false
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
            if isDeleteButton {
                deleteButtonView
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
            FacultyUserDefaults.setAccessToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3NTQxMjAwMDcwNCIsImlhdCI6MTcwMTMyMDQxMiwiZXhwIjoxNzAxMzU2NDEyfQ.ebVsRRJz52ldVaSArTOr1wnr7xDbphvd8CucfUDVyH4")
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
                                audioDocumentUploadView(model: rowModel)
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
                        .simultaneousGesture(LongPressGesture().onEnded { _ in
                            print(">> long press")
                            isDeleteButton = true
                        })
                    }
                }
                .padding([.top,.bottom],16)
             
                    .onChange(of: viewModel.filterDateModel, perform: { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            scrollViewProxy.scrollTo(viewModel.filterDateModel.last?.data.last?.id,anchor: .bottom)
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

    @ViewBuilder func audioDocumentUploadView(model:AssignmentsDataComment) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Image("labImage")
                        .resizable()
                        .frame(width: 240,height: 100)
                }
                HStack(spacing: 4) {
                    Image(systemName: "doc")
                    VStack(alignment: .leading,spacing: 4) {
                        Text("\(model.attachments?.first?.name ?? "")")
                            .font(Font.custom("SF Pro Text", size: 14))
                            .foregroundColor(Color(hex: "#374151"))
                        HStack(spacing: 4) {
                            Text("1.6MB ●")
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

                            Text("\(viewModel.filterDateModel.first?.data.first?.attachments?.first?.signedURL ?? "") ●")
                                .font(Font.custom("SF Pro Text", size: 12))
                                .foregroundColor(Color(hex: "#6B7280"))

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
//                HStack(alignment: textEditorInitialHeight == textEditorHeight ? .center : .bottom,spacing: 16) {
//                    ZStack {
//                        TextEditor(text: $searchText)
//                            .frame(height: textEditorHeight)
//                        Text(searchText).opacity(0).padding(.all, 8)
//                            .background(GeometryReader {
//                                Color.clear.preference(key: ViewHeightKey.self,
//                                                       value: $0.frame(in: .local).size.height)
//                            })
//                    }
//                    .foregroundColor(Color.black.opacity(0.5))
//                    .frame(maxWidth: .infinity)
//                    .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
//                    .onAppear {
//                        textEditorInitialHeight = textEditorHeight
//                    }
//
//                    HStack(spacing: 12){
//                        Button(action: {
//                            actionSheetSelect.toggle()
//                        }, label: {
//                            Image(systemName: "paperclip")
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                                .foregroundColor(Color(hex: "#6B7280"))
//                                .rotationEffect(Angle(degrees: 180))
//                        })
//                        .actionSheet(isPresented: $actionSheetSelect) {
//                        ActionSheet(
//                                title: Text("Select Your file"),
//                                buttons: [
//                                    .default(Text("Document")) {
//                                        isSelectFile = true
//                                        fileType = .document
//                                        contenTypes = .documents
//                                    },
//                                    .default(Text("Photos")) {
//                                        isSelectFile = true
//                                        fileType = .photos
//                                        contenTypes = .image
//                                    },
//                                    .default(Text("Camera")) {
//                                        isSelectFile = true
//                                        fileType = .camera
//                                        contenTypes = .image
//                                    },
//                                    .cancel(Text("Cancel").foregroundColor(Color.red))
//                                ]
//                            )
//                        }
//                        
//                        Button(action: {
//                            contenTypes = .video
//                            isVideoRecording = true
//                        }, label: {
//                            Image(systemName: "video.fill")
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                                .foregroundColor(Color(hex: "#9CA3AF"))
//                        })
//                        .fullScreenCover(isPresented: $isVideoRecording, content: {
//                            VideoPicker(selectedURL: $videoURL) { recordVideoUrl in
//                                if let urls = URL(string: "\(recordVideoUrl)"),let urlData = try? Data(contentsOf: urls){
//                                    let fileName = urls.lastPathComponent
//                                    let model = AssignmentUploadData(name: fileName,url: "\(recordVideoUrl)")
//                                    viewModel.uploadFileName.removeAll()
//                                    viewModel.uploadFileName.append(model)
//                                    isSelectManualScroll = true
//                                    viewModel.requestUploadFile(fileName: fileName, paramBody: ["file": urlData], completionHandler: {
//                                        model in
//                                        })
//                                }
//                            }
//                        })
//
//                        Button(action: {
//                            if permissionGranted {
//                                toggleRecording()
//                            } else {
//                                requestPermission()
//                            }
//                        }, label: {
//                            Image(systemName: !isRecord ? "mic.fill" : "mic.slash.fill")
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                                .foregroundColor( isRecord ? (Color.blue) : Color(hex: "#9CA3AF"))
//                        })
//                        .onAppear {
//                                      checkPermission()
//                                  }
//                    }
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 8)
//                .background(Color.white)
//                .cornerRadius(20)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .inset(by: 0.5)
//                        .stroke(Color(hex: "#F3F4F6"), lineWidth: 1)
//
//                )
                sendButtonView
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

    @ViewBuilder var deleteButtonView: some View {
        ZStack {
            Color.black.opacity(0.3)
            HStack(spacing: 4) {
                Image(systemName: "trash.fill")
                Button(action: {
                    
                }, label: {
                    Text("Delete")
                })
            }
            .padding(.leading, 10)
            .padding(.trailing, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color(red: 0.07, green: 0.09, blue: 0.15).opacity(0.2), radius: 3, x: 0, y: 4)
            .onTapGesture {
        //        deleteListData(model: AssignmentsDataComment,index: Int)
            }
        }
        .onTapGesture {
            isDeleteButton = false
        }
    }
    
    func deleteListData(model:AssignmentsDataComment,index: Int) {
        for deleteIndex in 0..<viewModel.filterDateModel[index].data.count {
            if viewModel.filterDateModel[index].data[deleteIndex].id == model.id {
                
            } else {
                
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
            case "doc", "docx", "xls", "xlsx", "ppt", "pptx", "pdf","xml":
               url = model.attachments?[attachIndex].signedURL ?? ""
                contentType = .documents
                extensions = formatUrl?.pathExtension.uppercased() ?? ""
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

struct Viewing_Previews: PreviewProvider {
    static var previews: some View {
        Viewing()
    }
}

//struct ViewHeightKey: PreferenceKey {
//    static var defaultValue: CGFloat { 0 }
//    static func reduce(value: inout Value, nextValue: () -> Value) {
//        value = value + nextValue()
//    }
//}
//
//struct PlayerView: View {
//
//    var videoLink : String
//
//    @State private var player : AVPlayer?
//    @Binding var isPreviewVideo: Bool
//
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                    headerView
//                VideoPlayer(player: player) {
//
//                }
//
//                .onAppear() {
//                    guard let url = URL(string: videoLink) else {
//                        return
//                    }
//                    player = AVPlayer(url: url)
//                    player?.play()
//                }
//                .onDisappear() {
//                    player?.pause()
//                }
//            }
//        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//    }
//    @ViewBuilder var headerView: some View {
//        HStack {
//            Button(action: {
//                isPreviewVideo = false
//            }, label: {
//                Image(systemName: "xmark")
//                    .resizable()
//                    .frame(width: 20,height: 20)
//                    .foregroundColor(Color.blue)
//            })
//            Spacer()
//        }
//        .padding(10)
//        .padding(.horizontal)
//        .foregroundColor(Color.white)
//        .background(Color.white)
//        .onTapGesture {
//        }
//    }
//}
//
//struct PreviewView: View {
//    var previewUrl : String?
//    @Binding var isPreviewImage: Bool
//
//    var body: some View {
//        ZStack {
//            Color.white
//            VStack {
//                headerView
//                contentView
//            }
//        }
//    }
//
//    @ViewBuilder var headerView: some View {
//        HStack {
//            Button(action: {
//                isPreviewImage = false
//            }, label: {
//                Image(systemName: "xmark")
//                    .resizable()
//                    .frame(width: 20,height: 20)
//                    .foregroundColor(Color.blue)
//            })
//            Spacer()
//        }
//        .padding(10)
//        .padding(.horizontal)
//        .background(Color.white)
//    }
//
//    @ViewBuilder var contentView: some View {
//        VStack {
//            if let url = URL(string: previewUrl ?? "") {
//                PreviewController(url:url)
//            }
//        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//    }
//}
//
//struct imagePreviewView: View {
//    @Binding var isImagePreview: Bool
//    @State var imageString : String?
//
//    var body: some View {
//
//        ZStack {
//            Color.black
//            VStack {
//                    headerView
//                    contentView
//            }
//        }
//    }
//
//    @ViewBuilder var headerView: some View {
//        HStack {
//            Button(action: {
//                isImagePreview = false
//            }, label: {
//                Image(systemName: "arrow.left")
//                    .resizable()
//                    .frame(width: 20,height: 20)
//                    .foregroundColor(Color.blue)
//            })
//            Spacer()
//        }
//        .padding(10)
//        .padding(.horizontal)
//        .background(Color.white)
//    }
//
//    @ViewBuilder var contentView: some View {
//        VStack {
//            if #available(iOS 15.0, *) {
//                           AsyncImageView(url: URL(string: "\(imageString ?? "")")!)
//                       } else {
//                           ImageLoaderView(url: URL(string: "\(imageString ?? "")")!)
//                       }
////                .resizable()
////                .frame(maxWidth: .infinity)
//        }
//        .padding(.horizontal)
//        .frame(maxWidth: .infinity)
//    }
//    }
//
//extension UIImage {
//
//    func upOrientationImage() -> UIImage? {
//        switch imageOrientation {
//        case .up:
//            return self
//        default:
//            UIGraphicsBeginImageContextWithOptions(size, false, scale)
//            draw(in: CGRect(origin: .zero, size: size))
//            let result = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return result
//        }
//    }
//}
////
//
//struct ViewOffsetKey: PreferenceKey {
//  typealias Value = CGFloat
//  static var defaultValue = CGFloat.zero
//  static func reduce(value: inout Value, nextValue: () -> Value) {
//    value += nextValue()
//  }
//}
//
//struct ChildSizeReader<Content: View>: View {
//  @Binding var size: CGSize
//
//  let content: () -> Content
//  var body: some View {
//    ZStack {
//      content().background(
//        GeometryReader { proxy in
//          Color.clear.preference(
//            key: SizePreferenceKey.self,
//            value: proxy.size
//          )
//        }
//      )
//    }
//    .onPreferenceChange(SizePreferenceKey.self) { preferences in
//      self.size = preferences
//    }
//  }
//}
//
//struct SizePreferenceKey: PreferenceKey {
//  typealias Value = CGSize
//  static var defaultValue: Value = .zero
//
//  static func reduce(value _: inout Value, nextValue: () -> Value) {
//    _ = nextValue()
//  }
//}


//Button(action: {
//    // Check permission and toggle recording
//    checkAndToggleRecording()
//}, label: {
//    Image(systemName: !isRecord ? "mic.fill" : "mic.slash.fill")
//        .resizable()
//        .frame(width: 16, height: 16)
//        .foregroundColor(isRecord ? (Color.blue) : Color(hex: "#9CA3AF"))
//})
