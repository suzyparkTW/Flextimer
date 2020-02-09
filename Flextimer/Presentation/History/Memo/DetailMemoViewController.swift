//
//  DetailMemoViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/08.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class DetailMemoViewController: BaseViewController {
  
  let textView = UITextView().then {
    $0.font = Font.REGULAR_16
    $0.textColor = Color.primaryText
    $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    $0.isScrollEnabled = true
  }

  lazy var doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.textView)
    self.textView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if self.textView.text.count == 0 {
      self.textView.becomeFirstResponder()
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.navigationItem.largeTitleDisplayMode = .never
    self.navigationItem.rightBarButtonItem = doneBarButton
  }
  
  override func bind() {
    super.bind()
    
    self.doneBarButton.rx.tap.subscribe(onNext: { [weak self] _ in
      self?.view.endEditing(true)
    }).disposed(by: self.disposeBag)
  }
  
  @objc func willShowKeyboard(_ notification: Notification) {
    self.setNavigationBarButtonItem(true)
    
    let userInfo = notification.userInfo!
    let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    self.textView.contentInset.bottom = keyboardRect.size.height
    self.textView.verticalScrollIndicatorInsets.bottom = keyboardRect.size.height
  }
  
  @objc func willHideKeyboard(_ notification: Notification) {
    self.setNavigationBarButtonItem(false)

    self.textView.contentInset.bottom = 16
    self.textView.verticalScrollIndicatorInsets.bottom = 16
  }
  
  func setNavigationBarButtonItem(_ isKeyboardShown: Bool) {
    let barButton: UIBarButtonItem? = isKeyboardShown ? self.doneBarButton: nil
    self.navigationItem.rightBarButtonItem = barButton
  }
}
