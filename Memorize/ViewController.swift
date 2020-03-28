//
//  ViewController.swift
//  Memorize
//
//  Created by Ashutosh Dave on 14/03/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	let dataSource = MemoryDataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = dataSource
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemoryViewController") as? MemoryViewController else {
			fatalError("Unable to instantiate memroy view controller.")
		}
		
		let item = dataSource.item(at: indexPath.row)
		
		vc.item = item
		
		navigationController?.pushViewController(vc, animated: true)
	}
}
