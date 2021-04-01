//
//  TagViewController.swift
//  Parte-3
//
//  Created by Vinicius Emanuel on 31/03/21.
//

import UIKit

class TagViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var snippet: Snippet? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
    
}

extension TagViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.snippet?.tags[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.snippet?.tags.count ?? 0
    }
}

extension TagViewController: SnippetSelectionDelegate {
    func snippetSelected(_ newSnippet: Snippet) {
        snippet = newSnippet
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
