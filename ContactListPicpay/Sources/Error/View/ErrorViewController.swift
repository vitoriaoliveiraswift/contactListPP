import UIKit
import SnapKit

final class ErrorViewController: UIViewController {
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Não foi possível carregar as informações  Tente novamente mais tarde"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = UIColor.black
        return label
    }()
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tente novamente", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
    }
    private func addSubviews() {
        view.addSubview(errorLabel)
        view.addSubview(tryAgainButton)
    }
    private func makeConstraints() {
        constraintLabel()
        constraintButton()
    }
    private func constraintLabel() {
        errorLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    private func constraintButton() {
        tryAgainButton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.top.equalTo(150)
            make.centerX.equalToSuperview()
        }
    }
}




