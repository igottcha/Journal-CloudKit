//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Chris Gottfredson on 3/30/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - Outlets and Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    var entry: Entry? {
        didSet
        {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard (entry == nil), let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else { return }
        EntryController.shared.createEntry(title: title, body: body) { (results) in
            DispatchQueue.main.async {
                switch results {
                case .success(_):
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    //MARK: - Other Methods
    
    func updateViews() {
        guard let entry = entry else { return }
        self.titleTextField.text = entry.title
        self.bodyTextView.text = entry.body
    }
}

extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
