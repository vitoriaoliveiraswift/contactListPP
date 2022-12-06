import UIKit
import SnapKit
import MessageUI

class DetailScreenViewController: UIViewController {
    
    private var detailContact: ContactsModel?
    
    private var imageViewContact: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.cornerRadius = 70 //pesquisar calculo radius de acordo com largura e altura
        image.clipsToBounds = true
        return image
    }()
    private var labelName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    private var labelCompany: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private var buttonCall: UIButton = {
        let button = UIButton(type: .system)
        //        addButton.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "call"), for: .normal)
        button.layer.cornerRadius = 31
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
        return button
    }()
    private var buttonMensagem: UIButton = {
        let button = UIButton(type: .system)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "message"), for: .normal)
        //como diminuir a fontede um botão?
        button.layer.cornerRadius = 31
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    private var buttonEmail: UIButton = {
        let button = UIButton(type: .system)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "email"), for: .normal)
        button.layer.cornerRadius = 31
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        
        return button
    }()
    private var buttonEncaminhar: UIButton = {
        let button = UIButton(type: .system)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "share"), for: .normal)
        button.layer.cornerRadius = 31
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onSharePress), for: .touchUpInside)
        return button
    }()
    //    @objc private func actionEncaminhar() {
    //        //let teste = testeViewController()
    //        //testar navigation
    //        //self.navigationController?.pushViewController(teste, animated: true)
    //        self.navigationController?.present(teste, animated: true)
    //    }
    
    private lazy var tableViewDetail: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.isScrollEnabled = false
        table.delegate = self
        table.dataSource = self
        table.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        //colocar uma viewcontroller com altura de 1 a 2 px
        return table
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
//    private lazy var buttonDelete: UIButton = {
//       let button = UIButton(type: .system)
//        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
//        button.imageView?.contentMode = .scaleAspectFit
//        button.setImage(UIImage(named: "trash"), for: .normal)
//        button.layer.cornerRadius = 28
//        button.layer.borderColor = UIColor.gray.cgColor
//        button.layer.borderWidth = 1
//        button.addTarget(self, action: #selector(onDeletePress), for: .touchUpInside)
//       return button
//    }()
    private var contactID: String
    init(contactID: String) {
        self.contactID = contactID

        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func navigationDeleted() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(onDeletePress))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        view.backgroundColor = .white
        makeRequest()
        navigationDeleted()
    }
    private func addSubviews() {
        view.addSubview(imageViewContact)
        view.addSubview(labelName)
        view.addSubview(labelCompany)
        stackView.addArrangedSubview(buttonCall)
        stackView.addArrangedSubview(buttonMensagem)
        stackView.addArrangedSubview(buttonEmail)
        stackView.addArrangedSubview(buttonEncaminhar)
        view.addSubview(stackView)
        view.addSubview(tableViewDetail)
    }
    private func makeConstraints() {
        constraintImageViewContact()
        constraintLabelName()
        constraintLabelEmpresa()
        constraintSubView()
        
        constraintTableViewDetail()
    }
    private func makeRequest() {
        let service = DetailService()
        service.getContact(contactId: contactID) { [weak self] result in
            switch result {
            case let .success(detailContact):
                self?.detailContact = detailContact
                DispatchQueue.main.async {
                    self?.configureInformations(url: detailContact.photoURL ?? "", name: detailContact.name, company: detailContact.company ?? "")
                    self?.tableViewDetail.reloadData()
                }
            case .failure(_):
                print("deu erro")
            }
        }
    }
    @objc func makeCall() {
        //let url:URL = URL(string: "tel://123456789")!
        guard let url = URL(string: "tel://51994075096"),
              UIApplication.shared.canOpenURL(url) else {
            print("não foi possível fazer a ligação")
            return
        }
        UIApplication.shared.open(url as URL)
    }
    func onEmailPress() {
        let controller = MFMailComposeViewController()
        self.present(controller, animated: true)
    }
    @objc func onSharePress() {
        let activityVC = UIActivityViewController(activityItems: [""], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    @objc func onDeletePress() {
        showAlert(message: "Tem certeza de que deseja excluir este contato permanentemente?", firstButtonTitle: "Cancelar", secondButtonTitle: "Excluir") { _ in
            print("Cancelar foi pressionado")
        } secondButtonHandler: { [weak self] _ in
            self?.deleteRequest()
            print("Excluir foi pressionado")
        }
    }
    func deleteRequest() {
        let service = DetailService()
        service.deleteContact(contactID: self.detailContact?.id ?? "") {[weak self] returno in
            switch returno {
            case let .success(message):
                DispatchQueue.main.async {
                    self?.showAlert(message: message, firstButtontHandler: { action in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            case let .failure(error):
                self?.showAlert(title: "Não foi possível excluir este contato",
                                message: error.localizedDescription,
                                firstButtontHandler: { action in
                    print("Falha")
                })
            }
        }
    }
    
    private func constraintImageViewContact() {
        imageViewContact.snp.makeConstraints { make in
            make.top.equalTo(55)
            make.bottom.equalToSuperview().inset(640)
            make.leading.equalToSuperview().offset(120)
            make.trailing.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            
        }
    }
    private func constraintLabelName() {
        labelName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(imageViewContact.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    private func constraintLabelEmpresa() {
        labelCompany.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.top.equalTo(labelName.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    private func constraintButtonLigar() {
        buttonCall.snp.makeConstraints { make in
            make.width.height.greaterThanOrEqualTo(40)
            make.top.equalTo(labelCompany.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
    }
    private func constraintButtonMensagem() {
        buttonMensagem.snp.makeConstraints { make in
            make.width.height.greaterThanOrEqualTo(40)
            make.top.equalTo(buttonCall.snp.top)
            make.leading.equalTo(buttonCall.snp.trailing).offset(20)
        }
    }
    private func constraintButtonEmail() {
        buttonEmail.snp.makeConstraints { make in
            make.width.height.greaterThanOrEqualTo(40)
            make.top.equalTo(buttonCall.snp.top)
            make.leading.equalTo(buttonMensagem.snp.trailing).offset(20)
        }
    }
    private func constraintButtonEncaminhar() {
        buttonEncaminhar.snp.makeConstraints { make in
            make.width.height.greaterThanOrEqualTo(40)
            make.top.equalTo(buttonCall.snp.top)
            make.leading.equalTo(buttonEmail.snp.trailing).offset(20)
        }
    }
    private func constraintSubView() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(labelCompany.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
    }
    private func constraintTableViewDetail() {
        tableViewDetail.snp.makeConstraints { make in
            //make.height.equalTo(350)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(1)
            make.top.equalTo(buttonCall.snp.bottom).offset(40)
        }
    }
    //forma de como conectar itens de um modelo de dados aos componentes da célula
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell else {
    //            return UITableViewCell()
    //        }
    //        let contact = contacts[indexPath.row]
    //        cell.configureCell(imageName: contact.photoURL,
    //                           name: contact.name,
    //                           description: contact.company)
    //        return cell
    //    }
    func configureInformations(url: String, name: String, company: String) {
        imageViewContact.getPhoto(url: url)
        labelName.text = name
        labelCompany.text = company
    }
}
extension DetailScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return detailContact?.informations?.count ?? 0
        //detailContact?.informations?.flatMap( !$0.value?.isEmpty)
        let filterArray = detailContact?.informations?.filter { !$0.value.isEmpty }
        return filterArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterArray = detailContact?.informations?.filter { !$0.value.isEmpty }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell,
              let detailInformation = filterArray?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configureCell(key: detailInformation.key, value: detailInformation.value)
        return cell
        
        //        let information = detailContact?.informations?[indexPath.row]
        //        cell.configureCell(key: information.key  ?? "error", value: information.value ?? "error")
        //        return cell
    }
}
extension DetailScreenViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
        @objc func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            print("erro ao enviar email")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        present(composer, animated: true)
        print("email enviado com sucesso")
    }
}
extension DetailScreenViewController: MFMessageComposeViewControllerDelegate {
    
    @objc func sendMessage(sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
            print("mensagem enviada")
        } else {
            print("erro ao enviar mensagem")
        }
    }
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}
