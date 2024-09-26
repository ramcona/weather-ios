//
//  ItemTableViewCell.swift
//  TestCase
//
//  Created by Rafli on 26/09/24.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    public func setData(data: WeatherResponse) {
        if let main = data.main {
            labelTemp.text = main.temp.kelvinToCelsiusString()
        }else {
            labelTemp.text = "0"
        }
        
        if !data.weather.isEmpty {
            if let weather = data.weather.first {
                let imageUrl = "https://openweathermap.org/img/wn/\(weather.icon)@2x.png"
                imageViewWeather.loadImage(fromURLString: imageUrl)
            }
        }
        
        labelDate.text = data.dt_txt.formatDate(from: "yyyy-MM-dd HH:mm:ss", to: "EEEE, dd MMM yyyy")
    }
    
}
