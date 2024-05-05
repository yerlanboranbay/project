import UIKit
import SnapKit

class ViewController: UIViewController {
    let backgroundImageView:UIImageView = {
        let img = UIImageView(image: UIImage(named: "stars"))
        return img
    }()

    private lazy var logoTitle: UIImageView = {
        let img = UIImageView(image: UIImage(named: "logoTitle"))
        return img
    }()
    
    private lazy var logo: UIImageView = {
        let img = UIImageView(image: UIImage(named: "logo"))
        return img
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(logoTitle)
        stackView.addArrangedSubview(logo)
        
        stackView.distribution = .fill
        stackView.spacing = 90
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 4/255, green: 12/255, blue: 30/255, alpha: 1)
        
        let tapGester = UITapGestureRecognizer(target: self, action: #selector(moveVCWithTapGester))
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.addGestureRecognizer(tapGester)
        
        setUpViews()
        setUpConstraints()
    }
    
    @objc func moveVCWithTapGester() {
        let vc = UINavigationController(rootViewController: CharacterViewController())
        let newViewController = vc
        newViewController.modalPresentationStyle = .fullScreen
        present(newViewController, animated: true)
        
    }
}

extension ViewController {
    func setUpViews(){
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(stackView)
    }
    
    func setUpConstraints(){
        backgroundImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(130)
            make.trailing.equalToSuperview().inset(130)
        }
        
        logoTitle.snp.makeConstraints { make in
            make.height.equalTo(80)
        }

        logo.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
}
