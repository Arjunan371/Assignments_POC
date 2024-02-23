//
//import Foundation
//import UIKit
//
//public enum APIServiceError: Error {
//    case apiError
//    case invalidEndpoint
//    case invalidResponse
//    case noData
//    case decodeError
//    case fileNotFound
//}
//
//class HttpUtility {
//    
//    static let shared = HttpUtility()
//    private init() {}
//    
//    var defaultHeaders: [String: String] {
//        return [
//            "Content-Type": "application/json; charset=utf-8",
//            "_institution_calendar_id":ServiceSettings.shared.getInstitutionCalendarId(),
//            "_institution_id":"5e5d0f1a15b4d600173d5692",
//            "_user_id":Constants.getUserAccessId(),
//        ]
//    }
//    
//    func get<T:Decodable>(requestUrl: URL,
//                          header : [String: String]? = nil,
//                          resultType: T.Type,
//                          ignoreTokenCheck:Bool = false,
//                          completionHandler: @escaping(_ result: T?)-> Void) {
//        request(requestUrl: requestUrl,
//                header: header,
//                resultType: resultType,
//                methodType: .get,
//                ignoreTokenCheck: ignoreTokenCheck,
//                completionHandler: completionHandler)
//    }
//    
//    func post<T:Decodable>(requestUrl: URL,
//                          header : [String: String]? = nil,
//                          requestBody: [String:Any] = [:],
//                          resultType: T.Type,
//                          ignoreTokenCheck:Bool = false,
//                          completionHandler: @escaping(_ result: T?)-> Void) {
//        request(requestUrl: requestUrl,
//                header: header,
//                requestBody: requestBody,
//                resultType: resultType,
//                methodType: .post,
//                ignoreTokenCheck: ignoreTokenCheck,
//                completionHandler: completionHandler)
//    }
//    
//    func put<T:Decodable>(requestUrl: URL,
//                          header : [String: String]? = nil,
//                          requestBody: [String:Any] = [:],
//                          resultType: T.Type,
//                          ignoreTokenCheck:Bool = false,
//                          completionHandler: @escaping(_ result: T?)-> Void) {
//        request(requestUrl: requestUrl,
//                header: header,
//                requestBody: requestBody,
//                resultType: resultType,
//                methodType: .put,
//                ignoreTokenCheck: ignoreTokenCheck,
//                completionHandler: completionHandler)
//    }
//    
//    func delete<T:Decodable>(requestUrl: URL,
//                          header : [String: String]? = nil,
//                          requestBody: [String:Any] = [:],
//                          resultType: T.Type,
//                          ignoreTokenCheck:Bool = false,
//                          completionHandler: @escaping(_ result: T?)-> Void) {
//        request(requestUrl: requestUrl,
//                header: header,
//                requestBody: requestBody,
//                resultType: resultType,
//                methodType: .delete,
//                ignoreTokenCheck: ignoreTokenCheck,
//                completionHandler: completionHandler)
//    }
//    
//    func multiPart<T:Decodable>(requestUrl: URL,
//                                paramData: [String:Any],
//                                resultType: T.Type,
//                                ignoreTokenCheck:Bool = false,
//                                completionHandler: @escaping(_ result:(Result<T, APIServiceError>))-> Void) {
//        
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        let headers = ["Content-Type":"multipart/form-data"]
//        if !ignoreTokenCheck {
//            if JwtTokenServices.shared.isValidToken {
//                request.setValue("Bearer \(Constants.getUserAccessToken())", forHTTPHeaderField: "Authorization")
//            }
//        }
//        request.allHTTPHeaderFields = headers
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let httpBody = NSMutableData()
//        
//        for (key, value) in paramData {
//            //print("key = \(key), value = \(value)")
//            if let strValue = value as? String {
//                
//                if let fileurl = URL(string: strValue), fileurl.isFileURL, let fileData = try? Data(contentsOf: fileurl) {
//                    let fileDet = fileurl.lastPathComponent
//                    let arrComp = fileDet.components(separatedBy: ".")
//                    let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
//                    let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
//                    
//                    httpBody.append(convertFileData(fieldName: key, fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
//                    
//                } else {
//                    httpBody.appendString(convertFormField(named: key, value: strValue, using: boundary))
//                }
//                
//            } else if let dictValue = value as? [String: Any] {
//                httpBody.append(formDataDictionary(key: key, dict: dictValue, boundary: boundary))
//            } else if let arrayValue = value as? [Any] {
//                httpBody.append(formDataArray(key: key, array: arrayValue, boundary: boundary))
//            }
//        }
//        httpBody.appendString("--\(boundary)--")
//        request.httpBody = httpBody as Data
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let data = data {
//                do {
//                    let responseVal = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print("response Value = \(responseVal)")
//                    
//                    let response = try JSONDecoder().decode(T.self, from: data)
//                    completionHandler(.success(response))
//                } catch let decodingError {
//                    debugPrint(decodingError)
//                    completionHandler(.failure(.decodeError))
//                }
//            } else {
//                completionHandler(.failure(.invalidResponse))
//            }
//            
//        }
//        task.resume()
//    }
//    
//    private func request<T:Decodable>(requestUrl: URL,
//                              header : [String: String]? = nil,
//                              requestBody: [String:Any] = [:],
//                              resultType: T.Type,
//                              methodType: HTTPMethod,
//                              ignoreTokenCheck:Bool = false,
//                              completionHandler: @escaping(_ result: T?)-> Void) {
//        var urlRequest = getURLRequest(requestUrl: requestUrl,
//                                       header: header,
//                                       requestBody: requestBody,
//                                       methodType: methodType)
//        if !ignoreTokenCheck {
//            if JwtTokenServices.shared.isValidToken {
//                urlRequest.setValue("Bearer \(Constants.getUserAccessToken())", forHTTPHeaderField: "Authorization")
//            } else {
//                requestRefreshToken(requestUrl: requestUrl,
//                                          header: header,
//                                          requestBody: requestBody,
//                                          resultType: resultType,
//                                          methodType: methodType) { (result) in
//                    completionHandler(result)
//                }
//                return
//            }
//        }
//        request(urlRequest: urlRequest, resultType: resultType) { result in
//            completionHandler(result)
//        }
//        
//    }
//    
//    private func getURLRequest(requestUrl: URL, header : [String: String]? = nil,
//                               requestBody: [String:Any] = [:], methodType: HTTPMethod) -> URLRequest {
//        var urlRequest = URLRequest(url: requestUrl)
//        if !requestBody.isEmpty {
//            let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)
//            urlRequest.httpBody = jsonData
//        }
//        var headers = defaultHeaders
//        if header?.isEmpty == false {
//            headers.merge(header ?? [:]){(_, new) in new}
//        }
//        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.httpMethod = methodType.rawValue
//        return urlRequest
//    }
//    
//    private func request<T:Decodable>(urlRequest: URLRequest, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void) {
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 180
//        let session = URLSession(configuration: configuration)
//        
//        let dataTask =  session.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//         
//            if let data = data {
//                do {
//                    let responseVal = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print("response Value = \(responseVal)")
//                    
//                    let response = try JSONDecoder().decode(T.self, from: data)
//                    completionHandler(response)
//                } catch let decodingError {
//                    debugPrint(decodingError)
//                    completionHandler(nil)
//                }
//            } else {
//                completionHandler(nil)
//            }
//            
//        }
//        dataTask.resume()
//    }
//    
//    func requestRefreshToken<T:Decodable>(requestUrl: URL,
//                                          header : [String: String]? = nil,
//                                          requestBody: [String:Any] = [:],
//                                          resultType: T.Type,
//                                          methodType:HTTPMethod,
//                                          completionHandler:@escaping(_ result: T?)-> Void) {
//        
//        guard let urlRefresh = URL(string: "\(ApiLink.baseUrl + ApiLink.refreshToken)") else {
//            completionHandler(nil)
//            return
//        }
//        var urlRequest = URLRequest(url: urlRefresh)
//        urlRequest.httpMethod = "POST"
//        let headers = [
//            "Content-Type": "application/json; charset=utf-8"
//        ]
//        urlRequest.setValue("Bearer \(Constants.getUserRefreshToken())", forHTTPHeaderField: "Authorization")
//        urlRequest.allHTTPHeaderFields = headers
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 120
//        let session = URLSession(configuration: configuration)
//        let task =  session.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//        
//            if (httpUrlResponse as? HTTPURLResponse)?.statusCode == 401 {
//                DispatchQueue.main.async {
//                    self.moveToRegistrationVC()
//                }
//                completionHandler(nil)
//                return
//            }
//            if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(RefreshTokenModel.self, from: data)
//                    Constants.setUserAccessToken(response.data?.tokens?.access?.token ?? "")
//                    Constants.setUserRefreshToken(response.data?.tokens?.refresh?.token ?? "")
//                    self.request(requestUrl: requestUrl,
//                                 header: header,
//                                 requestBody: requestBody,
//                                 resultType: resultType,
//                                 methodType: methodType) { result in
//                        completionHandler(result)
//                    }
//                }
//                catch let decodingError {
//                    debugPrint(decodingError)
//                    completionHandler(nil)
//                }
//            } else {
//                completionHandler(nil)
//            }
//        
//       }
//       task.resume()
//    }
//    /*
//    func getApiData<T:Decodable>(requestUrl: URL,
//                                 resultType: T.Type,
//                                 header : [String: String]? = nil,
//                                 ignoreTokenCheck:Bool = false,
//                                 completionHandler: @escaping(_ result: T?) -> Void) {
//        
//        var urlRequest = URLRequest(url: requestUrl)
//        urlRequest.httpMethod = "GET"
//        //urlRequest.timeoutInterval = 30
//        var headers = [
//            "Content-Type": "application/json; charset=utf-8",
//            "_institution_calendar_id":ServiceSettings.shared.getInstitutionCalendarId(),
//            "_user_id":Constants.getUserAccessId(),
//            "_institution_id":"5e5d0f1a15b4d600173d5692"
//        ]
//        if header?.isEmpty == false {
//            headers.merge(header ?? [:]){(_, new) in new}
//            urlRequest.allHTTPHeaderFields = header
//        } else {
//            urlRequest.allHTTPHeaderFields = headers
//        }
//        
//        if JwtTokenServices.shared.isValidToken {
//            urlRequest.setValue("Bearer \(Constants.getUserAccessToken())", forHTTPHeaderField: "Authorization")
//        }else {
//            if !ignoreTokenCheck {
//                self.postApiRefreshToken(requestUrl: requestUrl, header: header, requestBody: [:], resultType: resultType, methodType: HTTPMethod.get) { (result) in
//                    completionHandler(result)
//                }
//                return
//            }
//        }
//        
//        URLSession.shared.dataTask(with: urlRequest as URLRequest) { (responseData, httpUrlResponse, error) in
//            
//            if (error == nil && responseData != nil && responseData?.count != 0) {
//                
//                do {
//                    if let valueData = responseData {
//                        let responseVal = try JSONSerialization.jsonObject(with: valueData, options: .mutableContainers)
//                        print("GET METHOD --responseVal = \(responseVal)")
//                    }
//                    guard let respCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode else {
//                        completionHandler(nil)
//                        return
//                    }
//                    if respCode == 401 {
//                        self.postApiRefreshToken(requestUrl: requestUrl, header: header, requestBody: [:], resultType: resultType, methodType: HTTPMethod.get) { (result) in
//                            completionHandler(result)
//                        }
//                    } else {
//                        let decoder = JSONDecoder()
//                        let result = try decoder.decode(T.self, from: responseData!)
//                        completionHandler(result)
//                    }
//                    
//                }
//                catch let error {
//                    debugPrint("error occured while decoding = \(error)")
//                    completionHandler(nil)
//                }
//            } else {
//                completionHandler(nil)
//            }
//        }.resume()
//        
//    }
//    
//    func postApiData<T:Decodable>(requestUrl: URL,
//                                  header : [String: String]? = nil ,
//                                  requestBody: [String:Any],
//                                  resultType: T.Type,
//                                  methodType:HTTPMethod,
//                                  ignoreTokenCheck:Bool = false,
//                                  completionHandler:@escaping(_ result: T?)-> Void){
//        
//        var urlRequest = URLRequest(url: requestUrl)
//        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)
//        var headers = [
//            "Content-Type": "application/json; charset=utf-8",
//            "_institution_calendar_id":ServiceSettings.shared.getInstitutionCalendarId(),
//            "_institution_id":"5e5d0f1a15b4d600173d5692"
//        ]
//        if header?.isEmpty == false {
//            headers.merge(header ?? [:]){(_, new) in new}
//            urlRequest.allHTTPHeaderFields = header
//        } else {
//            urlRequest.allHTTPHeaderFields = headers
//        }
//        urlRequest.httpMethod = methodType.rawValue
//        urlRequest.httpBody = jsonData
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 180
//        let session = URLSession(configuration: configuration)
//        if JwtTokenServices.shared.isValidToken {
//            urlRequest.setValue("Bearer \(Constants.getUserAccessToken())", forHTTPHeaderField: "Authorization")
//        }else {
//            if !ignoreTokenCheck {
//                self.postApiRefreshToken(requestUrl: requestUrl,
//                                          header: header,
//                                          requestBody: requestBody,
//                                          resultType: resultType,
//                                          methodType: HTTPMethod.post) { (result) in
//                    completionHandler(result)
//                }
//                return
//            }
//        }
//        
//       let task =  session.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//        
//        if(error == nil && data != nil && data?.count != 0) {
//            
//            do {
//                guard let respCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode else {
//                    completionHandler(nil)
//                    return
//                }
//                if let valueData = data {
//                    let responseVal = try JSONSerialization.jsonObject(with: valueData, options: .mutableContainers)
//                    print("GET METHOD --responseVal = \(responseVal)")
//                }
//                if respCode == 401 {
//                    self.postApiRefreshToken(requestUrl: requestUrl, header: header, requestBody: requestBody, resultType: resultType, methodType: HTTPMethod.post) { (result) in
//                        completionHandler(result)
//                    }
//                } else {
//                    let response = try JSONDecoder().decode(T.self, from: data!)
//                    completionHandler(response)
//                }
//            }
//            catch let decodingError {
//                completionHandler(nil)
//                debugPrint(decodingError)
//            }
//        }else{
//            completionHandler(nil)
//        }
//       }
//       task.resume()
//    }
//    
//    func postApiRefreshToken<T:Decodable>(requestUrl: URL, header : [String: String]? = nil , requestBody: [String:Any] = [:], resultType: T.Type, methodType:HTTPMethod, completionHandler:@escaping(_ result: T?)-> Void){
//        
//        let urlRefresh = URL(string: "\(ApiLink.baseUrl + ApiLink.refreshToken)")!
//        
//        var urlRequest = URLRequest(url: urlRefresh)
//        urlRequest.httpMethod = "POST"
//        
//        let headers = [
//            "Content-Type": "application/json; charset=utf-8"
//        ]
//        urlRequest.setValue("Bearer \(Constants.getUserRefreshToken())", forHTTPHeaderField: "Authorization")
//        urlRequest.allHTTPHeaderFields = headers
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 120
//        let session = URLSession(configuration: configuration)
//       let task =  session.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//        
//        if(error == nil && data != nil && data?.count != 0) {
//            if (httpUrlResponse as? HTTPURLResponse)?.statusCode == 401 {
//                DispatchQueue.main.async {
//                    self.moveToRegistrationVC()
//                }
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(RefreshTokenModel.self, from: data!)
//                Constants.setUserAccessToken(response.data?.tokens?.access?.token ?? "")
//                Constants.setUserRefreshToken(response.data?.tokens?.refresh?.token ?? "")
//                switch methodType {
//                
//                case .get:
//                    self.getApiData(requestUrl: requestUrl, resultType: resultType, header: header) { (result) in
//                        completionHandler(result)
//                    }
//                    break
//                case .post:
//                    self.postApiData(requestUrl: requestUrl,header: header, requestBody: requestBody, resultType: resultType, methodType: methodType) { (result) in
//                        completionHandler(result)
//                    }
//                    break
//                case .put:
//                    self.putApiData(requestUrl: requestUrl, header: header, requestBody: requestBody, resultType: resultType, methodType: methodType) { (result) in
//                        completionHandler(result)
//                    }
//                    break
//                case .delete:
//                    self.deleteApiData(requestUrl: requestUrl, header: header, requestBody: requestBody, resultType: resultType) { result in
//                        completionHandler(result)
//                    }
//                    break
//                default:
//                    completionHandler(nil)
//                }
//                //completionHandler(response)
//            }
//            catch let decodingError {
//                completionHandler(nil)
//                debugPrint(decodingError)
//            }
//        }else{
//            completionHandler(nil)
//        }
//       }
//       task.resume()
//    }
//    func postMultiPartApiForFileUplod1<T: Decodable>(requestUrl: URL,
//                                                    paramData: [String:Any],
//                                                    resultType: T.Type,
//                                                    completionHandler: @escaping(_ result:(Result<T, APIServiceError>))-> Void) {
//        
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//        var headers = ["Content-Type":"multipart/form-data"]
//        if !Constants.getUserRefreshToken().isEmpty {
//            headers["Authorization"] = "Bearer \(Constants.getUserRefreshToken())"
//        }
//        request.allHTTPHeaderFields = headers
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        let httpBody = NSMutableData()
//        
//        for (key, value) in paramData {
//            
//            //print("key = \(key), value = \(value)")
//            
//            if let strValue = value as? String {
//                
//                if let fileurl = URL(string: strValue), fileurl.isFileURL, let fileData = try? Data(contentsOf: fileurl) {
//                    
//                    let fileDet = fileurl.lastPathComponent
//                    let arrComp = fileDet.components(separatedBy: ".")
//                    let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
//                    let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
//                    
//                    httpBody.append(convertFileData(fieldName: key, fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
//                    
//                } else {
//                
//                    httpBody.appendString(convertFormField(named: key, value: strValue, using: boundary))
//                }
//                
//            } else if let dictValue = value as? [String: Any] {
//                httpBody.append(formDataDictionary(key: key, dict: dictValue, boundary: boundary))
//            } else if let arrayValue = value as? [Any] {
//                httpBody.append(formDataArray(key: key, array: arrayValue, boundary: boundary))
//            }
//        }
//        
//        httpBody.appendString("--\(boundary)--")
//        request.httpBody = httpBody as Data
//        let task = URLSession.shared.dataTask(with: request) {
//        data, response, error in
//            
//            if let responseResult = response as? HTTPURLResponse, responseResult.statusCode == 401 {
//                //NotificationCenter.default.post(name: Notification.Name("SignOutObserved"), object:nil)
//            }
//            
//            if(error == nil && data != nil && data?.count != 0) {
//                do {
//                    if let valueData = data {
//                        let responseVal = try JSONSerialization.jsonObject(with: valueData, options: .allowFragments)
//                        print("Post Multipart Upload --responseVal = \(responseVal)")
//                    }
//                }catch let error {
//                    debugPrint("error occured while decoding = \(error)")
//                }
//                do{
//                    let response = try JSONDecoder().decode(T.self, from: data!)
//                    completionHandler(.success(response))
//                }catch let error{
//                    print("postMultiPartApiForFileUplod error = \(error)")
//                    completionHandler(.failure(.decodeError))
//                }
//            }else{
//                completionHandler(.failure(.invalidResponse))
//            }
//        }
//        task.resume()
//    } */
//    private func formDataArray(key: String, array: [Any], boundary: String) -> Data {
//        
//        let bodyData = NSMutableData()
//        for (index,item) in array.enumerated() {
//            
//            if let strValue = item as? String {
//                if let fileurl = URL(string: strValue), fileurl.isFileURL, let fileData = try? Data(contentsOf: fileurl) {
//                    
//                    let arrComp = strValue.components(separatedBy: ".")
//                    let fileDet = arrComp.first ?? ""
//                    let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
//                    let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
//                    
//                    bodyData.append(convertFileData(fieldName: key+"[\(index)]", fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
//                    
//                } else {
//                
//                    bodyData.appendString(convertFormField(named: key+"[\(index)]", value: strValue, using: boundary))
//                }
//            } else if let dictValue = item as? [String: Any] {
//                bodyData.append(formDataDictionary(key: key+"[\(index)]", dict: dictValue, boundary: boundary))
//            } else if let arrayValue = item as? [Any] {
//                bodyData.append(formDataArray(key: key+"[\(index)]", array: arrayValue, boundary: boundary))
//                
//            }
//        }
//        return bodyData as Data
//    }
//    private func formDataDictionary(key: String, dict: [String: Any], boundary: String) -> Data {
//        
//        let bodyData = NSMutableData()
//        for (keyIn, value) in dict {
//            
//            //print("key = \(key), value = \(value)")
//            
//            if let strValue = value as? String {
//                
//                if let fileurl = URL(string: strValue), fileurl.isFileURL, let fileData = try? Data(contentsOf: fileurl) {
//                    
//                    let arrComp = strValue.components(separatedBy: ".")
//                    let fileDet = arrComp.first ?? ""
//                    let extensionFile = (arrComp.count > 1 ? arrComp.last : "")
//                    let mimeTypes = MimeTypes.MimeType(ext: extensionFile)
//                    
//                    bodyData.append(convertFileData(fieldName: key+"[\(keyIn)]", fileName: "\(fileDet)", mimeType: "\(mimeTypes)", fileData: fileData, using: boundary))
//                    
//                } else {
//                
//                    bodyData.appendString(convertFormField(named: key+"[\(keyIn)]", value: strValue, using: boundary))
//                }
//                
//            } else if let arrayValue = value as? [Any] {
//                bodyData.append(formDataArray(key: key+"[\(keyIn)]", array: arrayValue, boundary: boundary))
//                
//            } else if let dictValue = value as? [String: Any] {
//                bodyData.append(formDataDictionary(key: key+"[\(keyIn)]", dict: dictValue, boundary: boundary))
//                
//            }
//        }
//        return bodyData as Data
//    }
//    /*
//    func putApiData<T:Decodable>(requestUrl: URL,
//                                 header : [String: String]? = nil ,
//                                 requestBody: [String:Any],
//                                 resultType: T.Type,
//                                 methodType:HTTPMethod,
//                                 ignoreTokenCheck:Bool = false,
//                                 completionHandler:@escaping(_ result: T?)-> Void){
//        
//        var urlRequest = URLRequest(url: requestUrl)
//        urlRequest.httpMethod = "PUT"
//        
//         let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)
//        
//        var headers = [
//            "Content-Type": "application/json; charset=utf-8",
//            "_institution_calendar_id":ServiceSettings.shared.getInstitutionCalendarId(),
//            "_institution_id":"5e5d0f1a15b4d600173d5692"
//        ]
//        if header?.isEmpty == false {
//            headers.merge(header ?? [:]){(_, new) in new}
//            urlRequest.allHTTPHeaderFields = header
//        } else {
//            urlRequest.allHTTPHeaderFields = headers
//        }
//        if JwtTokenServices.shared.isValidToken {
//            urlRequest.setValue("Bearer \(Constants.getUserAccessToken())", forHTTPHeaderField: "Authorization")
//        }else {
//            if !ignoreTokenCheck {
//                self.postApiRefreshToken(requestUrl: requestUrl,
//                                          header: header,
//                                          requestBody: requestBody,
//                                          resultType: resultType,
//                                          methodType: HTTPMethod.put) { (result) in
//                    completionHandler(result)
//                }
//                return
//            }
//        }
//        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.httpBody = jsonData
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 60
//        configuration.timeoutIntervalForResource = 180
//        let session = URLSession(configuration: configuration)
//        
//       let task =  session.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//
//            
//        if(error == nil && data != nil && data?.count != 0) {
//            
//            do {
//                if let valueData = data {
//                    let responseVal = try JSONSerialization.jsonObject(with: valueData, options: .allowFragments)
//                    print("PUT METHOD --responseVal = \(responseVal)")
//                }
//                guard let respCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode else {
//                    completionHandler(nil)
//                    return
//                }
//                if respCode == 401 {
//                    self.postApiRefreshToken(requestUrl: requestUrl, header: header, requestBody: requestBody, resultType: resultType, methodType: HTTPMethod.put) { (result) in
//                        completionHandler(result)
//                    }
//                } else {
//                    let response = try JSONDecoder().decode(T.self, from: data!)
//                    completionHandler(response)
//                }
//            }
//            catch let decodingError {
//                completionHandler(nil)
//                debugPrint(decodingError)
//            }
//        }else{
//            completionHandler(nil)
//        }
//       }
//       task.resume()
//    }
//    func deleteApiData<T:Decodable>(requestUrl: URL, header : [String: String]? = nil , requestBody: [String:Any], resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void) {
//        
//        var urlRequest = URLRequest(url: requestUrl)
//        urlRequest.httpMethod = "DELETE"
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: requestBody, options: JSONSerialization.WritingOptions.prettyPrinted)
//
//        var headers = [
//            "Content-Type": "application/json; charset=utf-8",
//            "_institution_calendar_id":ServiceSettings.shared.getInstitutionCalendarId(),
//            "_institution_id":"5e5d0f1a15b4d600173d5692"
//        ]
//        if header?.isEmpty == false {
//            headers.merge(header ?? [:]){(_, new) in new}
//            urlRequest.allHTTPHeaderFields = header
//        } else {
//            urlRequest.allHTTPHeaderFields = headers
//        }
//        if !Constants.getUserAccessToken().isEmpty {
//            urlRequest.setValue("Bearer \(Constants.getUserAccessToken())", forHTTPHeaderField: "Authorization")
//        }
//        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.httpBody = jsonData
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 120
//        configuration.timeoutIntervalForResource = 180
//        let session = URLSession(configuration: configuration)
//        urlRequest.timeoutInterval = 200
//
//        let task =  session.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
//
//            
//        if(error == nil && data != nil && data?.count != 0) {
//            
//            do {
//                if let valueData = data {
//                    let responseVal = try JSONSerialization.jsonObject(with: valueData, options: .allowFragments)
//                    print("PUT METHOD --responseVal = \(responseVal)")
//                }
//                guard let respCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode else {
//                    completionHandler(nil)
//                    return
//                }
//                if respCode == 401 {
//                    self.postApiRefreshToken(requestUrl: requestUrl, header: header, requestBody: requestBody, resultType: resultType, methodType: HTTPMethod.delete) { (result) in
//                        completionHandler(result)
//                    }
//                } else {
//                    let response = try JSONDecoder().decode(T.self, from: data!)
//                    completionHandler(response)
//                }
//            }
//            catch let decodingError {
//                completionHandler(nil)
//                debugPrint(decodingError)
//            }
//        }else{
//            completionHandler(nil)
//        }
//        }
//        task.resume()
//    }
//    */
//    func convertFormField(named name: String, value: String, using boundary: String) -> String {
//        var fieldString = "--\(boundary)\r\n"
//        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
//        fieldString += "\r\n"
//        fieldString += "\(value)\r\n"
//        return fieldString
//    }
//
//    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
//        let data = NSMutableData()
//        data.appendString("--\(boundary)\r\n")
//        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
//        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
//        data.append(fileData)
//        data.appendString("\r\n")
//        return data as Data
//    }
//    func moveToRegistrationVC() {
//        guard !(UIApplication.topViewController()?.isKind(of: SigninVC.self) ?? false) else {
//            return
//        }
//        var sceneDelegate: SceneDelegate? {
//                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                    let delegate = windowScene.delegate as? SceneDelegate else { return nil }
//                 return delegate
//        }
//        Constants.setChatToken("")
//        Constants.setUserGender("")
//        Constants.setUserAccessId("")
//        Constants.setUserEmail("")
//        Constants.setUserAccessToken("")
//        Constants.setUserRefreshToken("")
//        Constants.setSessionInfo([])
//        CoreDataManager.sharedManager.deleteAll(entity: "UserInfo")
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        InprogressView.shared.stop()
//        AppManager.deleteDirectory(directoryName: "ProfileImage")
//        Toast().showMessage(message: "Please Authenticate", duration: 2)
//        let navController = sceneDelegate?.window?.rootViewController as? UINavigationController
//        AppFlow.setRootAsLogin(navController)
//        NotificationCenter.default.post(name: NSNotification.Name.init("DidDashboardRemoved"), object: nil)
//    }
//}
//
//extension NSMutableData {
//    func appendString(_ string: String) {
//        if let data = string.data(using: .utf8) {
//            self.append(data)
//        }
//    }
//}
//
