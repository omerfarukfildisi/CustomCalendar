//
//  CalendarCollectionViewCell.swift
//  Calendar
//
//  Created by Ömer Fildişi on 23.08.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerDay: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(_ sender: CalenderDay) {
        dayLabel.text = sender.date?.components(separatedBy: "-")[0]
        if sender.today == true {
            setDay(selectedDay: false, emptyDay: false, today: true, unSelectedToday: false)
        } else if sender.selectedDay == true {
            setDay(selectedDay: true, emptyDay: false, today: false, unSelectedToday: false)
        } else if sender.emptyDay == true{
            setDay(selectedDay: false, emptyDay: true, today: false, unSelectedToday: false)
        } else {
            setDay(selectedDay: false, emptyDay: true, today: false, unSelectedToday: false)
        }
    }
    
    func setDay(selectedDay: Bool, emptyDay: Bool, today: Bool, unSelectedToday:Bool) {
        if selectedDay {
            dayLabel.textColor = UIColor.hex("#FFFFFF")
            containerDay.backgroundColor = UIColor.hex("#F38554")
            containerDay.layer.shadowColor = UIColor.hex("#F38554").cgColor
            containerDay.layer.shadowOpacity = 0.2
        } else if emptyDay {
            dayLabel.textColor = UIColor.hex("#575F6B")
            containerDay.backgroundColor = .none
        } else if today {
            dayLabel.textColor = UIColor.hex("#FFFFFF")
            containerDay.backgroundColor = UIColor.hex("#68926D")
            containerDay.layer.shadowColor = UIColor.hex("#68926D").cgColor
            containerDay.layer.shadowOpacity = 0.5
        }
        containerDay.layer.cornerRadius = 6
        containerDay.layer.shadowRadius = 5
        containerDay.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}

