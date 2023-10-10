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
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        dateLabel.numberOfLines = 0
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private let currentWeatherLabel: UILabel = {
        let currentWeatherLabel = UILabel()
        currentWeatherLabel.textAlignment = .center
        currentWeatherLabel.textColor = .gray
        currentWeatherLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        currentWeatherLabel.numberOfLines = 0
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        return currentWeatherLabel
    }()
    
    
    //MARK: - Lifecycle
    func configureWithModel(model: WeatherForecastModel?) {
        
        if let model = model {
            dateLabel.text = model.dt
            currentWeatherLabel.text = "H: \(model.tempMin ?? "") | L: \(model.tempMax ?? "")"
            self.currentWeatherImageView.loadImage(url: model.icon ?? "")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(currentWeatherImageView)
        currentWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(currentWeatherLabel)
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            currentWeatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
            currentWeatherImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 35.0),
            currentWeatherImageView.heightAnchor.constraint(equalToConstant: 40.0),
            currentWeatherImageView.widthAnchor.constraint(equalToConstant: 40.0)
            
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            dateLabel.leftAnchor.constraint(equalTo: currentWeatherImageView.rightAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            currentWeatherLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            currentWeatherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            currentWeatherLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentWeatherImageView.image = nil
        dateLabel.text = nil
        currentWeatherLabel.text = nil
    }
}
