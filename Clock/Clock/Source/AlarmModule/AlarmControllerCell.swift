import UIKit

class AlarmControllerCell: UITableViewCell, TableViewMode {
    func mode(mode: AlarmTableViewMode) {
        alarmTalbeViewMode = .edit
    }
    
    private let vc = AlarmController()
    private var alarmId: String?
    private var alarmTalbeViewMode: AlarmTableViewMode = .common
    
    private let editImage = {
        let imageView = UIImageView(image: UIImage(systemName: "minus.circle.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        imageView.isHidden = true
        return imageView
    }()
    
    private var labels: [UILabel] = []
    
    private let dayPeriod = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "오전"
        return label
    }()
    
    private let clockLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.text = "5:10"
        return label
    }()
    
    private let alarmLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "알람,"
        return label
    }()
    
    private let loopLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "매일"
        return label
    }()
    
    private let alarmToggleSwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.addTarget(self, action: #selector(toggleSwitch(_:)), for: .valueChanged)
        return toggleSwitch
    }()
    
    @objc private func toggleSwitch(_ sender: UISwitch) {
        if let alarmId = alarmId {
            UserDefaults.standard.setAlarmState(sender.isOn, for: alarmId)
            updateLabelColors(isOn: sender.isOn)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        labels = [dayPeriod, clockLabel, alarmLabel, loopLabel]
        vc.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(dayPeriod)
        addSubview(clockLabel)
        addSubview(alarmLabel)
        addSubview(loopLabel)
        contentView.addSubview(alarmToggleSwitch)
        contentView.addSubview(editImage)
        
        NSLayoutConstraint.activate([
            dayPeriod.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dayPeriod.bottomAnchor.constraint(equalTo: alarmLabel.topAnchor, constant: -10),
            clockLabel.leadingAnchor.constraint(equalTo: dayPeriod.trailingAnchor),
            clockLabel.bottomAnchor.constraint(equalTo: alarmLabel.topAnchor),
            
            alarmLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            alarmLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            loopLabel.leadingAnchor.constraint(equalTo: alarmLabel.trailingAnchor, constant: 5),
            loopLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            alarmToggleSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            alarmToggleSwitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            editImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            editImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(with alarmId: String) {
        self.alarmId = alarmId
        let isOn = UserDefaults.standard.getAlarmState(for: alarmId)
        alarmToggleSwitch.isOn = isOn
        updateLabelColors(isOn: isOn)
    }
    
    func alarmTableViewMode() {
        if alarmTalbeViewMode == .common {
            editImage.isHidden = false
            alarmToggleSwitch.isHidden = true
            alarmTalbeViewMode = .edit
        } else {
            editImage.isHidden = true
            alarmToggleSwitch.isHidden = false
            alarmTalbeViewMode = .common
        }
    }
    
    private func updateLabelColors(isOn: Bool) {
        let labelColor: UIColor = isOn ? .white : .systemGray2
        for label in labels {
            label.textColor = labelColor
        }
    }
    
}
