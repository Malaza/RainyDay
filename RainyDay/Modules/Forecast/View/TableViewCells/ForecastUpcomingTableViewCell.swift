//
//  ForecastUpcomingTableViewCell.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/09.
//

import UIKit

class ForecastUpcomingTableViewCell: UITableViewCell {

    static let identifier = "ForecastUpcomingTableViewCell"
    
    //MARK:  - Outlets
    private let currentWeatherImageView: UIImageView = {
        let currentWeatherImageView = UIImageView()
        currentWeatherImageView.contentMode = .scaleAspectFill
        return currentWeatherImageView
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textAlignment = .center
        dateLabel.textColor = .white
        dateLabel.backgroundColor = .clear
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
//    private let currentWeatherLabel: UILabel = {
//        let currentWeather = UILabel()
//        currentWeather.textAlignment = .center
//        currentWeather.textColor = .white
//        currentWeather.backgroundColor = .clear
//        currentWeather.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
//        currentWeather.numberOfLines = 0
//        currentWeather.translatesAutoresizingMaskIntoConstraints = false
//        return currentWeather
//    }()
    
    
    //MARK: - Lifecycle
    func configureWithModel(model: WeatherForecastModel?) {
        dateLabel.text = model?.dt
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        self.addSubview(currentWeatherImageView)
        currentWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            currentWeatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            currentWeatherImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            currentWeatherImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            currentWeatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }
}
