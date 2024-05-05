import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    let resultData: Result
    private let arrayTitle: [String] = ["Gender:", "Type:", "Location:", "Origin:"]
    private lazy var arrayAns: [String] = [self.resultData.gender, self.resultData.type, resultData.location.name, resultData.origin.name]
    private let backColor: [UIColor] = [
        UIColor(red: 116/255, green: 226/255, blue: 145/255, alpha: 1), 
        UIColor(red: 216/255, green: 174/255, blue: 126/255, alpha: 1),
        UIColor(red: 122/255, green: 178/255, blue: 178/255, alpha: 1),
        UIColor(red: 77/255, green: 134/255, blue: 156/255, alpha: 1)]
    
    init(resultData: Result) {
        self.resultData = resultData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var img: UIImageView = {
        let img = UIImageView()
        let url = URL(string: resultData.image)!
        img.kf.setImage(with: url)
        return img
    }()
    
    private lazy var titleName: UILabel = {
        let title = UILabel()
        title.text = resultData.name
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 20)
        return title
    }()
    
    private lazy var live: UILabel = {
        let live = UILabel()
        live.textColor = .green
        live.textAlignment = .center
        live.text = resultData.status
        return live
    }()
    
    private lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [img, titleName, live])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailInfoTableViewCell.self, forCellReuseIdentifier: "DetailInfoTableViewCell")
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 4/255, green: 12/255, blue: 30/255, alpha: 1)
        setUpViews()
        setUpConstraints()
    }
}

//MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoTableViewCell", for: indexPath) as! DetailInfoTableViewCell
        cell.configure(title: arrayAns[indexPath.row], textTitle: arrayTitle[indexPath.row], isLast: (indexPath.row - 1 == 7) ? true : false, backColor: backColor[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
}

//MARK: - setUpVies and setUpConstraints
extension DetailViewController {
    func setUpViews(){
        view.addSubview(stackViewHeader)
        view.addSubview(tableView)
    }
    
    func setUpConstraints(){
        stackViewHeader.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackViewHeader.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        img.snp.makeConstraints { make in
            make.size.equalTo(200)
        }
    }
}
