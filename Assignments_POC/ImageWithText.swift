//struct imageWithTextView: View {
//    @Binding var isShowGetImage: Bool
//    @State var typeMessage: String
//    @State var imageString : String?
//    @Binding var isAddImageWithText: Bool
//    var addImageWithText: ((Bool,String ,String) -> Void )?
//  //  @State private var textEditorHeight : CGFloat = CGFloat()
//
//    var body: some View {
//
//        ZStack {
//            Color.black
//            VStack {
//                    headerView
//                    contentView
//                    bottomView
//            }
//        }
//    }
//
//    @ViewBuilder var headerView: some View {
//        HStack {
//            Button(action: {
//                isShowGetImage = false
//                addImageWithText?(false,imageString ?? "", typeMessage)
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
//
//            Image("")
//                .resizable()
//                .frame(maxWidth: .infinity)
//        }
//        .padding(.horizontal)
//        .frame(maxWidth: .infinity)
//    }
//
//    @ViewBuilder var bottomView: some View {
//        HStack(spacing: 16) {
//            HStack {
//                ZStack {
//                        TextEditor(text: $typeMessage)
//                        .frame(height:40 )
//                        Text(typeMessage).opacity(0).padding(.all, 8)
//                    }
//                    .foregroundColor(Color.black.opacity(0.5))
//                    .frame(maxWidth: .infinity)
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 8)
//            .background(Color.white)
//            .cornerRadius(20)
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .inset(by: 0.5)
//                    .stroke(Color(hex: "#F3F4F6"), lineWidth: 1)
//
//            )
//            sendButtonView
//        }
//        .padding(8)
//        .padding(.horizontal, 16)
//        .background(Color.white)
//        .frame(maxWidth: .infinity)
//        .shadow(color: Color.black.opacity(0.1), radius: 0.9, x: 0, y: -2)
//        }
//
//    @ViewBuilder var sendButtonView: some View {
//        HStack {
//            Button(action: {
//                isShowGetImage = false
//                addImageWithText?(true,imageString ?? "", typeMessage)
//            }, label: {
//                Image(systemName: "location.north.fill")
//                    .resizable()
//                    .frame(width: 26, height: 26)
//                    .foregroundColor(Color(hex: "#147AFC"))
//                    .rotationEffect(Angle(degrees: 90))
//            })
//        }
//    }
//    }
