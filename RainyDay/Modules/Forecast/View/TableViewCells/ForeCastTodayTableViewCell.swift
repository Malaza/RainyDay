//
//  ForecastTodayTableViewCell.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/09.
//

import UIKit

class ForecastTodayTableViewCell: UITableViewCell {

    static let identifier = "ForecastTodayTableViewCell"
    
    //MARK:  - Outlets
    private let currentWeatherImageView: UIImageView = {
        let currentWeatherImageView = UIImageView()
        currentWeatherImageView.contentMode = .center
        return currentWeatherImageView
    }()
    
    private let currentWeatherLabel: UILabel = {
        let currentWeatherLabel = UILabel()
        currentWeatherLabel.textAlignment = .center
        currentWeatherLabel.textColor = .white
        currentWeatherLabel.backgroundColor = .clear
        currentWeatherLabel.numberOfLines = 0
        return currentWeatherLabel
    }()
    
    
    //MARK: - Lifecycle
    func configureWithModel(model: WeatherForecastModel?) {
        if let model = model {
            self.currentWeatherImageView.loadImage(url: model.icon ?? "")
            self.currentWeatherLabel.attributedText = self.attributedStringForTitle(title: "\(model.tempMin ?? "") | \(model.tempMax ?? "")",
                                                                                    subTitle: model.mainWeather?.uppercased() ?? "")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(currentWeatherImageView)
        currentWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(currentWeatherLabel)
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            currentWeatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            currentWeatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            currentWeatherImageView.heightAnchor.constraint(equalToConstant: 40.0),
            currentWeatherImageView.widthAnchor.constraint(equalToConstant: 40.0)
            
        ])
        
        NSLayoutConstraint.activate([
            currentWeatherLabel.topAnchor.constraint(equalTo: currentWeatherImageView.bottomAnchor, constant: 20.0),
            currentWeatherLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            currentWeatherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            currentWeatherLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20.0)
        ])
    }
    
    
    //MARK: - Helper methods
    func attributedStringForTitle(title:String, subTitle:String) -> NSAttributedString {

        let attrHeading:NSMutableAttributedString
        let attrContent:NSMutableAttributedString
        let mainAttributedString = NSMutableAttributedString()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.paragraphSpacing = 4.0

        attrHeading = NSMutableAttributedString(string: title)
        let range = NSRange.init(location: 0, length: title.count)
        attrHeading.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 55.0, weight: .semibold), range: range)
        attrHeading.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: range)
        mainAttributedString.append(attrHeading)

        let stringFormat = String(format: "\n\(subTitle)")
        attrContent = NSMutableAttributedString(string: stringFormat)
        let thisRange = NSRange.init(location: 0, length: stringFormat.count)
        attrContent.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 25.0, weight: .medium), range: thisRange)
        attrContent.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: thisRange)
        mainAttributedString.append(attrContent)

        mainAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle,
                                          range: NSRange.init(location: 0, length: mainAttributedString.length))

        return mainAttributedString
    }
}
