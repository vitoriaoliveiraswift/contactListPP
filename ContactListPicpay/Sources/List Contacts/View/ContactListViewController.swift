import UIKit
import SnapKit

final class ContactListViewControler: UIViewController {
    
    private var contacts: [ContactsModel] = []
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.color = .black
        indicator.isHidden = true
        indicator.stopAnimating()
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "contactCell")
        return tableView
    }()
    private func navigationAdd() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        makeRequest()
        navigationAdd()
    }
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
    }
    private func makeConstraints() {
        constraintTableView()
        constraintLoadingView()
    }
    private func constraintTableView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func constraintLoadingView() {
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func showLoading(isActived: Bool) {
        tableView.isHidden = isActived
        loadingView.isHidden = !tableView.isHidden
        if isActived {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
        }
    }
    private func makeRequest() {
        let service = ContactService()
        
        showLoading(isActived: true)
        
        service.getContacts { [weak self] result in
            switch result {
            case let .success(contacts):
                self?.contacts = contacts
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.showLoading(isActived: false)
                }
            case .failure(_):
                print("deu erro")
                self?.showLoading(isActived: false)
            }
        }
    }
    @objc func addTapped() {
        self.navigationController?.pushViewController(AddContactsViewController(), animated: true)
    }
}
extension ContactListViewControler: UITableViewDataSource, UITableViewDelegate {
    
    func tableViewDelete(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle ,indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableViewDeleted(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.title = "Contatos"
        return contacts.count
    }
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.accessoryType = .disclosureIndicator
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        let contact = contacts[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.configureCell(base64Image: contact.photoURL ?? "",
                           name: contact.name,
                           description: contact.company)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let detailScreenViewController = DetailScreenViewController(contactID: contact.id ?? "")
        self.navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
}
