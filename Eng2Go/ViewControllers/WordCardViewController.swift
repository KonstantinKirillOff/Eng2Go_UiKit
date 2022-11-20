//
//  ViewController.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import UIKit

class WordCardViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var engWordTextField: UITextField!
    @IBOutlet weak var rusWordTextField: UITextField!
    
    var word: Word!
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engWordTextField.delegate = self
        engWordTextField.text = word.engName
        rusWordTextField.text = word.rusName
        getNewImage()
    }
}


extension WordCardViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == engWordTextField {
            getNewImage()
        }
    }
    
    func showErrorAlert(tithText content: String) {
        let alert = UIAlertController(title: "Request error", message: content, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
    }
    
    func getNewImage() {
        if let engWord = engWordTextField.text, engWordTextField.text != "" {
            networkManager.fetchURLUnslashImage(for: engWord) { result in
                switch result {
                case .success(let url):
                    DispatchQueue.global().async {
                        guard let url = URL(string: url) else { return }
                        guard let imageData = try? Data(contentsOf: url) else {
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(systemName: "pc")
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: imageData)
                        }
                    }
                case .failure(let error):
                    switch error {
                    case .badURL:
                        self.showErrorAlert(tithText: "bad URL")
                    case .badData:
                        self.showErrorAlert(tithText: "bad data")
                    case .decodeError:
                        self.showErrorAlert(tithText: "decode error")
                    }
                }
            }
        }
    }
}

