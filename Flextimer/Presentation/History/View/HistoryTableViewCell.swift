//
//  HistoryTableViewCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryTableViewCell: BaseTableViewCell {
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.text = "1월 20일"
  }
  
  let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10;
  }

  let totalWorkhoursADayLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.textAlignment = .right
    $0.text = "3시간"
  }
  
  let disclosureIndicatorImageView = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.right")
    $0.tintColor = Color.separatorGray
    $0.contentMode = .scaleAspectFit
  }
  
  override func initial() {
    super.initial()
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.stackView)
    
    self.titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview()
    }
    
    self.stackView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-14)
      $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8)
    }
    
    self.disclosureIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 16, height: 16))
    }
    
    self.stackView.addArrangedSubview(self.totalWorkhoursADayLabel)
    self.stackView.addArrangedSubview(self.disclosureIndicatorImageView)
  }
  
  func updateCell(_ model: HistoryViewModel) {
    self.titleLabel.text = Formatter.dayName.string(from: model.date)
    self.totalWorkhoursADayLabel.text = (model.workRecord != nil) ? "record is exist": ""
  }
}
