import UIKit
import SnapKit

class ContactCell: UITableViewCell {
    
    private var contactImage: UIImageView = {
        let image = UIImageView()
        //image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    private lazy var contactLabel: UILabel = {
        let label = UILabel()
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var contactDescription: UILabel = {
        let description = UILabel()
        //description.translatesAutoresizingMaskIntoConstraints = false
        description.font = .systemFont(ofSize: 12)
        return description
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        contentView.addSubview(contactImage)
        contentView.addSubview(contactLabel)
        contentView.addSubview(contactDescription)
    }
    private func makeConstraints() {
        constraintImage()
        constraintLabel()
        constraintDescription()
    }
    private func constraintImage() {
        contactImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalTo(contentView.center)
            make.leadingMargin.equalTo(10)
            make.trailingMargin.equalTo(contactLabel.snp.leading).offset(10)
        }
    }
    private func constraintLabel() {
        contactLabel.snp.makeConstraints { make in
            make.leading.equalTo(contactImage.snp.trailing).offset(5)
            make.trailing.equalTo(5)
            make.height.equalTo(20)
            make.top.equalTo(5)
            make.bottom.equalTo(contactDescription.snp.top).inset(5)
        }
    }
    private func constraintDescription() {
        contactDescription.snp.makeConstraints { make in
            make.leading.equalTo(contactImage.snp.trailing).offset(6)
            make.height.equalTo(20)
            make.trailing.equalTo(5)
        }
    }    
    func configureCell(base64Image: String, name: String, description: String?) {
        //let image = base64Image.
       // contactImage.getPhoto(url: imageUrl)
        contactLabel.text = name
        contactDescription.text = description
    }
    enum AccessoryType : Int, @unchecked Sendable {
        case disclosureIndicator = 1
    }
}

