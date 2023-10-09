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
        currentWeatherImageView.contentMode = .scaleAspectFill
//        weatherImageView.clipsToBounds = true
        currentWeatherImageView.backgroundColor = .red
        return currentWeatherImageView
    }()
    
    private let currentWeatherLabel: UILabel = {
        let currentWeather = UILabel()
        currentWeather.textAlignment = .center
        currentWeather.textColor = .white
        currentWeather.backgroundColor = .clear
        currentWeather.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        currentWeather.numberOfLines = 0
        currentWeather.translatesAutoresizingMaskIntoConstraints = false
        return currentWeather
    }()
    
    //MARK: - Lifecycle
    func configureWithModel(model: WeatherForecastModel?) {
        self.currentWeatherLabel.attributedText = self.attributedStringForTitle(title: model?.temp ?? "",
                                                                                subTitle: model?.mainWeather?.uppercased() ?? "")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(currentWeatherImageView)
        self.addSubview(currentWeatherLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = contentView.frame.size.width
        currentWeatherImageView.frame = CGRectMake((width / 2) - 20, 30, 40, 40)
        currentWeatherLabel.frame = CGRectMake(0, currentWeatherImageView.frame.size.height + 10, contentView.frame.size.width, 200)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
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
        attrHeading.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 70.0, weight: .semibold), range: range)
        attrHeading.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        mainAttributedString.append(attrHeading)

        let stringFormat = String(format: "\n\(subTitle)")
        attrContent = NSMutableAttributedString(string: stringFormat)
        let thisRange = NSRange.init(location: 0, length: stringFormat.count)
        attrContent.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 25.0, weight: .medium), range: thisRange)
        attrContent.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: thisRange)
        mainAttributedString.append(attrContent)

        mainAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle,
                                          range: NSRange.init(location: 0, length: mainAttributedString.length))

        return mainAttributedString
    }
}
