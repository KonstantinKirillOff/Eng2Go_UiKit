//
//  ViewController.swift
//  Eng2Go
//
//  Created by Konstantin Kirillov on 12.10.2022.
//

import UIKit

class WordDescriptionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var engWordTextField: UITextField!
    
    let networkManager = NetworkManager.shared

    @IBAction func searchButtonPressed() {
        
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

extension WordDescriptionViewController {
    func showErrorAlert(tithText content: String) {
        let alert = UIAlertController(title: "Request error", message: content, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
    }
    
}

