//
//import Foundation
//import UIKit
//
//class ServiceSettings {
//   
//    static let shared = ServiceSettings()
//    private init() {}
//    
//    func saveUserInfo(data: SigninModel.DataLogin) {
//        
//        CoreDataManager.sharedManager.deleteAll(entity: "UserInfo")
//        
//        let userInfo: [String : Any] = ["accessToken":data.tokens?.access?.token ?? "","dashboardEventId": data.socketEventId?.dashboardEventID ?? "","email":AppTypeCheck.checkBasicType(type: String.self, givenObj: data.email),"entrolledDate":AppTypeCheck.checkBasicType(type: String.self, givenObj: data.enrolledDate),"entrolledTerm":data.enrolledTerm ?? "","firstName": data.name?.first ?? "","gender":data.gender ?? "","lastName":data.name?.last ?? "","middleName":data.name?.middle ?? "","mobile":AppTypeCheck.checkBasicType(type: String.self, givenObj: data.mobile),"programCode":data.enrolledProgram?.code ?? "","programName": data.enrolledProgram?.name ?? "","refreshToken":data.tokens?.refresh?.token ?? "","sessionEventId":data.socketEventId?.sessionEventId ?? "","userAccessId":data.id ?? "","userId":data.userId ?? "","courseEventId":data.socketEventId?.courseEventId ?? "","biometric_data":data.biometricData ?? "","institutionCalendar":data.institutionCalendar ?? "","activityEventID": data.socketEventId?.activityEventID ?? ""]
//        CoreDataManager.sharedManager.insertNewRecord(record: userInfo, entity: "UserInfo")
//        
//    }
//    func getUserName() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        var userName = ""
//        if let first = records.first?.value(forKey: "firstName") as? String, !first.isEmpty {
//            userName += first
//        }
//        if let middle = records.first?.value(forKey: "middleName") as? String, !middle.isEmpty {
//            userName += " " + middle
//        }
//        if let last = records.first?.value(forKey: "lastName") as? String, !last.isEmpty {
//            userName += " " + last
//        }
//        
//        return userName
//    }
//    func getUserProfileImage() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        return records.first?.value(forKey: "biometric_data") as? String ?? ""
//    }
//    func getUserId() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        return records.first?.value(forKey: "userId") as? String ?? ""
//    }
//    func getInstitutionCalendarId() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        return records.first?.value(forKey: "institutionCalendar") as? String ?? ""
//    }
//    func getProgramName() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        let program = (records.first?.value(forKey: "programCode") as? String ?? "") + " - " + (records.first?.value(forKey: "programName") as? String ?? "")
//        return program
//    }
//    func getEntrolledTerm() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        return records.first?.value(forKey: "entrolledTerm") as? String ?? ""
//    }
//    func getEntrolledDate() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        return records.first?.value(forKey: "entrolledDate") as? String ?? ""
//    }
//    func getuserMobileNo() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        return records.first?.value(forKey: "mobile") as? String ?? ""
//    }
//    func getuserMailId() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        
//        return records.first?.value(forKey: "email") as? String ?? ""
//    }
//    func getDashboardEventId() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        return records.first?.value(forKey: "dashboardEventId") as? String ?? ""
//    }
//    func getSessionEventId() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        return records.first?.value(forKey: "sessionEventId") as? String ?? ""
//    }
//    func getCourseEventId() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        return records.first?.value(forKey: "courseEventId") as? String ?? ""
//    }
//    func getActivityEventID() -> String {
//        guard let records = CoreDataManager.sharedManager.fetchAllRecords(entity: "UserInfo") , !records.isEmpty else {
//            return ""
//        }
//        return records.first?.value(forKey: "activityEventID") as? String ?? ""
//    }
//}
//
//import CoreData
//
//class CoreDataManager {
//  static let sharedManager = CoreDataManager()
//  private init() {}
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "DigiStudennt")
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Unable to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//    
//      func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//          do {
//            try context.save()
//          } catch let error as NSError {
//              log("Could not save. \(error), \(error.userInfo)")
//          }
//        }
//      }
//    
//    func insertNewRecord(record: [String: Any], entity: String) {
//        let managedContext = persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)!
//        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
//        for (key, value) in record {
//            managedObject.setValue(value, forKeyPath: key)
//            managedObject.setValue(value, forKeyPath: key)
//        }
//        saveContext()
//    }
//    
//    func insertAllRecords(records: [[String: Any]], entity: String) {
//        let managedContext = persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: entity, in: managedContext)!
//        for item in records {
//            let managedObject = NSManagedObject(entity: entity,
//            insertInto: managedContext)
//            for (key, value) in item {
//                managedObject.setValue(value, forKeyPath: key)
//                managedObject.setValue(value, forKeyPath: key)
//            }
//            saveContext()
//        }
//    }
//    
//    func fetchAllRecords(entity: String) -> [NSManagedObject]? {
//      let managedContext = persistentContainer.viewContext
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
//      do {
//        let records = try managedContext.fetch(fetchRequest)
//        return records
//        
//      } catch let error as NSError {
//          log("Could not fetch. \(error), \(error.userInfo)")
//        return nil
//      }
//    }
//    
//    func fetchSingleRecords<T: CVarArg>(entity: String, coloum: String, value: T) -> [NSManagedObject]? {
//      let managedContext = persistentContainer.viewContext
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        fetchRequest.predicate = NSPredicate(format: "\(coloum) = \(value)")
//        //coloum
//      do {
//        let records = try managedContext.fetch(fetchRequest)
//        return records
//        
//      } catch let error as NSError {
//          log("Could not fetch. \(error), \(error.userInfo)")
//        return nil
//      }
//    }
//    
//    func fetchSingleRecords(entity: String, coloum: String, value: String) -> [NSManagedObject]? {
//      let managedContext = persistentContainer.viewContext
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        fetchRequest.predicate = NSPredicate(format: "%K = %@", coloum, value)
//      do {
//        let records = try managedContext.fetch(fetchRequest)
//        return records
//        
//      } catch let error as NSError {
//        log("Could not fetch. \(error), \(error.userInfo)")
//        return nil
//      }
//    }
//    
//    
//    func fetchSingleRecord(entity: String, coloum: String, value: Int) -> [NSManagedObject]? {
//      
//      let managedContext = persistentContainer.viewContext
//      
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        let predicate1 = NSPredicate(format: "%K = %d", coloum, value)
//        let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: [predicate1])
//        fetchRequest.predicate = predicateCompound
//        
//      do {
//        let records = try managedContext.fetch(fetchRequest)
//        return records
//        
//      } catch let error as NSError {
//        log("Could not fetch. \(error), \(error.userInfo)")
//        return nil
//      }
//      
//    }
//    
//    func deleteAll(entity: String) {
//      
//      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
//      
//      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
//      //fetchRequest.predicate = NSPredicate(format: "ssn == %@" ,ssn)
//      do {
//        
//        let item = try managedContext.fetch(fetchRequest)
//        for i in item {
//            
//          managedContext.delete(i)
//          try managedContext.save()
//          
//        }
//        
//      } catch let error as NSError {
//          log("Could not fetch. \(error), \(error.userInfo)")
//      }
//      
//    }
//}
//
//struct AppTypeCheck {
//    
//    static func checkIntValue(givenObj: Any) -> Int {
//       
//        if let isInt = givenObj as? Int {
//            return  isInt
//        } else if let isString = givenObj as? String {
//            return  Int(isString) ?? 0
//        } else {
//            return  0
//        }
//
//    }
//    static func checkDoubleValue(givenObj: Any) -> Double {
//       
//        if let isDouble = givenObj as? Double {
//            return  isDouble
//        } else if let isString = givenObj as? String {
//            return  Double(isString) ?? 0
//        } else {
//            return  0
//        }
//
//    }
//    static func checkStringValue(givenObj: Any) -> String {
//       
//        if let isString = givenObj as? String {
//            return  isString
//        } else if  let isInt = givenObj as? Int {
//            return  "\(isInt)"
//        } else if  let isDouble = givenObj as? Double {
//            return  "\(isDouble)"
//        } else {
//            return  ""
//        }
//
//    }
//    
//    static func checkBasicType<T>(type: T.Type, givenObj: BasicType?) -> T {
//       
//        if T.self == Int.self {
//            let quantity: T
//            switch givenObj {
//                case .integer(let x):
//                    quantity = x as! T
//                case .string(let x):
//                    quantity = (Int(x) ?? 0) as! T
//                case .double(let x):
//                    quantity = (Int(x) ) as! T
//                case .long(let x):
//                    quantity = (Int(x) ) as! T
//                case .none:
//                    quantity = 0 as! T
//            }
//            return quantity
//        } else if T.self == Double.self {
//            let quantity: T
//            switch givenObj {
//                case .integer(let x):
//                    quantity = Double(x) as! T
//                case .string(let x):
//                    quantity = (x as NSString).doubleValue as! T
//                case .double(let x):
//                    quantity = x as! T
//                case .long(let x):
//                quantity = Double(x) as! T
//                case .none:
//                    quantity = 0.0 as! T
//            }
//            return quantity
//        } else if T.self == Int64.self {
//            let quantity: T
//            switch givenObj {
//                case .integer(let x):
//                    quantity = Int64(x) as! T
//                case .string(let x):
//                    quantity = (Int64(x) ?? 0) as! T
//                case .double(let x):
//                    quantity = Int64(x) as! T
//                case .long(let x):
//                    quantity = x as! T
//                case .none:
//                    quantity = 0 as! T
//            }
//            return quantity
//        }  else {
//            let quantity: T
//            switch givenObj {
//                case .integer(let x):
//                    quantity = String(x) as! T
//                case .string(let x):
//                    quantity = x as! T
//                case .double(let x):
//                    quantity = String(x) as! T
//                case .long(let x):
//                    quantity = String(x) as! T
//                case .none:
//                    quantity = String() as! T
//            }
//            return quantity
//        }
//
//    }
//    
//    static func getScheduleModel(model: EventItemModel, studentStatus: StudentDetails?) -> ScheduleModel {
//        let schedule = ScheduleModel(title: model.title, id: model.id, programID: model.programID, yearNo: model.yearNo, courseID: model.courseID, courseName: model.courseName, session: model.session, studentGroups: nil, scheduleDate: nil, start: nil, end: nil, mode: model.mode, subjects: model.subjects, staffs: model.staffs, students: model.students, infraName: nil, status: model.status, uuid: model.uuid, sessionDetail: model.sessionDetail, programName: model.programName, levelNo: model.levelNo, mergeStatus: model.mergeStatus, type: model.type, institutionCalendarId: model.institutionCalendarId, startDate: model.startDate, endDate: model.endDate, eventName: model.eventName, eventType: model.eventType, topic: model.topic, mergeWith: model.mergeWith, gender: model.gender, subType: model.subType, isActive: model.isActive, rotation: model.rotation, courseType: model.courseType, rotationCount: model.rotationCount, documentCount: nil, activityCount: nil, studentDetails: studentStatus,term: model.term, zoomDetail:nil, teamsDetail: nil, socketPort: model.socketPort, isLive: model.isLive, attendanceTakingStaff: nil, faceAuthentication: model.faceAuthentication)
//        return schedule
//    }
//    
//    
//}
