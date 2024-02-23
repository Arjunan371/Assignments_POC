////
////  Constant.swift
////  DigiStudennt
////
////  Created by Ragul kts on 26/08/20.
////  Copyright © 2020 Ragul kts. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//
//struct Constants {
//    static let loaderView = UIActivityIndicatorView()
//    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    static let screenHeight : CGFloat = UIScreen.main.bounds.height
//    static let screenWidth : CGFloat = UIScreen.main.bounds.width
//    static let inprogressHeight: CGFloat = 28
//    
//    static func setSocketListener(_ info: SigninModel.SocketEventID) {
//        if let data = try? JSONEncoder().encode(info) {
//            UserDefaults.standard.set(data, forKey: "SocketListener")
//            UserDefaults.standard.synchronize()
//        }
//        
//    }
//    static func getSocketListener() -> SigninModel.SocketEventID? {
//        
//        guard let data = UserDefaults.standard.data(forKey: "SocketListener"), let eventObj = try? JSONDecoder().decode(SigninModel.SocketEventID.self, from: data)  else {
//            return nil
//           }
//           return eventObj
//    }
//    static func getChatToken()->String {
//        guard let token = UserDefaults.standard.string(forKey: "ChatToken") else {return ""}
//        return token
//    }
//    
//    static func setChatToken(_ token: String) {
//        UserDefaults.standard.set(token, forKey: "ChatToken")
//        UserDefaults.standard.synchronize()
//    }
//    static func setSessionInfo(_ info: [[String:Any]]) {
//        
//        UserDefaults.standard.set(info, forKey: "SessionInfoKey")
//        UserDefaults.standard.synchronize()
//        
//    }
//    
//    static func getSessionInfo() -> [[String:Any]] {
//           
//        guard let arr = UserDefaults.standard.array(forKey: "SessionInfoKey") as? [[String: Any]] else {
//            return []
//           }
//           return arr
//    }
//    static func setPushUserInfo(_ info: [AnyHashable:Any]) {
//        UserDefaults.standard.set(info, forKey: "push_info")
//        UserDefaults.standard.synchronize()
//        
//    }
//    
//    static func getPushUserInfo() -> [AnyHashable:Any] {
//           
//        guard let id = UserDefaults.standard.dictionary(forKey: "push_info") else {
//            return [:]
//           }
//           return id
//    }
//    
//    static func getUserAccessToken() -> String {
//           
//           guard let userid = UserDefaults.standard.string(forKey: "access_token") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return userid
//    }
//    static func setUserAccessToken(_ userid: String) {
//        UserDefaults.standard.set(userid, forKey: "access_token")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getUserRefreshToken() -> String {
//           
//           guard let userid = UserDefaults.standard.string(forKey: "access_refresh") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return userid
//    }
//    static func setUserRefreshToken(_ userid: String) {
//        UserDefaults.standard.set(userid, forKey: "access_refresh")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getUserAccessId() -> String {
//           
//           guard let userid = UserDefaults.standard.string(forKey: "access_id") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return userid
//    }
//    static func setUserAccessId(_ userid: String) {
//        UserDefaults.standard.set(userid, forKey: "access_id")
//        UserDefaults.standard.synchronize()
//    }
//    static func setUserId(_ userid: String) {
//        UserDefaults.standard.set(userid, forKey: "userid")
//        UserDefaults.standard.synchronize()
//    }
//    static func getUserId() -> String {
//           
//           guard let userid = UserDefaults.standard.string(forKey: "userid") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return userid
//    }
//    static func isUserLoggedIn() -> Bool {
//        
//        guard let userid = UserDefaults.standard.string(forKey: "access_id") else {
//            return false
//        }
//        UserDefaults.standard.synchronize()
// 
//        return !userid.isEmpty
//    }
//    static func setUserEmail(_ userid: String) {
//        UserDefaults.standard.set(userid, forKey: "useremailid")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getUserEmail() -> String {
//           
//           guard let userid = UserDefaults.standard.string(forKey: "useremailid") else {
//               return "Email Id"
//           }
//           UserDefaults.standard.synchronize()
//           return userid
//    }
//    static func setUserGender(_ userid: String) {
//        UserDefaults.standard.set(userid, forKey: "user_gender")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getUserGender() -> String {
//           
//           guard let userid = UserDefaults.standard.string(forKey: "user_gender") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return userid
//    }
//    static func setFcmToken(_ token: String) {
//        UserDefaults.standard.set(token, forKey: "fcmtoken")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getFcmToken() -> String {
//           
//           guard let token = UserDefaults.standard.string(forKey: "fcmtoken") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return token
//    }
//    static func setApiToken(_ token: String) {
//        UserDefaults.standard.set(token, forKey: "apitoken")
//        UserDefaults.standard.synchronize()
//    }
//    static func getApiToken() -> String {
//           
//           guard let apiToken = UserDefaults.standard.string(forKey: "apitoken") else {
//               return ""
//           }
//           UserDefaults.standard.synchronize()
//           return apiToken
//    }
//    static func getCurrentLang() -> String {
//        guard let lang = UserDefaults.standard.string(forKey: "currentLang"), !lang.isEmpty else {
//            return "English"
//        }
//        UserDefaults.standard.synchronize()
//        return lang
//    }
//     
//    static func setCurrentLang(_ lang: String) {
//        UserDefaults.standard.set(lang, forKey: "currentLang")
//        UserDefaults.standard.synchronize()
//    }
//     
//    static func getLangCode() -> String {
//        switch getCurrentLang() {
//        case "English":
//            return "en"
//        case "العربية":
//            return "ar"
//        default:
//            return "en"
//        }
//        
//    }
//    static func appendParams(urlStr:String, params: [String]) -> String {
//        var urlString : String = urlStr
//        params.enumerated().forEach({ index,param in
//            urlString += param
//            if index < params.count-1 {
//                urlString = urlString + "/"
//            }
//        })
//        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//    }
//    
//    static func setCoursesAndCollegeTypeMap(programListModel:ProgramListModel){
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(programListModel), forKey: "CoursesAndCollegeTypeMap")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getCoursesAndCollegeTypeMap()->ProgramListModel? {
//        var userData: ProgramListModel?
//        if let data = UserDefaults.standard.value(forKey: "CoursesAndCollegeTypeMap") as? Data {
//            userData = try? PropertyListDecoder().decode(ProgramListModel.self, from: data)
//            return userData
//        } else {
//            return userData
//        }
//    }
//    static func setUsersCollege(collage: CollegeListModel.College?) {
//        UserDefaults.standard.save(customObject: collage, inKey: "UsersCollege")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getUsersCollege() -> CollegeListModel.College? {
//        return UserDefaults.standard.object(CollegeListModel.College.self, with: "UsersCollege")
//    }
//    
//    static func setBleDistance(distance: Double) {
//        UserDefaults.standard.set(distance, forKey: "BleDistance")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getBleDistance() -> Double {
//        let distance = UserDefaults.standard.double(forKey: "BleDistance")
//        return distance == 0 ? 5 : distance
//    }
//    
//    static func setStaffBleDistance(distance: Double) {
//        UserDefaults.standard.set(distance, forKey: "StaffBleDistance")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getStaffBleDistance() -> Double {
//        let distance = UserDefaults.standard.double(forKey: "StaffBleDistance")
//        return distance == 0 ? 10 : distance
//    }
//}
//
//
////MARK: Api Userdefaults
//extension Constants {
//    static func setBaseUrl(_ baseUrl: String) {
//        UserDefaults.standard.set(baseUrl, forKey: "BaseUrl")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getBaseUrl() -> String? {
//        UserDefaults.standard.string(forKey: "BaseUrl")
//    }
//    
//    static func setSocketUrl(_ socketUrl: String) {
//        UserDefaults.standard.set(socketUrl, forKey: "SocketUrl")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getSocketUrl() -> String? {
//        UserDefaults.standard.string(forKey: "SocketUrl")
//    }
//    
//    static func setFacialUrl(_ facialUrl: String) {
//        UserDefaults.standard.set(facialUrl, forKey: "FacialUrl")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getFacialUrl() -> String? {
//        UserDefaults.standard.string(forKey: "FacialUrl")
//    }
//    
//    static func setChatApiKey(_ chatApiKey: String) {
//        UserDefaults.standard.set(chatApiKey, forKey: "ChatApiKey")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getChatApiKey() -> String? {
//        UserDefaults.standard.string(forKey: "ChatApiKey")
//    }
//    
//    static func setChatFeature(enabled: Bool) {
//        UserDefaults.standard.set(enabled, forKey: "ChatFeature")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getChatFeatureEnabled() -> Bool? {
//        UserDefaults.standard.bool(forKey: "ChatFeature")
//    }
//    
//    static func setStudentFaceAuthFeature(enabled: Bool) {
//        UserDefaults.standard.set(enabled, forKey: "StudentFaceAuthFeature")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getStudentFaceAuthFeatureEnabled() -> Bool? {
//        UserDefaults.standard.bool(forKey: "StudentFaceAuthFeature")
//    }
//    
//    static func setLabelFeature(enabled: Bool) {
//        UserDefaults.standard.set(enabled, forKey: "LabelFeature")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getLabelFeatureEnabled() -> Bool? {
//        UserDefaults.standard.bool(forKey: "LabelFeature")
//    }
//}
//
//
//
//enum ApiConnection {
//    case release
//    case demo
//    case dev
//    case staging
//    case uat
//    
//    var ApiDomain:String {
//#if DEBUG
//        if let apiDomain = Constants.getBaseUrl(){
//            return apiDomain
//        }
//#endif
//        switch self {
//        case .release:
//            return "https://ds.api.digivalsolutions.com"
//        case .uat:
//            return "https://uat.api.digischeduler.digivalsolutions.com"
//        case .demo:
//            return "https://dsapi-demo.digivalitsolutions.com"
//        case .dev:
//            return "https://dcapi-dev.digivalitsolutions.com"
//        case .staging:
//            return "https://ecs-dsapi-staging.digivalitsolutions.com"//"https://dcapi-staging.digivalitsolutions.com"
//        }
//    }
//    
//    var SocketDomain:String {
//#if DEBUG
//        if let socketDomain = Constants.getSocketUrl(){
//            return socketDomain
//        }
//#endif
//        switch self {
//        case .release:
//            return "https://dscron.digischeduler.digivalsolutions.com"
//        case .uat:
//            return "https://devdscron.api.digischeduler.digivalsolutions.com"
//        case .demo:
//            return "https://dscron-demo.digivalitsolutions.com"
//        case .dev:
//            return "https://dscron-dev.digivalitsolutions.com"
//        case .staging:
//            return "https://ecs-dscron-staging.digivalitsolutions.com"//"https://dscron-staging.digivalitsolutions.com"
//        }
//    }
//    
//    var FacialDomain:String {
//#if DEBUG
//        if let facialDomain = Constants.getFacialUrl() {
//            return facialDomain
//        }
//#endif
//        switch self {
//        case .release:
//            return "https://ecs.auth.digivalsolutions.com/api/v0/auth/facial"
//        case .uat:
//            return "https://uat.auth.digivalsolutions.com/api/v0/auth/facial"
//        case .demo:
//            return "https://ecs-auth-demo.digivalitsolutions.com/api"
//        case .dev:
//            return "https://auth-dev.digivalitsolutions.com/api/v0/auth/facial"
//        case .staging:
//            return "https://auth-staging.digivalitsolutions.com/api/v0/auth/facial"
//        }
//    }
//    
//    var ChatDomain:String {
//#if DEBUG
//        if let chatDomain = Constants.getChatApiKey() {
//            return chatDomain
//        }
//#endif
//        switch self {
//        case .release:
//            return "yr4w5ncvvpvn"//yr4w5ncvvpvn
//        case .uat:
//            return "yr4w5ncvvpvn"
//        case .demo:
//            return "cm9fqffc9csz"
//        case .dev:
//            return "r98xryxj6t7s"
//        case .staging:
//            return "r98xryxj6t7s"
//        }
//    }
//}
//
//public enum NotifyOption{
//    case DELETE
//    case PUT
//}
//
//public func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
//#if !RELEASE || !SHANMUGA_RELEASE || !ALRAYAN_RELEASE
//    let output = items.map { "\($0)" }.joined(separator: separator)
//    Swift.print(output, terminator: terminator)
//#endif
//}
//
//
////MARK: Feature Flags
//extension Constants {
//    static func setChatEnabled(value: String) {
//        UserDefaults.standard.set(value, forKey: "isChatEnabled")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func isChatEnabled() -> Bool {
//        let value = UserDefaults.standard.string(forKey:"isChatEnabled") ?? "true"
//        return value == "true"
//    }
//    
//    static func setLabelChanges(value: String) {
//        UserDefaults.standard.set(value, forKey: "isLabelChangesEnabled")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func isLabelChangesEnabled() -> Bool {
//        let value = UserDefaults.standard.string(forKey: "isLabelChangesEnabled") ?? "false"
//        return value == "true"
//    }
//    
//    static func setFaceAuthType(type: String) {
//        UserDefaults.standard.set(type, forKey: "faceAuthType")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func faceAuthType() -> String {
//        UserDefaults.standard.string(forKey: "faceAuthType") ?? "mobile"
//    }
//    
//    static func setFaceVerifyMode(type: String) {
//        UserDefaults.standard.set(type, forKey: "FACE_VERIFY_MODE")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getFaceVerifyMode() -> String {
//        UserDefaults.standard.string(forKey: "FACE_VERIFY_MODE") ?? "online"
//    }
//    
//    static func setActivityEnabled(type: String) {
//        UserDefaults.standard.set(type, forKey: "ACTIVITY_ENABLED")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func isActivityEnabled() -> String {
//        UserDefaults.standard.string(forKey: "ACTIVITY_ENABLED") ?? "true"
//    }
//    
//    static func setAnnouncementEnabledV1(type: String) {
//        UserDefaults.standard.set(type, forKey: "ANNOUNCEMENTV1")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func isAnnouncementEnabledV1() -> String {
//        UserDefaults.standard.string(forKey: "ANNOUNCEMENTV1") ?? "false"
//    }
//    
//    static func setAnnouncementEnabledV2(type: String) {
//        UserDefaults.standard.set(type, forKey: "ANNOUNCEMENTV2")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func isAnnouncementEnabledV2() -> String {
//        UserDefaults.standard.string(forKey: "ANNOUNCEMENTV2") ?? "false"
//    }
//    
//    static func setServiceAuthKey(type: String) {
//        UserDefaults.standard.set(type, forKey: "SERVICE_AUTH")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getServiceAuthKey() -> String {
//        UserDefaults.standard.string(forKey: "SERVICE_AUTH") ?? ""
//    }
//    
//    static func setMultiCalendarKey(type: String) {
//        UserDefaults.standard.set(type, forKey: "MULTI_CALENDAR")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getMultiCalendarKey() -> String {
//        UserDefaults.standard.string(forKey: "MULTI_CALENDAR") ?? ""
//    }
//    
//    static func setBleRangeKey(type: String) {
//        UserDefaults.standard.set(type, forKey: "BLE_RANGE")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getBleRangeKey() -> String {
//        UserDefaults.standard.string(forKey: "BLE_RANGE") ?? ""
//    }
//    
//    static func setTimeStampKey(type: String) {
//        UserDefaults.standard.set(type, forKey: "TIME_STAMP")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getTimeStampKey() -> String {
//        UserDefaults.standard.string(forKey: "TIME_STAMP") ?? "false"
//    }
//    
//    static func setShowLms(type: String) {
//        UserDefaults.standard.set(type, forKey: "LMS_VERSION")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getShowLms() -> String {
//        UserDefaults.standard.string(forKey: "LMS_VERSION") ?? ""
//    }
//    
//    static func setFaceAnomaly(type: String) {
//        UserDefaults.standard.set(type, forKey: "FACE_ANOMALY")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getFaceAnomaly() -> String {
//        UserDefaults.standard.string(forKey: "FACE_ANOMALY") ?? ""
//    }
//    
//    static func setFaceVerify(type: String) {
//        UserDefaults.standard.set(type, forKey: "FACE_VERIFY")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getFaceVerify() -> String {
//        UserDefaults.standard.string(forKey: "FACE_VERIFY") ?? ""
//    }
//    
//    static func setLocalFaceTest(value: String) {
//        UserDefaults.standard.set(value, forKey: "LOCAL_FACE_TEST")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getLocalFaceTest() -> String {
//        UserDefaults.standard.string(forKey: "LOCAL_FACE_TEST") ?? ""
//    }
//    
//    static func setAnomalyRestrict(value: String) {
//        UserDefaults.standard.set(value, forKey: "ANOMALY_RESTRICT")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getAnomalyRestrict() -> String {
//        UserDefaults.standard.string(forKey: "ANOMALY_RESTRICT") ?? ""
//    }
//    
//    static func setAssignmentMobile(value: String) {
//        UserDefaults.standard.set(value, forKey: "ASSIGNMENT_MOBILE")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getAssignmentMobile() -> String {
//        UserDefaults.standard.string(forKey: "ASSIGNMENT_MOBILE") ?? ""
//    }
//    
//    static let teamsAndConditionsText = """
//Welcome to DigClass ("Digiclass student"). By using the App's facial recognition feature for attendance purposes, you agree to the following terms:
//
//Data Usage and Storage: The App does not store or retain facial images captured during the attendance verification process, if applicable. Your privacy and data security are of the utmost importance to us.
//
//Verification Purpose: The facial recognition process within the App is solely intended for verifying the User's identity during attendance tracking, if applicable. No images are stored, ensuring a privacy-conscious experience.
//
//Facial Recognition Use Policy: Users must ensure a clear, unobstructed view of their face (no masks/accessories). Avoid electronic devices or other face images within the camera frame. Any attempt at spoofing (using photos, screens, etc.) will be considered a violation, leading to possible account suspension  Compliance is mandatory for service use.
//
//Fraudulent Activities: In the event that a User attempts to employ manipulated or fraudulent images to deceive the facial recognition system, if applicable, such instances will be meticulously recorded within the App's internal systems.
//
//Investigation: Recorded instances of suspected fraudulent activities, if applicable will be used exclusively for investigation purposes. This measure maintains the integrity of the attendance system and protects the rights of genuine Users.
//
//By continuing to use the facial recognition feature in the App, the User acknowledges and consents to the terms outlined above, if applicable. If the User disagrees with any part of this consent statement, it is advised to refrain from using the facial recognition feature and to contact our support team for further assistance.
//
//This consent statement is a part of the App's terms and conditions and may be subject to updates or modifications, if applicable. Users are encouraged to review the terms regularly to stay informed of any changes.
//
//Thank you for choosing DigiClass Student. Your cooperation in upholding the security and accuracy of the attendance system is highly appreciated.
//
//By clicking the checkbox or by continuing to use the facial recognition feature, you acknowledge that you have read, understood, and agreed to the terms stated above.
//"""
//    
//    static func setLoginUsername(value: String) {
//        UserDefaults.standard.set(value, forKey: "LoginUsername")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getLoginUsername() -> String {
//        UserDefaults.standard.string(forKey: "LoginUsername") ?? ""
//    }
//    
//    static func setLoginPassword(value: String) {
//        UserDefaults.standard.set(value, forKey: "LoginPassword")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getLoginPassword() -> String {
//        UserDefaults.standard.string(forKey: "LoginPassword") ?? ""
//    }
//    
//    static func setRememberMe(value: Bool) {
//        UserDefaults.standard.set(value, forKey: "RememberMe")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getRememberMe() -> Bool {
//        UserDefaults.standard.bool(forKey: "RememberMe")
//    }
//    
//    static func setTermsAndCondition(value: Bool) {
//        UserDefaults.standard.set(value, forKey: "TermsAndCondition")
//        UserDefaults.standard.synchronize()
//    }
//    
//    static func getTermsAndCondition() -> Bool {
//        UserDefaults.standard.bool(forKey: "TermsAndCondition")
//    }
//}
//
//extension UserDefaults{
//
//
//   func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
//       guard let data = self.value(forKey: key) as? Data else { return nil }
//       return try? decoder.decode(type.self, from: data)
//   }
//   
//   func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
//       let data = try? encoder.encode(object)
//       self.set(data, forKey: key)
//   }
// 
//    func save<T:Encodable>(customObject object: T, inKey key: String) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(object) {
//            self.set(encoded, forKey: key)
//        }
//    }
//
//    func retrieve<T:Decodable>(object type:T.Type, fromKey key: String) -> T? {
//        if let data = self.data(forKey: key) {
//            let decoder = JSONDecoder()
//            if let object = try? decoder.decode(type, from: data) {
//                return object
//            }else {
//                return nil
//            }
//        }else {
//            return nil
//        }
//    }
//}
//
//
