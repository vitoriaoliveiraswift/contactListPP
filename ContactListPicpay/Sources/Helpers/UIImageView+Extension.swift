import UIKit

extension UIImageView {
    
    func getPhoto(url: String) {
        if let url = URL(string: url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
        if self.image == nil {
            self.image = UIImage(named: "guest")
        }
    }
    func convertImageToBase64String() -> String {
        self.image?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage(imageBase64String: String) {
        let imageData = Data(base64Encoded: imageBase64String)
        self.image = UIImage(data: imageData!)
        
    }
}
extension UIImage {
    
    func convertImageToBase64String() -> String {
        self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage(imageBase64String: String) -> UIImage? {
        let imageData = Data(base64Encoded: imageBase64String)
        return UIImage(data: imageData!) 
    }
}

