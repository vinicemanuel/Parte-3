//
//  MasterTableViewController.swift
//  Parte-3
//
//  Created by Vinicius Emanuel on 27/03/21.
//

import UIKit

protocol SnippetSelectionDelegate: AnyObject {
    func snippetSelected(_ newSnippet: Snippet)
}

class MasterTableViewController: UITableViewController {
    
    weak var delegateTag: SnippetSelectionDelegate?
    
    var snippets: [Snippet] = [
        Snippet(name: "Snippet 1", content: "let x = 10", tags: ["tag 1", "tag 2", "tag 3"]),
        Snippet(name: "Snippet 2", content: "let y = true", tags: ["tag 4", "tag 5", "tag 6"]),
        Snippet(name: "Snippet 3", content: "let z = \"abc\"",tags: ["tag 7", "tag 8", "tag 9"]),
        Snippet(name: "Snippet python", content: "and or let defer", tags: ["tag 10"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addSnippet(_ sender: Any) {
        let number = self.snippets.count + 1
        self.snippets.append(Snippet(name: "Snippet \(number)", content: "print(\" hello from snippets \(number) \")"))
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: self.snippets.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.snippets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.snippets[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = snippets[indexPath.row]
        delegateTag?.snippetSelected(selectedSnippet)
        
        if let tagViewController = delegateTag as? TagViewController {
            splitViewController?.show(tagViewController, sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
