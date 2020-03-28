//
//  MemoryViewController.swift
//  Memorize
//
//  Created by Ashutosh Dave on 15/03/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
	@IBOutlet weak var textView: UITextView!
	var item: MemoryItem!
	
	var blankCounter = 0
	
	let visibleText: [NSAttributedString.Key: Any] = [
		.font: UIFont(name: "Georgia", size: 28)!,
		.foregroundColor: UIColor.black
	]
	
	let invisibleText: [NSAttributedString.Key: Any] = [
		.font: UIFont(name: "Georgia", size: 28)!,
		.foregroundColor: UIColor.clear,
		.strikethroughStyle: 1,
		.strikethroughColor: UIColor.black
	]
	override func viewDidLoad() {
        super.viewDidLoad()

		assert(item != nil, "You must provide a memory item before trying to show this view controller. ")
		
		textView.attributedText = showText(for: item)
		
		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
		textView.addGestureRecognizer(tapRecognizer)
    }
	
	func showText(for memoryItem: MemoryItem) -> NSAttributedString {
		let words = memoryItem.text.components(separatedBy: " ")
		let output = NSMutableAttributedString()
		
		let space = NSAttributedString(string: " ", attributes: visibleText)
		
		for (index, word) in words.enumerated() {
			if index < blankCounter {
				let attributedWord = NSAttributedString(string: word, attributes: visibleText)
				output.append(attributedWord)
			} else {
				var strippedWord = word
				var punctutation: String?
				
				if ".,".contains(word.last!) {
					punctutation = String(strippedWord.removeLast())
				}
				
				let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
				output.append(attributedWord)
				
				if let symbol = punctutation {
					let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
					output.append(attributedPunctuation)
				}
			}
			
			output.append(space)
		}
		
		return output
	}

	@objc func wordsTapped() {
		blankCounter += 1
		textView.attributedText = showText(for: item)
	}
}
