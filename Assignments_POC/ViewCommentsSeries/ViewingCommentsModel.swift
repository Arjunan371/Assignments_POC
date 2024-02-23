
import Foundation

//struct AssignmentsModel {
//    var id = UUID().uuidString
//    var buttonTitle: String?
//    var title: String?
//    var subTitle: String?
//    var count: Int?
//    var academicYear: String?
//    var course: String?
//    var isSelect: Bool = false
//    var isSelectCollectionCell: Bool = false
//    var bricksHeight: [Double] = [Double](repeating: 0, count: 30).map({ _ in Double.random(in: 7...20)})
//    var videoUrl: String?
//    var imageUrl: String?
//    var audioUrl: String?
//    var documentUrl: String?
//    var message: String?
//}

import Foundation

// MARK: - Welcome
struct CreateCommentsModel: Codable {
    let message: String?
    let data: AssignmentsDataComment?
}

// MARK: - Welcome
struct ViewingCommentsModel: Codable {
    let message: String?
    let data: AssignmentsData?
}

// MARK: - DataClass
struct AssignmentsData: Codable {
    let id: String?
    let comments: [AssignmentsDataComment]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case comments
    }
}

// MARK: - Comment
struct AssignmentsDataComment: Codable {
    let id, staffID, studentID, time: String?
    var message, staffName, studentName: String?
    var attachments: [Attachment]?
    var isSelect: Bool = false
    var isSelectCollectionCell: Bool = false
    var bricksHeight: [Double] = [Double](repeating: 0, count: 30).map({ _ in Double.random(in: 7...20)})
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case staffID = "staffId"
        case studentID = "studentId"
        case time, message, staffName, studentName, attachments
    }
}
//MARK: - SubmitResponse
struct SubmitResponse: Codable {
    let message: String?
    let data: SubmitDataClass?
}

// MARK: - SubmitDataClass
struct SubmitDataClass: Codable {
    
}

// MARK: - Attachment
struct Attachment: Codable {
    let id: String?
    let url, signedURL: String?
    let name: String?
    var size: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case url
        case signedURL = "signedUrl"
        case name
    }
}

struct AssignmentSection: Equatable {
    static func == (lhs: AssignmentSection, rhs: AssignmentSection) -> Bool {
        
        return lhs.id == rhs.id && lhs.data.count == rhs.data.count
    }
    
    var id = UUID().uuidString
    var sestion: Date?
    var title: String?
    var data: [AssignmentsDataComment]
    var isSelect: Bool = false
    var isSelectCollectionCell: Bool = false
    var bricksHeight: [Double] = [Double](repeating: 0, count: 30).map({ _ in Double.random(in: 7...20)})
    init(sestion: Date, title: String, data: [AssignmentsDataComment]) {
        self.sestion = sestion
        self.title = title
        self.data = data
    }
}
struct AssignmentUploadData {
    var id = UUID().uuidString
    var name = ""
    var url = ""
}

struct AssignmentAttachmentModel: Codable {
    let message: String?
    let data: Attachment?
    
    struct AssignmentAttachmentDatum: Codable {
        let url: String?
        let signedUrl: String?
        let size: Int?
        let name: String?
        var id: String = ""
        enum CodingKeys: String, CodingKey {
            case url
            case signedUrl
            case name, size
        }
    }    
}


struct AudioUrl{
    var id = UUID().uuidString
    var url = ""
    var isSelect = false
    var bricksHeight: [Double] = [Double](repeating: 0, count: 30).map({ _ in Double.random(in: 7...20)})

}

enum FileType {
    case photos
    case camera
    case document
}

enum ContentType {
    case text
    case image
    case documentWithPhoto
    case video
    case documents
    case audioRecord
    case staffComment
}

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
    case fileNotFound
}
