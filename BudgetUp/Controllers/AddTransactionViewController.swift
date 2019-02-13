//
//  AddTransactionViewController.swift
//  BudgetUp
//
//  Created by Alex Fargo on 2/9/19.
//  Copyright © 2019 Alex Fargo. All rights reserved.
//

import UIKit

protocol AddTransactionDelegate {
  func addedTransaction(_ transaction: Transaction?)
}

class AddTransactionViewController: UIViewController {
  
  var delegate: AddTransactionDelegate?
  
  let addActivityView = AddTransactionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Color.lightBackground.value
    
    view.addSubview(addActivityView)
    
    addActivityView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    addActivityView.detailsTextView.delegate = self
    
    dismissKeyboardOnTap()
  }
  
  @objc private func cancelButtonPressed() {
    self.delegate?.addedTransaction(nil)
    dismissKeyboard()
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    addActivityView.titleTextField.becomeFirstResponder()
  }
  
  override func viewWillLayoutSubviews() {
    setupLayout()
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      addActivityView.leftAnchor.constraint(equalTo: view.leftAnchor),
      addActivityView.rightAnchor.constraint(equalTo: view.rightAnchor),
      addActivityView.topAnchor.constraint(equalTo: view.topAnchor)
      ])
  }
  
}

extension AddTransactionViewController: UITextViewDelegate {
  // This code allows a textView to have "placeholder" text in it by faking it
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    // Combine the text view text and the replacement text to
    // create the updated text string
    let currentText: String = textView.text
    let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
    
    // If the updated text view will be empty, add the placeholder
    // and set the cursor to the beginning of the text view
    if updatedText.isEmpty {
      textView.text = "Details"
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
