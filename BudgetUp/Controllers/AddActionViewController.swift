//
//  AddActionViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/9/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

protocol AddActionDelegate {
  func addedAction(_ action: Action?)
}

class AddActionViewController: UIViewController {
  
  var addActionDelegate: AddActionDelegate?
  
  let standaloneNavigationItem: UINavigationItem = {
    let navigationItem = UINavigationItem()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
    navigationItem.leftBarButtonItem?.tintColor = Color.negation.value
    navigationItem.title = "New Action"
    
    return navigationItem
  }()
  
  lazy var navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    
    navigationBar.isTranslucent = false
    navigationBar.delegate = self
    navigationBar.backgroundColor = .white
    navigationBar.items = [standaloneNavigationItem]
    
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    
    return navigationBar
  }()
  
  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    
    datePicker.datePickerMode = .date
    
    return datePicker
  }()
  
  lazy var categoryPicker: UIPickerView = {
    let picker = UIPickerView()
    
    picker.delegate = self
    picker.dataSource = self
    
    return picker
  }()
  
  let addActivityView = AddActionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Color.lightBackground.value
    
    view.addSubview(navigationBar)
    view.addSubview(addActivityView)
    
    addActivityView.detailsTextView.delegate = self
    addActivityView.titleTextField.delegate = self
    addActivityView.categoryField.addTarget(self, action: #selector(beganEditingCategory(_:)), for: .editingDidBegin)
    addActivityView.dateField.addTarget(self, action: #selector(beganEditingDate(_:)), for: .editingDidBegin)
    
    datePicker.addTarget(self, action: #selector(selectedDate(_:)), for: .valueChanged)
    
    addActivityView.dateField.inputView = datePicker
    addActivityView.categoryField.inputView = categoryPicker
    
    dismissKeyboardOnTap()
  }
  
  @objc private func cancelButtonPressed() {
    self.addActionDelegate?.addedAction(nil)
    dismissKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func selectedDate(_ datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    addActivityView.dateField.text = dateFormatter.string(from: datePicker.date)
  }
  
  @objc private func beganEditingCategory(_ textField: UITextField) {
    textField.text = ActionCategory.allCases[0].rawValue
  }
  
  @objc private func beganEditingDate(_ textField: UITextField) {
    textField.text = textField.placeholder
  }
  
  override func viewDidAppear(_ animated: Bool) {
    addActivityView.titleTextField.becomeFirstResponder()
  }
  
  override func viewWillLayoutSubviews() {
    setupLayout()
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
      navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
      navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
      ])
    
    NSLayoutConstraint.activate([
      addActivityView.leftAnchor.constraint(equalTo: view.leftAnchor),
      addActivityView.rightAnchor.constraint(equalTo: view.rightAnchor),
      addActivityView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
      ])
  }
  
}

extension AddActionViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ActionCategory.allCases[row].rawValue
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    addActivityView.categoryField.text = ActionCategory.allCases[row].rawValue
  }
}

extension AddActionViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ActionCategory.allCases.count
  }
}

extension AddActionViewController: UINavigationBarDelegate {
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}

extension AddActionViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension AddActionViewController: UITextViewDelegate {
  // This code allows a textView to have "placeholder" text in it by faking it
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    // Combine the text view text and the replacement text to
    // create the updated text string
    let currentText: String = textView.text
    let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
    
    // If the updated text view will be empty, add the placeholder
    // and set the cursor to the beginning of the text view
    if updatedText.isEmpty {
      textView.text = "Any details?"
      textView.textColor = Color.lightText.value
      
      textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    }
    
    // Else if the view's placeholder is showing and the
    // length of the replacement string is greater than 0, set
    // the text color to dark color and set it's text to the
    // replacement string
    else if textView.textColor == Color.lightText.value && !text.isEmpty {
      textView.textColor = Color.darkText.value
      textView.text = text
    }
    
    // For every other case, the text should change with the usual
    // behavior...
    else {
      return true
    }
    
    // ...otherwise return false since the updates have already
    // been made
    return false
  }
  
  // Don't allow the user to move the cursor when the placeholder
  // text is displaying
  func textViewDidChangeSelection(_ textView: UITextView) {
    moveCursorToBeginningOfTextView(textView)
  }
  
  // Place cursor at beginning when begin editing
  func textViewDidBeginEditing(_ textView: UITextView) {
    moveCursorToBeginningOfTextView(textView)
  }
  
  // Moves cursor to the beginning of the text view
  func moveCursorToBeginningOfTextView(_ textView: UITextView) {
    if self.view.window != nil {
      if textView.textColor == Color.lightText.value {
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
      }
    }
  }
}

// Calling dismissKeyboardOnTap in ViewDidLoad of a ViewController will allow the user to tap outside of the keyboard to dismiss it
extension UIViewController {
  func dismissKeyboardOnTap() {
    let tapToDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapToDismissKeyboard.cancelsTouchesInView = false
    view.addGestureRecognizer(tapToDismissKeyboard)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
