//import UIKit
//
//final class MyViewModel: ObservableObject {
//    var array: [PhotoDragAndDropModel] = []
//
//    func addImage(image: UIImage) {
//        let imageModel = PhotoDragAndDropModel(image: image, isCanDelete: true)
//        array.append(imageModel)
//    }
//    
//    func removeImage(model: PhotoDragAndDropModel) {
//        guard let index = array.firstIndex(where: { $0.id == model.id }) else { return }
//        array.remove(at: index)
//    }
//}
//
//class MyViewController: UIViewController {
//    
//    private let viewModel = MyViewModel()
//    
//    enum Constants {
//        static let borderWidth0: CGFloat = 0
//        static let borderWidth: CGFloat = 1
//        static let numberOfCellInOneLine: CGFloat = 3
//        static let collectionLineSpace: CGFloat = 3.5
//        static let collectionInterItemSpace: CGFloat = 5.5
//        static let closeButtonInsetOfset: CGFloat = 5
//        static let numberOfTheCell: Int = 9
//        static let titleAddCellSize: CGFloat = 10
//        static let cornerRadius: CGFloat = 12
//        static let titleNameSize: CGFloat = 16
//        static let plusButtonSize: CGFloat = 25
//        static let procent: CGFloat = 100
//        static let plusButtonLabel: String = "+"
//    }
//    
//    private lazy var titleName = UILabel().apply {
//        $0.text = NSLocalizedString("photos", comment: "")
//        $0.textColor = .dark180
//        $0.font = .boldSystemFont(ofSize: Constants.titleNameSize)
//    }
//    
//    private let collectionView: UICollectionView = {
//        var layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = Constants.collectionLineSpace
//        layout.minimumInteritemSpacing = Constants.collectionInterItemSpace//7.5
//        layout.itemSize = CGSize(
//            width: (UIScreen.main.bounds.width / Constants.numberOfCellInOneLine) - (layout.minimumInteritemSpacing * Constants.numberOfCellInOneLine/*2.5*/),
//            height: (UIScreen.main.bounds.width / Constants.numberOfCellInOneLine - 13) * 134 / Constants.procent
//        )
//        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(EditCollectionViewCell.self, forCellWithReuseIdentifier: EditCollectionViewCell.identifier)
//        collectionView.showsVerticalScrollIndicator = false
//        return collectionView
//    }()
//    
//    private let titleAddCell = UILabel().apply {
//        $0.text = NSLocalizedString("addPhoto", comment: "")
//        $0.font = .systemFont(ofSize: Constants.titleAddCellSize)
//        $0.textColor = UIColor.darkBlue600
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .gray100
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        let gester = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGester(_:)))
//        collectionView.addGestureRecognizer(gester)
//        setUpViews()
//        setUpConstraints()
//    }
//    
//    @objc func handleLongPressGester(_ gester: UILongPressGestureRecognizer) {
//        switch gester.state {
//        case .began:
//            guard let targetIndexPath = collectionView.indexPathForItem(at: gester.location(in: collectionView)) else {
//                return
//            }
//            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(gester.location(in: collectionView))
//        case .ended:
//            collectionView.endInteractiveMovement()
//        default:
//            collectionView.cancelInteractiveMovement()
//        }
//    }
//}
//
////MARK: - colectonView Delegate
//extension MyViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Constants.numberOfTheCell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditCollectionViewCell.identifier, for: indexPath) as! EditCollectionViewCell
//        if indexPath.row == 0 {
//            cell.addSubview(titleAddCell)
//            titleAddCell.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview().offset(17)
//            }
//        }
//        if indexPath.row < viewModel.array.count {
//            cell.configure(model: viewModel.array[indexPath.row])
//            if viewModel.array[0] != nil {
//                titleAddCell.isHidden = true
//            }
//            cell.deleteSelectedCell = { [weak self] model in
//                self?.viewModel.removeImage(model: model)
//                collectionView.reloadData()
//            }
//        }
//        if viewModel.array.isEmpty {
//            titleAddCell.isHidden = false
//        }
//        return cell
//    }
//}
//
//extension MyViewController: UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        if sourceIndexPath.row < viewModel.array.count {
//            let item = viewModel.array.remove(at: sourceIndexPath.row)
//            if destinationIndexPath.row <= viewModel.array.count {
//                viewModel.array.insert(item, at: destinationIndexPath.row)
////                return
//            } else {
//                viewModel.array.insert(item, at: sourceIndexPath.row)
//                collectionView.reloadData()
////                return
//            }
//        }
//    }
//    
//    //MARK: - collection didSelect
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let index = indexPath.row
//        let array = viewModel.array
//        
//        let alertSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//        alertSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                self.createImagePickerController(sourceType: .camera)
//            } else {
//                print("Camera not available.")
//            }
//        }))
//        alertSheet.addAction(UIAlertAction(title: "Open Gallery", style: .default, handler: { _ in
//            self.createImagePickerController(sourceType: .photoLibrary)
//        }))
//        
//        if array.indices.contains(index) {
//            alertSheet.addAction(UIAlertAction(title: "Delete Photo", style: .destructive, handler: { [self] _ in
//                print("Delete Photo")
//                collectionView.reloadData()
//                viewModel.removeImage(model: viewModel.array[indexPath.row])
//                if viewModel.array.isEmpty {
//                    titleAddCell.isHidden = false
//                }
//            }))
//        }
//        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        present(alertSheet, animated: true)
//    }
//    
//    //imagePickerController
//    func createImagePickerController(sourceType: UIImagePickerController.SourceType) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = sourceType
//        imagePicker.delegate = self
//        self.present(imagePicker, animated: true, completion: nil)
//    }
//    
//    //ADD into array,selectedPhotoFromGallary
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            viewModel.addImage(image: selectedImage)
//        }
//        collectionView.reloadData()
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
//
////MARK: - setupViews() and setupConstraints()
//extension MyViewController {
//    func setUpViews(){
//        view.addSubview(titleName)
//        view.addSubview(collectionView)
//    }
//    
//    func setUpConstraints(){
//        titleName.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(Constants.titleNameSize)
//            make.top.equalToSuperview().offset(Constants.titleNameSize)
//            make.bottom.equalTo(collectionView.snp.top).inset(Constants.titleAddCellSize)
//        }
//        collectionView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.horizontalEdges.equalToSuperview().inset(Constants.titleNameSize)
//            make.bottom.equalToSuperview().inset(Constants.titleNameSize)
//        }
//    }
//}
