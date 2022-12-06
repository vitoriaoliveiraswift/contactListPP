import UIKit
import SnapKit
import Photos
import PhotosUI

class AddContactsViewController: UIViewController {
        
    private var newImage: UIButton = {
        let image = UIButton()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.setImage(UIImage(named: "guest"), for: .normal)
        image.addTarget(self, action: #selector(showImagePickerControllerActionSheet), for: .touchUpInside)
        return image
    }()
    private var newName: UITextField = {
        let name = UITextField()
        name.textAlignment = .center
        name.font = .systemFont(ofSize: 20)
        name.placeholder = "Nome"
        name.layer.cornerRadius = 13
        name.backgroundColor = .systemGray6
        name.layer.borderWidth = 0.5
        name.layer.borderColor = UIColor.gray.cgColor
        name.keyboardType = .alphabet
        return name
    }()
    private var newSurname: UITextField = {
       let surname = UITextField()
        surname.textAlignment = .center
        surname.font = .systemFont(ofSize: 20)
        surname.placeholder = "Sobrenome"
        surname.layer.cornerRadius = 13
        surname.backgroundColor = .systemGray6
        surname.layer.borderWidth = 0.5
        surname.layer.borderColor = UIColor.gray.cgColor
        surname.keyboardType = .alphabet
        return surname
    }()
    private var newCompany: UITextField = {
        let company = UITextField()
        company.textAlignment = .center
        company.font = .systemFont(ofSize: 20)
        company.placeholder = "Empresa"
        company.layer.cornerRadius = 13
        company.backgroundColor = .systemGray6
        company.layer.borderWidth = 0.5
        company.layer.borderColor = UIColor.gray.cgColor
        company.keyboardType = .alphabet
        return company
    }()
    private var newNumber: UITextField = {
       let number = UITextField()
        number.textAlignment = .center
        number.font = .systemFont(ofSize: 20)
        number.placeholder = "Digite o número de celular"
        number.layer.cornerRadius = 13
        number.backgroundColor = .systemGray5
        number.layer.borderWidth = 0.5
        number.layer.borderColor = UIColor.gray.cgColor
        number.keyboardType = .decimalPad
        return number
    }()
    
    private var newEmail: UITextField = {
       let email = UITextField()
        email.textAlignment = .center
        email.font = .systemFont(ofSize: 20)
        email.placeholder = "Digite o email"
        email.layer.cornerRadius = 13
        email.backgroundColor = .systemGray5
        email.layer.borderWidth = 0.5
        email.layer.borderColor = UIColor.gray.cgColor
        email.keyboardType = .emailAddress
        return email
    }()
    private var newInstagram: UITextField = {
       let instagram = UITextField()
        instagram.textAlignment = .center
        instagram.font = .systemFont(ofSize: 20)
        instagram.placeholder = "Digite o instagram"
        instagram.layer.cornerRadius = 13
        instagram.backgroundColor = .systemGray5
        instagram.layer.borderWidth = 0.5
        instagram.layer.borderColor = UIColor.gray.cgColor
        instagram.keyboardType = .alphabet
       return instagram
    }()
    
    private func navigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cadastrar", style: .plain, target: self, action: #selector(signUpTapped))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Novo contato"
        navigationItem()
        addSubviews()
        makeConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    func addSubviews() {
        view.addSubview(newImage)
        view.addSubview(newName)
        view.addSubview(newSurname)
        view.addSubview(newCompany)
        view.addSubview(newNumber)
        view.addSubview(newEmail)
        view.addSubview(newInstagram)
    }
    func makeConstraints() {
        newImageConstraint()
        newNameConstraint()
        newSurnameConstraint()
        newCompanyConstraint()
        newNumberConstraint()
        newEmailConstraint()
        newInstagramConstraint()
    }
    private func newImageConstraint() {
        newImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(120)
            make.trailing.equalToSuperview().inset(120)
            make.top.equalTo(110)
            make.bottom.equalToSuperview().inset(590)
        }
    }
    private func newNameConstraint() {
        newName.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newImage.snp.bottom).offset(35)
            make.leading.equalTo(view).inset(15)
            
        }
    }
    private func newSurnameConstraint() {
        newSurname.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newName.snp.bottom).offset(15)
            make.leading.equalTo(15)
            make.trailing.equalTo(newName)
        }
    }
    private func newCompanyConstraint() {
        newCompany.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newSurname.snp.bottom).offset(15)
            make.leading.equalTo(15)
            make.trailing.equalTo(newSurname)
        }
    }
    private func newNumberConstraint() {
        newNumber.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newCompany.snp.bottom).offset(55)
            make.leading.equalTo(15)
            make.trailing.equalTo(newSurname)

        }
    }
    private func newEmailConstraint() {
        newEmail.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newNumber.snp.bottom).offset(35)
            make.leading.equalTo(15)
            make.trailing.equalTo(newNumber)
        }
    }
    private func newInstagramConstraint() {
        newInstagram.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(newEmail.snp.bottom).offset(35)
            make.leading.equalTo(15)
            make.trailing.equalTo(newEmail)
        }
    }
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func signUpTapped() {
        
        isFieldValid(fieldName: newName.placeholder ?? "", fieldValue: newName.text)
        isFieldValid(fieldName: newSurname.placeholder ?? "", fieldValue: newSurname.text)
        isEmailValid(emailValue: newEmail.text)
        isNumberValid(numberValue: newNumber.text)
        navigationController?.popViewController(animated: true)
        
        var informations:[ContactsInformationModel] = []
        
        if let phoneNumber = newNumber.text {
            informations.append(ContactsInformationModel(key: "telefone", value: phoneNumber))
        }
        if let emailAdress = newEmail.text {
            informations.append(ContactsInformationModel(key: "email", value: emailAdress))
        }
        if let instagramAdress = newInstagram.text {
            informations.append(ContactsInformationModel(key: "instagram", value: instagramAdress))
        }
        
        let contact = ContactsModel(id: "0",
                                    name: newName.text ?? "",
                                    photoURL: newImage.image(for: .normal)?.convertImageToBase64String(),
                                    company: newCompany.text,
                                    informations: informations)
        
        let service = AddConstactsService()
        service.addContact(contact: contact) { retorno in
            switch retorno {
            case let .success(mensagem):
                //adicionar alert exibindo mensagem
                print(mensagem)
            case let .failure(error):
                //adicionar alert exibindo erro
                print(error)
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        resignFirstResponder()
    }
}
extension AddContactsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func showImagePickerControllerActionSheet() {
        showAlert(title: "Escolha uma imagem",
                  message: "",
                  firstButtonTitle: "Abrir a câmera",
                  secondButtonTitle: "Abrir a galeria",
                  firstButtontHandler: { _ in
            self.openCamera()
        },
                  secondButtonHandler: { _ in
            self.openGallery()
            //alert.dismiss(animated: true, completion: nil)
        },
                  alertStyle: .actionSheet)
    }
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            present(myPickerController, animated: true, completion: nil)
        } else {
            showAlert(message: "Não foi possível abrir a câmera")
        }
    }
    func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        newImage.setImage(selectedImage, for: .normal)
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
extension AddContactsViewController {
    enum ValidityType {
        case email
        //case number
        //case instagram
    }
    enum Regex: String {
        case email = "[A-Z0-9a-z._]+[A-Za-z0-9.]+\\.[a-z.]{2,64}"
    }
    
    func isValidType(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        }
        return true
    }
    
    func messagePrint(message: String, name: String) {
        print("esta é a mensagem: \(message) e o nome \(name)")
    }
    
    func isNumberValid(numberValue: String?) -> Bool {
        guard let numberValue = numberValue, !numberValue.isEmpty else {
            return isFieldValid(fieldName: "telefone", fieldValue: numberValue)
        }
        let numberRegEx = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{5}$"#
            let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
            let isValid =  numberPred.evaluate(with: numberValue)
        if !isValid {
            showAlert(message: "Informe um número válido")
        }
        return isValid
    }
    func isEmailValid(emailValue: String?) -> Bool {
        guard let emailValue = emailValue, !emailValue.isEmpty else {
            return true
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValid =  emailPred.evaluate(with: emailValue)
        if !isValid {
            showAlert(message: "Informe um email válido")
        }
        return isValid
        
    }
    func isFieldValid(fieldName: String, fieldValue: String?) -> Bool {
        guard let fieldValue = fieldValue, !fieldValue.isEmpty else {
            showAlert(message: "Necessário preencher o campo de \(fieldName)")
            return false
        }
        return true
    }
}
