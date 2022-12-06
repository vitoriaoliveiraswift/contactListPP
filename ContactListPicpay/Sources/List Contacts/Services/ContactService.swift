import UIKit

final class ContactService {

    private let baseURL = "https://637e66bccfdbfd9a63b05d28.mockapi.io/api/v1/contacts"
    
    func getContacts(closureReturn: @escaping (Result<[ContactsModel], Error>) -> Void ) {
        //essa linha inferior tenta converter a string baseURL em url
        guard let url = URL(string: baseURL) else {
            return
        }
        //essa linha inferior inicia uma requisição para o servidor
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    closureReturn(Result.failure(error))
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let contactsList = try decoder.decode([ContactsModel].self, from: data)
                closureReturn(Result.success(contactsList))
            }
            catch {
                print("erro:\(error)")
            }
        }
        task.resume()
    }
    enum Service: Error {
        case networkError
        case companyEmpty
        case photoUrlEmpty
    }
}
