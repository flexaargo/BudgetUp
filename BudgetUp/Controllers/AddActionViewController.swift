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
  
  var action: Action!
  
  var addActionDelegate: AddActionDelegate?
  
  let standaloneNavigationItem: UINavigationItem = {
    let navigationItem = UINavigationItem()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
    navigationItem.leftBarButtonItem?.tintColor = Color.negation.value
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(confirmButtonPressed))
    navigationItem.rightBarButtonItem?.tintColor = Color.affirmation.value
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
  
  let addActionView = AddActionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    action = Action()
    
    view.backgroundColor = Color.lightBackground.value
    
    view.addSubview(navigationBar)
    view.addSubview(addActionView)
    
    addActionView.detailsTextView.delegate = self
    addActionView.titleTextField.delegate = self
    addActionView.categoryField.addTarget(self, action: #selector(beganEditingCategory(_:)), for: .editingDidBegin)
    addActionView.dateField.addTarget(self, action: #selector(beganEditingDate(_:)), for: .editingDidBegin)
    
    datePicker.addTarget(self, action: #selector(selectedDate(_:)), for: .valueChanged)
    
    addActionView.dateField.inputView = datePicker
    addActionView.categoryField.inputView = categoryPicker
    
    dismissKeyboardOnTap()
  }
  
  // TODO: THIS NEEDS REFACTORING
  @objc private func confirmButtonPressed() {
    action.title = addActionView.titleTextField.text!
    let details = addActionView.detailsTextView.text! == "Any details?" ? "" : addActionView.detailsTextView.text!
    action.details = details
    action.amount = addActionView.amountField.doubleValue
    
    if action.title.count == 0 {
      alertUser("You cannot create an activity with no title.")
      return
    }
    
    guard let category = ActionCategory(rawValue: addActionView.categoryField.text!) else { alertUser("You cannot create an activity with no category."); return }
    action.actionCategoryEnum = category
    
    if action.amount == 0 {
      alertUser("You cannot create an activity with no dollar amount.")
      return
    }
    
    if action.date == nil {
      alertUser("You must choose a date on which the activity occurred.")
      return
    }
    
    addActionDelegate?.addedAction(action)
    dismissKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  func alertUser(_ message: String) {
    let alert = UIAlertController(title: "Oops!\nSomething went wrong", message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    
    present(alert, animated: true, completion: nil)
  }
  
  @objc private func cancelButtonPressed() {
    self.addActionDelegate?.addedAction(nil)
    dismissKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func selectedDate(_ datePicker: UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    addActionView.dateField.text = dateFormatter.string(from: datePicker.date)
    
    action.date = NSDate(timeIntervalSince1970: datePicker.date.timeIntervalSince1970)
  }
  
  @objc private func beganEditingCategory(_ textField: UITextField) {
    textField.text = ActionCategory.allCases[0].rawValue
  }
  
  @objc private func beganEditingDate(_ textField: UITextField) {
    let today = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
    
    if textField.text!.isEmpty {
      textField.text = dateFormatter.string(from: today)
    }
    action.date = NSDate(timeIntervalSince1970: today.timeIntervalSince1970)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    addActionView.titleTextField.becomeFirstResponder()
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
      addActionView.leftAnchor.constraint(equalTo: view.leftAnchor),
      addActionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      addActionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
      ])
  }
  
}

extension AddActionViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ActionCategory.allCases[row].rawValue
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    addActionView.categoryField.text = ActionCategory.allCases[row].rawValue
    
    action.actionCategoryEnum = ActionCategory.allCases[row]
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
