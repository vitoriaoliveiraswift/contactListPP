import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    static let identifier: String = "DetailTableViewCell"

    private var keyLabel: UILabel = {
        let key = UILabel()
        key.font = .systemFont(ofSize: 16)
        return key
    }()
    private var valueLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 16)
        return value
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
    }
    private func makeConstraints() {
        constraintKey()
        constraintValue()
    }
    private func constraintKey() {
        keyLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.trailing.equalToSuperview().inset(15)
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(contentView.snp.top).inset(10)
        }
    }
    private func constraintValue() {
        valueLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(keyLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(contentView.snp.bottom).inset(20)
        }
    }
    func configureCell(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
}
