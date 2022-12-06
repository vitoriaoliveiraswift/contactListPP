import UIKit

struct ContactsModel: Codable {
    let id: String?
    let name: String
    let photoURL: String?
    let company: String?
    let informations: [ContactsInformationModel]?
}

