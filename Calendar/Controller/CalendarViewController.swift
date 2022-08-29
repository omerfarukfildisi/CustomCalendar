//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Ömer Fildişi on 23.08.2022.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    var selectedDate = Date()
    let todayDate = Date()
    var calenderDays = [CalenderDay]()
    private var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView(){
        setCellView()
        setCalendarView()
        scrollView.delegate = self
    }

    func setCalendarView(){
        calenderDays.removeAll()
        calenderDays = CalendarHelper().setCalendarDays(date: selectedDate)
        monthLabel.text = "\(CalendarHelper().monthString(date: selectedDate))\(",") \(CalendarHelper().yearString(date: selectedDate))"
        collectionView.reloadData()
    }
    

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            if self.lastContentOffset > scrollView.contentOffset.x {
                // move left
                selectedDate = CalendarHelper().minusMonth(date: selectedDate)
                setCalendarView()
            } else {
                // move right
                selectedDate = CalendarHelper().plusMonth(date: selectedDate)
                setCalendarView()
            }
        }
    }
    
    func setCellView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellParticipantCollectionNib = UINib(nibName: "CalendarCollectionViewCell", bundle: nil)
        collectionView.register(cellParticipantCollectionNib, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
    }
    
    
}


extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40) / 7
        let height: CGFloat = (collectionView.frame.height) / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calenderDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as! CalendarCollectionViewCell
        cell.backgroundColor = .none
        cell.configure(calenderDays[indexPath.item])
        return cell
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CalendarHelper.shared.selectedDate = calenderDays[indexPath.item].date ?? ""
        setCalendarView()
        selectedDateLabel.text = calenderDays[indexPath.item].date
    }
}

