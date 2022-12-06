import UIKit

final class DetailService {
    
    private let baseURL = "https://637e66bccfdbfd9a63b05d28.mockapi.io/api/v1/contacts"
    
    func getContact(contactId: String, closureReturn: @escaping (Result<ContactsModel, DetailServiceError>) -> Void) {
        guard let url = URL(string: baseURL + "/" + contactId) else {
            closureReturn(.failure(.invalidUrlError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                closureReturn(.failure(.noDataError))
                return
            }
            let decoder = JSONDecoder()
            if let contact = try? decoder.decode(ContactsModel.self, from: data) {
                closureReturn(.success(contact))
            } else {
                if let error = error as? DetailServiceError {
                    closureReturn(.failure(error))
                } else {
                    closureReturn(.failure(.decodeError))
                }
            }
        }
        task.resume()
    }
    func deleteContact(contactID: String, completion: @escaping (Result<String, DetailServiceError>) -> Void) {
        guard let url = URL(string: baseURL + "/" + contactID) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Contato excluído com sucesso")
                    completion(.success("Contato excluído com sucesso"))
                } else {
                    if let error = error as? DetailServiceError {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.deleteContactError))
                    }
                    print("Erro ao remover contato")
                }
            }
        }
        dataTask.resume()
    }
}
enum DetailServiceError: Error {
    case deleteContactError
    case invalidUrlError
    case noDataError
    case decodeError
}
