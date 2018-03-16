//
//  DetailViewController.swift
//  memeMev1
//
//  Created by Kyle Stokes on 3/2/18.
//  Copyright © 2018 Kyle Stokes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMeme))
    }
    
    @objc func editMeme() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        viewController.meme = meme
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        memeImage.image = meme.memeImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
