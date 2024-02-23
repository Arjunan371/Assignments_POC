////
////  LoginModel.swift
////  DigiStudennt
////
////  Created by Macbook on 20/10/20.
////  Copyright © 2020 Ragul kts. All rights reserved.
////
//
//import Foundation
//// MARK: - SigninModel
//struct SigninModel: Codable {
//    let statusCode: Int?
//    let status: Bool?
//    let message: String?
//    let data: DataLogin?
//
//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case status, message, data
//    }
//    // MARK: - DataLogin
//    struct DataLogin: Codable {
//        let id: String?
//        let name: StaffName?
//        let email: BasicType?
//        let userType: String?
//        let mobile: BasicType?
//        let biometricData: String?
//        let userId:String?
//        let designation:String?
//        let subject:String?
//        let tokens: Tokens?
//        let socketEventId: SocketEventID?
//        let gender: String?
//        let enrolledTerm: String?
//        let enrolledDate: BasicType?
//        let enrolledProgram: enrolledProgram?
//        let institutionCalendar: String?
//        let ioToken: String?
//        let services: Services?
//        enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case email
//            case mobile
//            case name, designation, subject
//            case userType = "user_type"
//            case biometricData = "biometric_data"
//            case userId = "user_id"
//            case tokens
//            case socketEventId, gender
//            case enrolledProgram, enrolledTerm, enrolledDate
//            case institutionCalendar, ioToken, services
//        }
//    }
//
//    struct enrolledProgram: Codable {
//        let id: String?
//        let name: String?
//        let code: String?
//        let programNo: String?
//        
//        enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case name
//            case code
//            case programNo = "program_no"
//            
//        }
//    }
//    // MARK: - SocketEventID
//    struct SocketEventID: Codable {
//        
//        let dashboardEventID, activityEventID, chatEventID, sessionEventId: String?
//        let courseEventId: String?
//        
//        enum CodingKeys: String, CodingKey {
//            case dashboardEventID = "dashboardEventId"
//            case activityEventID = "activityEventId"
//            case chatEventID = "chatEventId"
//            case sessionEventId, courseEventId
//        }
//    }
//    
//    struct Services: Codable {
//        let faceAuthType: String?
//        let labelChange: String?
//        let genderMerge: String?
//        let chatEnabled: String?
//        let faceVerifyMode: String?
//        let activityEnabled: String?
//        let announcementEnabledV1: String?
//        let announcementEnabledV2: String?
//        let serviceAuthKey: String?
//        let multiCalendar: String?
//        let bleRange: String?
//        let timeStamp: String?
//        let lmsVersion: String?
//        let faceAnomaly: String?
//        let faceVerify: String?
//        let localFaceTest: String?
//        let assignmentMobile: String?
//        let anomalyRestrict: String?
//        
//        enum CodingKeys: String, CodingKey {
//            case faceAuthType = "FACE_AUTH_TYPE"
//            case labelChange = "LABEL_CHANGE"
//            case genderMerge = "GENDER_MERGE"
//            case chatEnabled = "CHAT_ENABLED"
//            case faceVerifyMode = "FACE_VERIFY_MODE"
//            case activityEnabled = "ACTIVITY_ENABLED"
//            case announcementEnabledV1 = "ANNOUNCEMENT"
//            case announcementEnabledV2 = "ANNOUNCEMENT_V2"
//            case serviceAuthKey = "SERVICE_AUTH"
//            case multiCalendar = "MULTI_CALENDAR"
//            case bleRange = "BLE_RANGE"
//            case timeStamp = "TIME_STAMP"
//            case lmsVersion = "LMS_VERSION"
//            case faceAnomaly = "FACE_ANOMALY"
//            case faceVerify = "FACE_VERIFY"
//            case localFaceTest = "LOCAL_FACE_TEST"
//            case assignmentMobile = "ASSIGNMENT_MOBILE"
//            case anomalyRestrict = "ANOMALY_RESTRICT"
//        }
//    }
//}
//
//
//enum BasicType: Codable {
//    case integer(Int)
//    case string(String)
//    case double(Double)
//    case long(Int64)
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode(Int.self) {
//            self = .integer(x)
//            return
//        }
//        if let x = try? container.decode(String.self) {
//            self = .string(x)
//            return
//        }
//        if let x = try? container.decode(Double.self) {
//            self = .double(x)
//            return
//        }
//        if let x = try? container.decode(Int64.self) {
//            self = .long(x)
//            return
//        }
//        throw DecodingError.typeMismatch(BasicType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Rating"))
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        switch self {
//        case .integer(let x):
//            try container.encode(x)
//        case .string(let x):
//            try container.encode(x)
//        case .double(let x):
//            try container.encode(x)
//        case .long(let x):
//            try container.encode(x)
//        }
//    }
//}
//
//
//struct ProgramListModel: Codable {
//    let statusCode: Int?
//    let status: Bool?
//    let message: String?
//    let data: ProgramList?
//    
//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case status, message, data
//    }
//    
//    struct ProgramList: Codable {
//        let programDatas: [programDatas]?
//        let labels: [labels]?
//        
//        enum CodingKeys: String, CodingKey {
//            case programDatas
//            case labels
//        }
//    }
//    
//    struct programDatas: Codable {
//        let id: String?
//        let name: String?
//        let collegeProgramType: String?
//        
//        enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case name
//            case collegeProgramType = "college_program_type"
//        }
//    }
//    
//    struct labels: Codable {
//        let id: String?
//        let collegeProgramType: String?
//        let theory: String?
//        let practical: String?
//        let clinical: String?
//        let onsite: String?
//        let plo: String?
//        let clo: String?
//        let slo: String?
//        let level: String?
//        let term: String?
//        let selective: String?
//        let c: String?
//        let p: String?
//        let t: String?
//        let standard: String?
//        
//        enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case collegeProgramType = "college_program_type"
//            case theory
//            case practical
//            case clinical
//            case onsite
//            case plo
//            case clo
//            case slo
//            case level
//            case term
//            case selective
//            case c
//            case p
//            case t
//            case standard
//        }
//    }
//}
//
//// MARK: - BleRangeModel
//struct BleRangeModel: Codable {
//    let statusCode: Int?
//    let status: Bool?
//    let message: String?
//    let data: DataClass?
//
//    enum CodingKeys: String, CodingKey {
//        case statusCode = "status_code"
//        case status, message, data
//    }
//    // MARK: - DataClass
//    struct DataClass: Codable {
//        let id, bleStaff, bleStudent: String?
//
//        enum CodingKeys: String, CodingKey {
//            case id = "_id"
//            case bleStaff, bleStudent
//        }
//    }
//
//}
//
//struct TokenModel : Codable {
//    let message : String?
//    let data : TokenData?
//    enum CodingKeys: String, CodingKey {
//        case message = "message"
//        case data = "data"
//    }
//}
//struct Access : Codable {
//    let token : String?
//    let expires : String?
//}
//
//struct Apps : Codable {
//    let app : String?
//    let userId : String?
//}
//
//struct TokenData : Codable {
//    let tokens : Tokens?
//    let user : User?
//}
//struct Email : Codable {
//    let isVerified : Bool?
//    let verifiedVia : String?
//    let verifiedAt : String?
//}
//struct FaceM : Codable {
//    let isVerified : Bool?
//    let verifiedVia : String?
//    let verifiedAt : String?
//}
//
//struct Finger : Codable {
//    let isVerified : Bool?
//    let verifiedVia : String?
//    let verifiedAt : String?
//}
//
//struct Mobile : Codable {
//    let isVerified : Bool?
//    let verifiedVia : String?
//    let verifiedBy : String?
//    let verifiedAt : String?
//}
//
//struct Name : Codable {
//    let first : String?
//    let middle : String?
//    let last : String?
//}
//
//struct Otp : Codable {
//    let text : String?
//    let expiresAt : String?
//}
///*
//struct Refresh : Codable {
//    let token : String?
//    let expires : String?
//}
//*/
//struct Tokens : Codable {
//    let access : Access?
//    let refresh : Access?
//}
//struct User : Codable {
//    let role : String?
//    let signUpVerify : Bool?
//    let name : Name?
//    let verification : Verification?
//    let otp : Otp?
//    let gender : String?
//    let facial : [String]?
//    let isActive : Bool?
//    let isRemoved : Bool?
//    let _id : String?
//    let apps : [Apps]?
//    let email : String?
//    let password : String?
//    let employeeOrAcademicId : String?
//    let createdAt : String?
//    let __v : Int?
//    let roles : [String]?
//    let updatedAt : String?
//    let mobile : Int?
//    let id : String?
//}
//struct Verification : Codable {
//    let email : Email?
//    let mobile : Mobile?
//    let face : FaceM?
//    let finger : Finger?
//}
//
//// MARK: - DashModel
//struct CollegeListModel: Codable {
//    let statusCode: Int?
//    let status: Bool?
//    let message: String?
//    let data: DataClass?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case statusCode = "status_code"
//        case status, message, data
//    }
//    
//    struct College: Codable {
//        let id = UUID().uuidString
//        let collegeName,collegeCode, type: String?
//        let socketUrl, baseUrl, faceUrl, webUrl, blinkUrl, chatApiKey, country, collegeImage: String?
//        let smsService: Bool?
//        let biometricLogin: Bool?
//        var isSelected = false
//        enum CodingKeys: String, CodingKey {
//            case collegeName, type, socketUrl, baseUrl, faceUrl, webUrl, blinkUrl, chatApiKey, country, collegeImage, collegeCode
//            case smsService, biometricLogin
//        }
//    }
//    
//    struct DataClass: Codable {
//        let collegeList: [College]?
//    }
//    
//}
//
//extension CollegeListModel {
//    static func loadMockData()-> CollegeListModel?{
//        let decoder = JSONDecoder()
//        let jsonString = """
//{
//    "status_code": 200,
//    "status": true,
//    "message": "Data retrieved",
//    "data": {
//        "collegeList": [
//            {
//                "collegeName": "Ibn Sina National college",
//                "type": "staging",
//                "socketUrl": "https://ecs-dscron-staging.digi-val.com/",
//                "baseUrl": "https://ecs-dsapi-staging.digi-val.com/api/",
//                "faceUrl": "https://ecs-auth-staging.digi-val.com/api/",
//                "webUrl": "https://ecs-dcweb-staging.digi-val.com/",
//                "blinkUrl": "https://ecs-dcweb-staging.digi-val.com/",
//                "chatApiKey": "r98xryxj6t7s",
//                "country": "Saudi Arabia",
//                "collegeImage": "https://www.gstatic.com/webp/gallery/1.jpg"
//            },
//            {
//                "collegeName": "Ibn Sina National college",
//                "type": "production",
//                "socketUrl": "https://dscron.digischeduler.digivalsolutions.com/",
//                "baseUrl": "https://ds.api.digivalsolutions.com/api/",
//                "faceUrl": "https://ecs.auth.digivalsolutions.com/api/",
//                "webUrl": "https://digiclass.digivalsolutions.com/",
//                "blinkUrl": "https://ecs-dcweb-staging.digi-val.com/",
//                "chatApiKey": "yr4w5ncvvpvn",
//                 "country": "Saudi Arabia",
//                "collegeImage": "https://www.gstatic.com/webp/gallery/2.webp"
//            },
//            {
//                "collegeName": "Al-Rayan Colleges",
//                "type": "production",
//                "socketUrl": "https://dscron-api.amc.digi-val.com/",
//                "baseUrl": "https://ds-api.amc.digi-val.com/api/",
//                "faceUrl": "https://auth.amc.digi-val.com/api/",
//                "webUrl": "hhttps://digiclass.amc.digi-val.com/",
//                "blinkUrl": "https://ecs-dcweb-staging.digi-val.com/",
//                "chatApiKey": "r98xryxj6t7s",
//                 "country": "Saudi Arabia",
//                "collegeImage": "https://www.gstatic.com/webp/gallery/4.jpg"
//            },
//            {
//                "collegeName": "Sri Shanmugha College of Pharmacy, Sankari, Salem",
//                "type": "production",
//                "socketUrl": "https://dscron-api.shanmugha.digi-val.com/",
//                "baseUrl": "https://ds-api.shanmugha.digi-val.com/api/",
//                "faceUrl": "https://auth.shanmugha.digi-val.com/api/",
//                "webUrl": "https://digiclass.shanmugha.digi-val.com/",
//                "blinkUrl": "https://ecs-dcweb-staging.digi-val.com/",
//                "chatApiKey": "r98xryxj6t7s",
//                 "country": "India",
//                "collegeImage": "https://www.gstatic.com/webp/gallery/1.jpg"
//            },
//            {
//                "collegeName": "Sri Shanmugha College of Pharmacy, Sankari, Salem",
//                "type": "staging",
//                "socketUrl": "https://ecs-dscronv1-staging.digi-val.com/",
//                "baseUrl": "https://ecs-dsapiv1-staging.digi-val.com/api/",
//                "faceUrl": "https://ecs-auth-staging.digi-val.com/api/",
//                "webUrl": "https://ecs-dcwebv1-staging.digi-val.com/",
//                "blinkUrl": "https://ecs-dcweb-staging.digi-val.com/",
//                "chatApiKey": "r98xryxj6t7s",
//                 "country": "Saudi Arabia",
//                "collegeImage": "https://www.gstatic.com/webp/gallery/4.jpg"
//            }
//        ]
//    }
//}
//"""
//        let jsonData = Data(jsonString.utf8)
//        do {
//            let response = try decoder.decode(CollegeListModel.self, from: jsonData)
//            print(response)
//            return response
//        } catch DecodingError.keyNotFound(let key, let context) {
//            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
//        } catch DecodingError.typeMismatch(let type, let context) {
//            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
//        } catch DecodingError.dataCorrupted(let context) {
//            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
//        } catch let error as NSError {
//            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
//        }
//        return nil
//    }
//    
//}
//
