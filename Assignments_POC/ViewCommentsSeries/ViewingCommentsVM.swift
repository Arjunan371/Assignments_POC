
import Foundation
import SwiftUI
//import AVKit

class ViewingCommentsVM: ObservableObject {
    
    @Published  var currentTime: TimeInterval = 0
    @Published  var timer: Timer?
    @Published var duration: TimeInterval = 0
    @Published var assignmentModelData:[AssignmentsDataComment] = []
    @Published var submitAssignmentModelData: ViewingCommentsModel?
    @Published var filterDateModel: [AssignmentSection] = []
    @Published var isShowLoader = false
    @Published var uploadFileName:[AssignmentUploadData] = []
    @Published var audioPlay:[AudioUrl] = []
    @Published var uploadDataForAttachment: AssignmentAttachmentModel?
    @Published var showToast: Bool = false
    @Published var toastMessage = ""
    @Published var documentSizeText = ""
    
    let record = AudioRecorder()
    let audioPlayer = DGAudioPlayer.shared
    
    init() {
        AssignmentsListApiIntegration()
        audioPlayer.delegate = self
    }
    
    func brickColorForTime(_ brickIndex: Int, model:AssignmentsDataComment) -> Color {
        guard !audioPlayer.isNewFile(newId: model.id ?? "" ) else { return Color(hex: "#D9D9D9")}
        if  Double(brickIndex) < (currentTime / duration) * 30 {
            return Color.blue
        } else {
            return Color(hex: "#D9D9D9")
        }
    }
    
    func filteredListDatas(){
        filterDateModel.removeAll()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-yyy"
        let groupedMessages = Dictionary(grouping: assignmentModelData) { (element) -> Date in
            let localTime = DateManager.shared.utcToLocal(element.time ?? "", from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            let dateStr = dateFormater.string(from:DateManager.shared.convertDate(localTime, from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") ?? Date())
            return dateFormater.date(from: dateStr) ?? Date()
        }
        print("announcementDataCount===>",assignmentModelData.count)
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { key in
            let values = groupedMessages[key]
           // ?.sorted(by: { $0.publishDate ?? "" < $1.publishDate ?? "" })
            let section = AssignmentSection(sestion: key, title: DateManager.shared.getChatHeaderDate(date: key), data: values ?? [])
            filterDateModel.append(section)
        }
        print("filterDateModel===>",filterDateModel.count)
  //      showFilter = filterDateModel.isEmpty ? (isFilteredList ? true : false) : true
    }
    
    func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }
    
    func getDate()->String{
     let time = Date()
     let timeFormatter = DateFormatter()
     timeFormatter.dateFormat = "HH:ss"
     let stringDate = timeFormatter.string(from: time)
     return stringDate
    }
    
    func AssignmentsListApiIntegration(){
        
        let orginalURL = "https://ecs-dsapi-staging1.digivalitsolutions.com/api/v1/assignment-comments/list/6543736b1457bc1ff4a26862/649d8442e2cf074813d6b969"
        
        guard let url = URL(string: orginalURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {return}
        var request = URLRequest(url: url)
        isShowLoader = true
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "_institution_calendar_id": "649e61ece2cf07dc1ad6beeb",
            "_institution_id": "5e5d0f1a15b4d600173d5692",
            "_user_id": "649d8442e2cf074813d6b969",
            "AUthorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0NTQ0NDQ1NDkiLCJpYXQiOjE3MDMxNTgwNjEsImV4cCI6MTcwMzE5NDA2MX0.hYpVJnxDutfUCgvuNj1btOgLcu1IuoihufvduM9-Ayw"
        ]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) {(data,response,error) in
            if error == nil {
                do{
                    let decoder = JSONDecoder()
                    guard let getdata = data else {return}
                    let response = try JSONSerialization.jsonObject(with: getdata)
                    print("response===>",response )
                   let jasonvalue = try? decoder.decode(ViewingCommentsModel.self, from: getdata)
                    if let datas = jasonvalue {
                        DispatchQueue.main.async {
                            self.assignmentModelData = datas.data?.comments ?? []
                            self.filteredListDatas()
                        }
                    }
                    DispatchQueue.main.async {
                        self.isShowLoader = false
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isShowLoader = false
                    }
                    error.localizedDescription
                    print("thanks for giving the error")
                }
            } else {
                DispatchQueue.main.async {
                    self.isShowLoader = false
                    self.showToast = true
                    self.toastMessage = "Failed to fetch data. Please try again later."
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.showToast = false
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func postMultiPartApiForFileUplod<T: Decodable>(requestUrl: URL,paramData:[String:Any],resultType: T.Type,fileName: String, completionHandler:@escaping(_ result:(Result<T, APIServiceError>))-> Void) {
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        var headers = ["Content-Type":"multipart/form-data"]
        if !FacultyUserDefaults.getAccessToken().isEmpty {
            headers["Authorization"] = "Bearer \(FacultyUserDefaults.getAccessToken())"
        }
        request.allHTTPHeaderFields = headers
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = NSMutableData()
        
        let fileDet = fileName
        let arrComp = fileName.components(separatedBy: ".")
        let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
        let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
        
        for (key, value) in paramData {
            
            //print("key = \(key), value = \(value)")
            
            if let fileData = value as? Data {
                httpBody.append(convertFileData(fieldName: key, fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
                print("fileData===>",fileData)
            } else if let strValue = value as? String {
                
                httpBody.appendString(convertFormField(named: key, value: strValue, using: boundary))
                
            } else if let dictValue = value as? [String: Any] {
                httpBody.append(formDataDictionary(key: key, dict: dictValue, boundary: boundary))
            } else if let arrayValue = value as? [Any] {
                httpBody.append(formDataArray(key: key, array: arrayValue, boundary: boundary))
            }
        }
        
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if let responseResult = response as? HTTPURLResponse, responseResult.statusCode == 401 {
                //NotificationCenter.default.post(name: Notification.Name("SignOutObserved"), object:nil)
            }
            
            if(error == nil && data != nil && data?.count != 0) {
                do {
                    if let valueData = data {
                        let responseVal = try JSONSerialization.jsonObject(with: valueData, options: .allowFragments)
                        print("Post Multipart Upload --responseVal = \(responseVal)")
                    }
                }catch let error {
                    debugPrint("error occured while decoding = \(error)")
                }
                do{
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    print("response===>", response)
                   
                    completionHandler(.success(response))
                }catch let error{
                    print("postMultiPartApiForFileUplod error = \(error)")
                    completionHandler(.failure(.decodeError))
                }
            }else{
                completionHandler(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
    
    func requestUploadFile(fileName: String,
                               paramBody:[String : Any],
                               completionHandler: @escaping (AssignmentAttachmentModel) -> Void) {
        let baseUrl = "https://ecs-dsapi-staging1.digivalitsolutions.com/api/v1/"
                let fileUploadUrl = URL(string: "\(baseUrl)assignment-settings/upload-attachment".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                self.isShowLoader = true
                postMultiPartApiForFileUplod(requestUrl: fileUploadUrl!, paramData: paramBody, resultType: AssignmentAttachmentModel.self, fileName: fileName ,completionHandler: {
                    result in
                    switch result {
                    case .success(let obj):
                        DispatchQueue.main.async {
                            completionHandler(obj)
                            print("success==>",obj)
                            DispatchQueue.main.async {
                                self.uploadDataForAttachment = obj
                                self.isShowLoader = false
                                print("uploadDataForAttachment===>",self.uploadDataForAttachment)
                            }
                        }
                    case .failure(let error):
                      //  log(error.localizedDescription)
                        DispatchQueue.main.async {
                           print("failure===>",error)
                            self.isShowLoader = false
                        }
                    }
                })
        }
    
    private func formDataArray(key: String, array: [Any], boundary: String) -> Data {
        
        let bodyData = NSMutableData()
        for (index,item) in array.enumerated() {
            
            if let strValue = item as? String {
                if let fileurl = URL(string: strValue), fileurl.isFileURL, let fileData = try? Data(contentsOf: fileurl) {
                    
                    let arrComp = strValue.components(separatedBy: ".")
                    let fileDet = arrComp.first ?? ""
                    let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
                    let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
                    
                    bodyData.append(convertFileData(fieldName: key+"[\(index)]", fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
                    
                } else {
                    
                    bodyData.appendString(convertFormField(named: key+"[\(index)]", value: strValue, using: boundary))
                }
            } else if let dictValue = item as? [String: Any] {
                bodyData.append(formDataDictionary(key: key+"[\(index)]", dict: dictValue, boundary: boundary))
            } else if let arrayValue = item as? [Any] {
                bodyData.append(formDataArray(key: key+"[\(index)]", array: arrayValue, boundary: boundary))                
            }
        }
        return bodyData as Data
    }
    
    func submitAssignmentApi(message: String,completion: (()-> Void)? = nil) {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0NTQ0NDQ1NDkiLCJpYXQiOjE3MDMxNTgwNjEsImV4cCI6MTcwMzE5NDA2MX0.hYpVJnxDutfUCgvuNj1btOgLcu1IuoihufvduM9-Ayw"
        guard let url = URL(string: "https://ecs-dsapi-staging1.digivalitsolutions.com/api/v1/assignment-comments/update") else {
            return
        }
        let attachmentsData = uploadDataForAttachment?.data
        let attachments: [String: String] = ["url": "\(attachmentsData?.url ?? "")","signedUrl": "\(attachmentsData?.signedURL ?? "")","size":"\(attachmentsData?.size ?? 0)","name": "\(attachmentsData?.name ?? "")"]
        let comments: [String:Any] = ["staffId": "649d8442e2cf074813d6b969","studentId": "649d8442e2cf074813d6b969","time": "2023-11-29T10:26:16.000Z","message": "\(message)","staffName": "Warning5 Testing","studentName":"Warning5 Testing","attachments": [attachments]]
        let body:[String: Any] = ["assignmentId": "6543736b1457bc1ff4a26862","studentId": "649d8442e2cf074813d6b969","comments": comments]

        let finalData = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.allHTTPHeaderFields = [ "_institution_id": "5e5d0f1a15b4d600173d5692",
                                        "_institution_calendar_id": "6513ccc2a7fe5301c44467dc"]
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            if let error = error {
                print("error==>",error.localizedDescription)
            }
            do {
                if let data = data {
                    let responsJson = try JSONSerialization.jsonObject(with: data)
                    print("responsJson", responsJson)
                  //  let result = try? JSONDecoder().decode(AssignmentsDataComment.self, from: data)
                    DispatchQueue.main.async {
                  //      self.AssignmentsListApiIntegration()
                        var newMessage = AssignmentsDataComment(id: UUID().uuidString, staffID: "649d8442e2cf074813d6b969", studentID: "649d8442e2cf074813d6b969", time: "2023-11-29T10:26:16.000Z", message: message, attachments:  [])
                        if let attachment = attachmentsData {
                            newMessage.attachments = [attachment]
                        }
                        self.filterDateModel[self.filterDateModel.count - 1].data.append(newMessage)
                        completion?()
                    }

                } else {
                    print("no data")
                    completion?()
                }
            } catch(let error) {
                completion?()
                print("error:",error.localizedDescription)
            }
        }
        .resume()
    }
    
    func convertFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        return fieldString
    }
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        return data as Data
    }
    
    private func formDataDictionary(key: String, dict: [String: Any], boundary: String) -> Data {
        
        let bodyData = NSMutableData()
        for (keyIn, value) in dict {
            
            //print("key = \(key), value = \(value)")
            
            if let strValue = value as? String {
                
                if let fileurl = URL(string: strValue), fileurl.isFileURL, let fileData = try? Data(contentsOf: fileurl) {
                    
                    let arrComp = strValue.components(separatedBy: ".")
                    let fileDet = arrComp.first ?? ""
                    let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
                    let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
                    
                    bodyData.append(convertFileData(fieldName: key+"[\(keyIn)]", fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
                    
                } else {
                    
                    bodyData.appendString(convertFormField(named: key+"[\(keyIn)]", value: strValue, using: boundary))
                }
                
            } else if let arrayValue = value as? [Any] {
                bodyData.append(formDataArray(key: key+"[\(keyIn)]", array: arrayValue, boundary: boundary))
                
            } else if let dictValue = value as? [String: Any] {
                bodyData.append(formDataDictionary(key: key+"[\(keyIn)]", dict: dictValue, boundary: boundary))
                
            }
        }
        return bodyData as Data
    }
    func documentImage(url: String) -> String {
        var imageName = ""
        let imageType = URL(string: url)?.pathExtension.lowercased()
        switch imageType {
        case "doc", "docx" :
            imageName = "doc"
        case "pdf" :
            imageName = "pdf"
        case "ppt","pptx" :
            imageName = "ppt"
        case "xls", "xlsx" :
            imageName = "xls"
        default :
            imageName = "doc"
        }
        return imageName
    }
    
    func showToast(message: String) {
        showToast = true
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showToast = false
        }
    }
    
    func fetchDocumentSize(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching document size: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let fileSize = ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: .file)
            DispatchQueue.main.async {
                self.documentSizeText = "Document Size: \(fileSize)"
            }
        }.resume()
    }

}
extension ViewingCommentsVM: DGAudioPlayerDelegate {
    func playbackTimeChanged(time: TimeInterval) {
        currentTime = audioPlayer.currentTime
        print("\(currentTime)")
    }
    
    func finishedPlaying() {
        print("finishedPlaying")
    }

    func preparedForPlay() {
        print("preparedForPlay")
    }

    func failedToPlay() {
        print("failedToPlay")
    }

    func readyToPlay() {
        duration = audioPlayer.duration
        print("\(duration)")
    }

    func didClickPlay() {
        print("didClickPlay")
    }

    func didClickPause() {
        print("didClickPause")
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


//let result = try? JSONDecoder().decode(CreateCommentsModel.self, from: data)
//DispatchQueue.main.async {
////      self.AssignmentsListApiIntegration()
//    if let newComment = result?.data {
//        self.filterDateModel[0].data.append(newComment)
//    }
//
//    print("submitAssignmentData===>",result)
////                        for index in 0..<self.filterDateModel.count{
////                            self.filterDateModel[index].data.append(submitAssignmentData)
////                        }
//    completion?()
//}
