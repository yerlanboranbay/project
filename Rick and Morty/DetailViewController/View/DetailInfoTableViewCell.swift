import UIKit

class DetailInfoTableViewCell: UITableViewCell {
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var textTitle: UILabel = {
        let text = UILabel()
        text.text = "Text"
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    private lazy var title: UILabel = {
        let text = UILabel()
        text.text = "Text"
        text.textAlignment = .center
        text.textColor = .white
        return text
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:  [textTitle, title, UIView()])
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        backgroundColor = .clear
    }
    
    func configure(title: String, textTitle: String, isLast: Bool, backColor: UIColor){
        self.textTitle.text = textTitle
        self.title.text = title
        self.backView.layer.borderColor = backColor.cgColor
        self.backView.backgroundColor = backColor
        contentView.addSubview(backView)
        backView.snp.updateConstraints { make in
            make.center.equalToSuperview()
            make.bottom.equalToSuperview().inset(isLast ? 0 : 10)
        }
    }
}

extension DetailInfoTableViewCell {
    func setupViews() {
        contentView.addSubview(backView)
        backView.addSubview(stackView)
    }
    
    func setupConstraints() {
        backView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
}
