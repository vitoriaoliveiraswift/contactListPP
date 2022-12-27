import UIKit

final class AddConstactsService {
    
    
    
    private let baseURL = "https://637e66bccfdbfd9a63b05d28.mockapi.io/api/v1/contacts"
    
    func addContact(contact: ContactsModel, completion: @escaping (Result<String, Error>) -> Void) {
        
        
        
        guard let url = URL(string: baseURL),
              let json = try? JSONEncoder().encode(contact)
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    completion(.success("Contato adicionado com sucesso"))
                } else {
                    if let error = error {
                        completion(.failure(error))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
