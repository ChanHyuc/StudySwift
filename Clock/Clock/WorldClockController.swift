import UIKit

class WorldClockController: UIViewController {
    private let worldClockCell = "cell"
    private var worldClockList = [TimeZone(identifier: "Asia/Seoul"), TimeZone(identifier: "Europe/Paris"), TimeZone(identifier: "America/New_York"), TimeZone(identifier: "Asia/Tehran"), TimeZone(identifier: "Asia/Vladivostok")]
    
    private let tableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        configureNavigationBar()
        configureTableView()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.register(WorldClockCell.self, forCellReuseIdentifier: worldClockCell)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "세계 시계"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(didTapEditButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlusButton))
    }
    
    @objc private func didTapEditButton() {
        
    }
    
    @objc private func didTapPlusButton() {
        present(UINavigationController(rootViewController: CitySelectionViewController()), animated: true)
    }
    
}

extension WorldClockController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldClockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: worldClockCell, for: indexPath) as? WorldClockCell else {
            return UITableViewCell()
        }
        
        let target = worldClockList[indexPath.row]
        
        cell.timeOffSetLabel.text = target?.timeOffset
        cell.timeZoneLabel.text = target?.city
        cell.timeLabel.text = target?.currentTime
        cell.timePeriodLable.text = target?.timePeriod
        
        
        return cell
    }
    
}
