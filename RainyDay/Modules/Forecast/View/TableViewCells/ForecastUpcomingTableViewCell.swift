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
    
    
    //MARK: - Lifecycle
    func configureWithModel(model: WeatherForecastModel?) {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        selectionStyle = .none
    }

}
