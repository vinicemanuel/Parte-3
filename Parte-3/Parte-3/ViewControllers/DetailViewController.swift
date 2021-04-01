//
//  DetailViewController.swift
//  Parte-3
//
//  Created by Vinicius Emanuel on 27/03/21.
//

import UIKit
import Sourceful

class DetailViewController: UIViewController {
    
    @IBOutlet weak var syntaxTextView: SyntaxTextView!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    var snippet: Snippet? {
        didSet {
            refreshUI()
        }
    }
    
    private var currentIsSwift = true
    
    var sourceCodeTheme: SourceCodeTheme {
        if UIApplication.activeTraitCollection.userInterfaceStyle == .dark {
            return DarkTheme()
        } else {
            return LightTheme()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        syntaxTextView.theme = sourceCodeTheme
        syntaxTextView.delegate = self
        
        syntaxTextView.contentTextView.inputAccessoryView = UIView.editingToolbar(target: self, action: #selector(insertCharacter))
    }
    
    @IBAction func selectlanguage(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Languate", message: "Select languate", preferredStyle: .actionSheet)
        let swiftTitle = self.currentIsSwift ? "Swift ✅" : "Swift"
        let pythonTitle = self.currentIsSwift ? "Python" : "Python ✅"
        
        let swiftButton = UIAlertAction(title: swiftTitle, style: .default) { (_) in
            self.currentIsSwift = true
            self.refreshUI()
        }
        
        let pythonButton = UIAlertAction(title: pythonTitle, style: .default) { (_) in
            self.currentIsSwift = false
            self.refreshUI()
        }
        
        alert.addAction(swiftButton)
        alert.addAction(pythonButton)
        
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.barButtonItem = self.rightButton
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /// Called when the user taps a key symbol in our input accessory view.
    @objc func insertCharacter(_ sender: UIBarButtonItem) {
        guard let value = UnicodeScalar(sender.tag) else { return }
        let string = String(value)
        syntaxTextView.insertText(string)
        UIDevice.current.playInputClick()
    }

    private func refreshUI() {
        loadViewIfNeeded()
        title = snippet?.name ?? "New Snippet"
        syntaxTextView.text = snippet?.content ?? ""
    }

}

extension DetailViewController: SyntaxTextViewDelegate {
    /// Send back our Swift lexer for this source code.
    func lexerForSource(_ source: String) -> Lexer {
        return self.currentIsSwift ? SwiftLexer() : Python3Lexer()
    }
}

extension DetailViewController: SnippetSelectionDelegate {
    func snippetSelected(_ newSnippet: Snippet) {
        snippet = newSnippet
    }
}
