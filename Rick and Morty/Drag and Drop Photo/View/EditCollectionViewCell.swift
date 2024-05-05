//import UIKit
//import SnapKit
//import SwiftUI
//import Kingfisher
//
//class EditCollectionViewCell: UICollectionViewCell {
//    enum Constants {
//        static let borderWidth0: CGFloat = 0
//        static let borderWidth: CGFloat = 1
//        static let closeButtonInsetOfset: CGFloat = 5
//        static let closeButtonCornerRadius: CGFloat = 10
//        static let cornerRadius: CGFloat = 12
//        static let closeButtonSize: CGFloat = 24
//        static let plusButtonSize: CGFloat = 25
//        static let plusButtonLabel: String = "+"
//    }
//    
//    static let identifier = "EditCollectionViewCell"
//    var model: PhotoDragAndDropModel?
//    var deleteSelectedCell: ((PhotoDragAndDropModel) -> Void)?
//    
//    private let myView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .gray
//        view.layer.cornerRadius = Constants.cornerRadius
//        view.layer.borderWidth = Constants.borderWidth
//        view.layer.borderColor = UIColor.blue.cgColor
//        return view
//    }()
//    
//    private let plusButton: UILabel = {
//        let label = UILabel()
//        label.text = Constants.plusButtonLabel
//        label.font = UIFont.systemFont(ofSize: Constants.plusButtonSize)
//        label.textColor = .black
//        return label
//    }()
//    
//    private let photoView: UIImageView = {
//        let img = UIImageView()
//        img.layer.cornerRadius = Constants.cornerRadius
//        img.layer.borderWidth = Constants.borderWidth
//        img.layer.masksToBounds = true
//        img.contentMode = .scaleAspectFill
//        return img
//    }()
//    
//    private let closeButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "searchX"), for: .normal)
//        button.contentEdgeInsets = UIEdgeInsets(top: Constants.closeButtonInsetOfset, left: Constants.closeButtonInsetOfset,
//                                                bottom: Constants.closeButtonInsetOfset, right: Constants.closeButtonInsetOfset)
//        button.frame.size = CGSize(width: Constants.closeButtonSize, height: Constants.closeButtonSize)
//        button.setBackgroundColor(color: .white, forState: .normal)
//        button.layer.borderColor = UIColor.gray100.cgColor
//        button.layer.cornerRadius = Constants.closeButtonCornerRadius
//        button.layer.masksToBounds = true
//        button.isHidden = true
//        button.addTarget(self, action: #selector(removePhoto), for: .touchUpInside)
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        photoView.image = nil
//        plusButton.isHidden = false
//        myView.layer.borderWidth = Constants.borderWidth
//        myView.layer.borderColor = UIColor.blue.cgColor
//        closeButton.isHidden = true
//    }
//
//    func configure(model: PhotoDragAndDropModel) {
//        photoView.image = model.image
//        self.model = model
//        if photoView.image != nil {
//            plusButton.isHidden = true
//            myView.layer.borderWidth = Constants.borderWidth0
//            myView.layer.borderColor = .none
//            closeButton.isHidden = false
//        } else {
//            photoView.image = nil
//            plusButton.isHidden = false
//            closeButton.isHidden = true
//        }
//    }
//    
//    @objc private func removePhoto() {
//        guard let model else { return }
//        deleteSelectedCell?(model)
//    }
//}
//
////MARK: - setUpViews & setUpConstrains
//private extension EditCollectionViewCell{
//    func setupViews() {
//        addSubview(myView)
//        addSubview(plusButton)
//        myView.addSubview(photoView)
//        contentView.addSubview(closeButton)
//    }
//    
//    func setupConstraints(){
//        myView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        plusButton.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//        photoView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.edges.equalToSuperview()
//        }
//        closeButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(Constants.closeButtonInsetOfset)
//            make.trailing.equalToSuperview().inset(Constants.closeButtonInsetOfset)
//        }
//    }
//}
