import UIKit

extension UIViewController {
    func showAlert(title: String? = "Alerta",
                   message: String?,
                   firstButtonTitle: String = "Não",
                   secondButtonTitle: String = "Sim",
                   firstButtontHandler: ((UIAlertAction) -> Void)? = nil,
                   secondButtonHandler: ((UIAlertAction) -> Void)? = nil,
                   alertStyle: UIAlertController.Style = .alert)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        if secondButtonHandler == nil {
            let actionOk = UIAlertAction(title: "Ok", style: .default, handler: firstButtontHandler)
            alert.addAction(actionOk)
        } else {
            let actionNo = UIAlertAction(title: firstButtonTitle, style: .default, handler: firstButtontHandler)
            alert.addAction(actionNo)
            let actionYes = UIAlertAction(title: secondButtonTitle, style: .default, handler: secondButtonHandler)
            alert.addAction(actionYes)
        }
        self.present(alert, animated: true)
    }
}
