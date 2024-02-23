//
//  FacultyUserDefaults.swift
//  Staff_Attendance
//
//  Created by Fazil on 24/06/22.
//  Copyright © 2022 adminstrator. All rights reserved.
//

import Foundation

struct FacultyUserDefaults {
    static func getChatToken()->String {
        guard let token = UserDefaults.standard.string(forKey: "ChatToken") else {return ""}
        return token
    }
    
    static func setChatToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "ChatToken")
        UserDefaults.standard.synchronize()
    }
    
    static func setPushUserInfo(_ info: [AnyHashable:Any]) {
        
        UserDefaults.standard.set(info, forKey: "push_info")
        UserDefaults.standard.synchronize()
        
    }
    
    static func getPushUserInfo() -> [AnyHashable:Any] {
        
        guard let dict = UserDefaults.standard.dictionary(forKey: "push_info") else {
            return [:]
        }
        return dict
    }
    
    static func setSessionInfo(_ info: [[String:Any]]) {
        
        UserDefaults.standard.set(info, forKey: "SessionInfoKey")
        UserDefaults.standard.synchronize()
    }
    
    static func getSessionInfo() -> [[String:Any]] {
        guard let arr = UserDefaults.standard.array(forKey: "SessionInfoKey") as? [[String: Any]] else {
            return []
        }
        return arr
    }
    
    static func setFcmToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "fcmtoken")
        UserDefaults.standard.synchronize()
    }
    
    static func getFcmToken() -> String {
        guard let token = UserDefaults.standard.string(forKey: "fcmtoken") else {
            return ""
        }
        UserDefaults.standard.synchronize()
        return token
    }
    
    static func setSessionStartStatus(strStatus:Bool){
        UserDefaults.standard.set(strStatus, forKey: "SessionStatus")
        UserDefaults.standard.synchronize()
    }
    
    static func getSessionStartStatus()-> Bool? {
        return UserDefaults.standard.bool(forKey: "SessionStatus")
    }
    
    static func setAttendanceStatus(strStatus:Bool){
        UserDefaults.standard.set(strStatus, forKey: "AttendanceStatus")
        UserDefaults.standard.synchronize()
    }
    
    static func getAttendanceStatus()-> Bool? {
        return UserDefaults.standard.bool(forKey: "AttendanceStatus")
    }
//
//    static func setSessionDetails(sessionDets:SessionDatum?){
//        UserDefaults.standard.save(customObject: sessionDets, inKey: "Session_Details")
//        UserDefaults.standard.synchronize()
//    }
//
//    static func getSessionDetails()-> SessionDatum? {
//        return UserDefaults.standard.object(SessionDatum.self, with: "Session_Details")
//    }
    
    static func setUserGender(_ userid: String) {
        UserDefaults.standard.set(userid, forKey: "user_gender")
        UserDefaults.standard.synchronize()
    }
    
    static func getUserGender() -> String {
        
        guard let userid = UserDefaults.standard.string(forKey: "user_gender") else {
            return ""
        }
        UserDefaults.standard.synchronize()
        return userid
    }
    
    static func getUserAccessId() -> String {
        guard let userid = UserDefaults.standard.string(forKey: "access_id") else {return ""}
        return userid
    }
    static func setUserAccessId(_ userid: String) {
        UserDefaults.standard.set(userid, forKey: "access_id")
        UserDefaults.standard.synchronize()
    }
    
    static func getAccessToken()->String {
        guard let tokenAccess = UserDefaults.standard.string(forKey: "AccessToken") else {return ""}
        return tokenAccess
    }
    
    static func setAccessToken(_ tokenAccess: String) {
        UserDefaults.standard.set(tokenAccess, forKey: "AccessToken")
        UserDefaults.standard.synchronize()
    }
    
    static func getRefreshToken()->String {
        guard let tokenAccess = UserDefaults.standard.string(forKey: "RefreshToken") else {return ""}
        return tokenAccess
    }
    
    static func setRefreshToken(_ tokenRefresh: String) {
        UserDefaults.standard.set(tokenRefresh, forKey: "RefreshToken")
        UserDefaults.standard.synchronize()
    }
    
    static func isUserLoggedIn() -> Bool {
        guard let userid = UserDefaults.standard.string(forKey: "userid") else {
            return false
        }
        UserDefaults.standard.synchronize()
        return !userid.isEmpty
    }
    
    static func setUserId(_ userid: String) {
        UserDefaults.standard.set(userid, forKey: "userid")
        UserDefaults.standard.synchronize()
    }
    
    static func getUserId() -> String {
        guard let userid = UserDefaults.standard.string(forKey: "userid") else { return ""}
        return userid
    }
    
    static func setRoleId(_ roleid: String) {
        UserDefaults.standard.set(roleid, forKey: "roleid")
        UserDefaults.standard.synchronize()
    }
    
    static func getRoleId() -> String {
        guard let roleid = UserDefaults.standard.string(forKey: "roleid") else { return ""}
        return roleid
    }
    
    static func setStaffName(_ userid: String) {
        UserDefaults.standard.set(userid, forKey: "StaffName")
        UserDefaults.standard.synchronize()
    }
    static func getStaffName() -> String {
        guard let userid = UserDefaults.standard.string(forKey: "StaffName") else { return ""}
        return userid
    }
    
    static func setProfileLink(strUrl:String){
        UserDefaults.standard.set(strUrl, forKey: "UserProfileUrl")
        UserDefaults.standard.synchronize()
    }
    
    static func getProfileLink()->String{
        guard let profileLink = UserDefaults.standard.string(forKey: "UserProfileUrl") else { return ""}
        return profileLink
    }
    
    static func setStartById(strId:String){
        UserDefaults.standard.set(strId, forKey: "StartById")
        UserDefaults.standard.synchronize()
    }
    
    static func getStartById()->String{
        guard let profileLink = UserDefaults.standard.string(forKey: "StartById") else { return ""}
        return profileLink
    }
    
    static func setUserEmailId(strId:String){
        UserDefaults.standard.set(strId, forKey: "EmailID")
        UserDefaults.standard.synchronize()
    }
    
    static func getUserEmailId()->String{
        guard let userID = UserDefaults.standard.string(forKey: "EmailID") else { return ""}
        return userID
    }
    
    static func setIsCourseAdmin(_ value:Bool){
        UserDefaults.standard.set(value, forKey: "IsCourseAdmin")
        UserDefaults.standard.synchronize()
    }
    
    static var isCourseAdmin: Bool {
        return UserDefaults.standard.bool(forKey: "IsCourseAdmin")
    }
    
    static func setIsCourseAdminMode(_ value:Bool){
        UserDefaults.standard.set(value, forKey: "IsCourseAdminMode")
        UserDefaults.standard.synchronize()
    }
    
    static var isCourseAdminMode: Bool {
        return UserDefaults.standard.bool(forKey: "IsCourseAdminMode")
    }
    
    static func getCurrentLang() -> String {
        guard let lang = UserDefaults.standard.string(forKey: "currentLang"), !lang.isEmpty else {
            return "English"
        }
        UserDefaults.standard.synchronize()
        return lang
    }
    
    static func setCurrentLang(_ lang: String) {
        UserDefaults.standard.set(lang, forKey: "currentLang")
        UserDefaults.standard.synchronize()
    }
    
    static func getLangCode() -> String {
        switch getCurrentLang() {
        case "English":
            return "en"
        case "العربية":
            return "ar"
        default:
            return "en"
        }
    }
    
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
    
    static func setScheduleOtp(info: [String: String]) {
        UserDefaults.standard.set(info, forKey: "scheduleOtp")
        UserDefaults.standard.synchronize()
    }
    
    static func getScheduleOtp(scheduleId: String) -> String {
        let info = UserDefaults.standard.object(forKey: "scheduleOtp") as? [String: String] ?? [:]
        let oldScheduleId = info["scheduleId"]
        let otp = info["otp"] ?? ""
        return scheduleId == oldScheduleId ? otp : ""
    }
    
//    static func setAcademicYears(_ academicYears: [CoursesAcademicYearModel.AcademicData]) {
//        UserDefaults.standard.save(customObject: academicYears, inKey: "AcademicYears")
//        UserDefaults.standard.synchronize()
//    }
//
//    static func getAcademicYears() -> [CoursesAcademicYearModel.AcademicData] {
//        UserDefaults.standard.retrieve(object: [CoursesAcademicYearModel.AcademicData].self, fromKey: "AcademicYears") ?? []
//    }
}

//MARK: Api Userdefaults
extension FacultyUserDefaults {
    static func setBaseUrl(_ baseUrl: String) {
        UserDefaults.standard.set(baseUrl, forKey: "BaseUrl")
        UserDefaults.standard.synchronize()
    }
    
    static func getBaseUrl() -> String? {
        UserDefaults.standard.string(forKey: "BaseUrl")
    }
    
    static func setSocketUrl(_ socketUrl: String) {
        UserDefaults.standard.set(socketUrl, forKey: "SocketUrl")
        UserDefaults.standard.synchronize()
    }
    
    static func getSocketUrl() -> String? {
        UserDefaults.standard.string(forKey: "SocketUrl")
    }
    
    static func setFacialUrl(_ facialUrl: String) {
        UserDefaults.standard.set(facialUrl, forKey: "FacialUrl")
        UserDefaults.standard.synchronize()
    }
    
    static func getFacialUrl() -> String? {
        UserDefaults.standard.string(forKey: "FacialUrl")
    }
    
    static func setChatApiKey(_ chatApiKey: String) {
        UserDefaults.standard.set(chatApiKey, forKey: "ChatApiKey")
        UserDefaults.standard.synchronize()
    }
    
    static func getChatApiKey() -> String? {
        UserDefaults.standard.string(forKey: "ChatApiKey")
    }
}


//MARK: Feature Flags
extension FacultyUserDefaults {
    static func setChatEnabled(value:String) {
        UserDefaults.standard.set(value, forKey: "isChatEnabled")
        UserDefaults.standard.synchronize()
    }
    
    static func isChatEnabled() -> Bool {
        let value = UserDefaults.standard.string(forKey:"isChatEnabled") ?? "true"
        return value == "true"
    }
    
    static func setLabelChanges(value: String) {
        UserDefaults.standard.set(value, forKey: "isLabelChangesEnabled")
        UserDefaults.standard.synchronize()
    }
    
    static func isLabelChangesEnabled() -> Bool {
        let value = UserDefaults.standard.string(forKey: "isLabelChangesEnabled") ?? "false"
        return value == "true"
    }
    
    static func setFaceAuthType(type: String) {
        UserDefaults.standard.set(type, forKey: "faceAuthType")
        UserDefaults.standard.synchronize()
    }
    
    static func faceAuthType() -> String {
        UserDefaults.standard.string(forKey: "faceAuthType") ?? "mobile"
    }
    
    static func getRetakeSessionId()->String {
        guard let token = UserDefaults.standard.string(forKey: "RetakeSessionId") else {return ""}
        return token
    }
    
    static func setRetakeSessionId(_ id: String) {
        UserDefaults.standard.set(id, forKey: "RetakeSessionId")
        UserDefaults.standard.synchronize()
    }
    
    static func setFaceVerifyMode(type: String) {
        UserDefaults.standard.set(type, forKey: "FACE_VERIFY_MODE")
        UserDefaults.standard.synchronize()
    }
    
    static func getFaceVerifyMode() -> String {
        UserDefaults.standard.string(forKey: "FACE_VERIFY_MODE") ?? "online"
    }
    
    static func setActivityEnabled(type: String) {
        UserDefaults.standard.set(type, forKey: "ACTIVITY_ENABLED")
        UserDefaults.standard.synchronize()
    }
    
    static func isActivityEnabled() -> String {
        UserDefaults.standard.string(forKey: "ACTIVITY_ENABLED") ?? "true"
    }
    
    static func setAnnouncementEnabled(type: String) {
        UserDefaults.standard.set(type, forKey: "ANNOUNCEMENT")
        UserDefaults.standard.synchronize()
    }
    
    static func isAnnouncementEnabled() -> String {
        UserDefaults.standard.string(forKey: "ANNOUNCEMENT") ?? "false"
    }
    
    static func setSurveyOpenEnded(type: String) {
        UserDefaults.standard.set(type, forKey: "SURVEY_OPEN_ENDED")
        UserDefaults.standard.synchronize()
    }
    
    static func isSurveyOpenEnded() -> String {
        UserDefaults.standard.string(forKey: "SURVEY_OPEN_ENDED") ?? "false"

    }
    static func setServiceAuthKey(type: String) {
        UserDefaults.standard.set(type, forKey: "SERVICE_AUTH")
        UserDefaults.standard.synchronize()
    }
    
    static func getServiceAuthKey() -> String {
        UserDefaults.standard.string(forKey: "SERVICE_AUTH") ?? ""
    }
    
    static func setTimeStampKey(type: String) {
        UserDefaults.standard.set(type, forKey: "TIME_STAMP")
        UserDefaults.standard.synchronize()
    }
    
    static func getTimeStampKey() -> String {
        UserDefaults.standard.string(forKey: "TIME_STAMP") ?? "false"
    }
    
    static func setFaceAuthenticationKey(type: String) {
        UserDefaults.standard.set(type, forKey: "FACE_AUTHONTICATION")
        UserDefaults.standard.synchronize()
    }
    
    static func getFaceAuthenticationKey() -> String {
        UserDefaults.standard.string(forKey: "FACE_AUTHONTICATION") ?? "false"
    }
    
    static func setLocalFaceTest(value: String) {
        UserDefaults.standard.set(value, forKey: "LOCAL_FACE_TEST")
        UserDefaults.standard.synchronize()
    }
    
    static func getLocalFaceTest() -> String {
        UserDefaults.standard.string(forKey: "LOCAL_FACE_TEST") ?? ""
    }
    
    static func setStudentManualAttendance(value: String) {
        UserDefaults.standard.set(value, forKey: "STAFF_STUDENT_MANUAL_ATTENDANCE")
        UserDefaults.standard.synchronize()
    }
    
    static func getStudentManualAttendance() -> String {
        UserDefaults.standard.string(forKey: "STAFF_STUDENT_MANUAL_ATTENDANCE") ?? ""
    }
    
    static func setActiveInstitutionCalendarIds(type: [String]) {
        UserDefaults.standard.set(type, forKey: "activeInstitutionCalendarIds")
        UserDefaults.standard.synchronize()
    }
    
    static func getActiveInstitutionCalendarIds() -> [String] {
        (UserDefaults.standard.array(forKey: "activeInstitutionCalendarIds") as? [String]) ?? []
    }
    
//    static func isActiveInstitutionCalendar(InstitutionId: String) -> Bool {
//        if getActiveInstitutionCalendarIds().isEmpty {
//            return ServiceSettings.shared.getInstitutionCalendarId() == InstitutionId
//        } else {
//            return getActiveInstitutionCalendarIds().contains(where: { $0 == InstitutionId })
//        }
//    }
    
    static func setManualAttendance(value: String) {
        UserDefaults.standard.set(value, forKey: "MANUAL_ATTENDANCE")
        UserDefaults.standard.synchronize()
    }
    
    static func getManualAttendance() -> String {
        UserDefaults.standard.string(forKey: "MANUAL_ATTENDANCE") ?? "false"
    }
    
    static func setManualAttendanceType(value: String) {
        UserDefaults.standard.set(value, forKey: "MANUAL_ATTENDANCE_TYPE")
        UserDefaults.standard.synchronize()
    }
    
    static func getManualAttendanceType() -> String {
        UserDefaults.standard.string(forKey: "MANUAL_ATTENDANCE_TYPE") ?? "false"
    }
    
//    static func setManualAttendanceStaff(value: Bool) {
//        UserDefaults.standard.set(value, forKey: "isManualAttendanceStaff")
//        UserDefaults.standard.synchronize()
//    }
//
//    static func isManualAttendanceStaff() -> Bool {
//        let value = UserDefaults.standard.bool(forKey: "isManualAttendanceStaff")
//        return value
//    }
    
    static let teamsAndConditionsText = """
Welcome to DigiClass ("DigiClass Faculty"). By using the App's facial recognition feature for attendance purposes, you agree to the following terms:

Data Usage and Storage: The App does not store or retain facial images captured during the attendance verification process, if applicable. Your privacy and data security are of the utmost importance to us.

Verification Purpose: The facial recognition process within the App is solely intended for verifying the User's identity during attendance tracking, if applicable. No images are stored, ensuring a privacy-conscious experience.

By continuing to use the facial recognition feature in the App, the User acknowledges and consents to the terms outlined above, if applicable. If the User disagrees with any part of this consent statement, it is advised to refrain from using the facial recognition feature and to contact our support team for further assistance.

This consent statement is a part of the App's terms and conditions and may be subject to updates or modifications, if applicable. Users are encouraged to review the terms regularly to stay informed of any changes.

Thank you for choosing DigiClass Faculty. Your cooperation in upholding the security and accuracy of the attendance system is highly appreciated.

By clicking the checkbox or by continuing to use the facial recognition feature, you acknowledge that you have read, understood, and agreed to the terms stated above.
"""
   
    static func setLoginUsername(value: String) {
        UserDefaults.standard.set(value, forKey: "LoginUsername")
        UserDefaults.standard.synchronize()
    }
    
    static func getLoginUsername() -> String {
        UserDefaults.standard.string(forKey: "LoginUsername") ?? ""
    }
    
    static func setLoginPassword(value: String) {
        UserDefaults.standard.set(value, forKey: "LoginPassword")
        UserDefaults.standard.synchronize()
    }
    
    static func getLoginPassword() -> String {
        UserDefaults.standard.string(forKey: "LoginPassword") ?? ""
    }
    
    static func setRememberMe(value: Bool) {
        UserDefaults.standard.set(value, forKey: "RememberMe")
        UserDefaults.standard.synchronize()
    }
    
    static func getRememberMe() -> Bool {
        UserDefaults.standard.bool(forKey: "RememberMe")
    }
    
    static func setTermsAndCondition(value: Bool) {
        UserDefaults.standard.set(value, forKey: "TermsAndCondition")
        UserDefaults.standard.synchronize()
    }
    
    static func getTermsAndCondition() -> Bool {
        UserDefaults.standard.bool(forKey: "TermsAndCondition")
    }
}
