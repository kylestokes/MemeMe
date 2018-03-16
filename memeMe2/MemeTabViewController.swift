//
//  MemeTabViewController.swift
//  memeMe2
//
//  Created by Kyle Stokes on 3/12/18.
//  Copyright © 2018 Kyle Stokes. All rights reserved.
//

import UIKit

class MemeTabViewController: UIViewController {

    var memes = [Meme]()
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Get memes from AppDelegate non-persistant storage
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        
        tableView?.reloadData()
        collectionView?.reloadData()
    }
    
    @objc func addMeme() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.present(viewController, animated: true, completion: nil)
    }
}
