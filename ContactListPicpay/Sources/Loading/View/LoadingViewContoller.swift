import UIKit
import SnapKit

final class LoadingViewController: UIViewController {
    
    private lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.color = .black
        //indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private var buttonSpinner: UIButton = { 
        let button = UIButton(type: .system)
        //button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Parar/Iniciar", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
     }()
    @objc func buttonTapped() {
        if spinner.isAnimating {
        spinner.stopAnimating()
        } else {
        spinner.startAnimating()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        spinner.startAnimating()
        addSubviews()
        makeConstraints()
    }
    private func addSubviews() {
        view.addSubview(spinner)
        view.addSubview(buttonSpinner)
    }
    private func makeConstraints() {
        constraintSpinner()
        constraintButtonSpinner()
    }
    private func constraintSpinner() {
        spinner.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(110)
        }
    }
    private func constraintButtonSpinner() {
        buttonSpinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.top.equalTo(80)
        }
    }
}
