//
//  ViewController.swift
//  imagePicker
//
//  Created by Kyle Stokes on 2/1/18.
//  Copyright © 2018 Kyle Stokes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var meme: Meme?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeTextFieldTop: UITextField!
    @IBOutlet weak var memeTextFieldBottom: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    let textFieldDelegate = TextFieldDelegate()
    
    let memeTextFieldAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -7.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Top
        configure(textField: memeTextFieldTop, withText: "TOP")
        // Bottom
        configure(textField: memeTextFieldBottom, withText: "BOTTOM")
        // Hide share until user picks image
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        // Meme is being edited
        if let meme = meme {
            imageView.image = meme.original
            memeTextFieldTop.text = meme.topString
            memeTextFieldBottom.text = meme.bottomString
            shareButton.isEnabled = true
        }
        
        // User changed font
        if let newFont = appDelegate.newFont {
            memeTextFieldTop.font = newFont
            memeTextFieldBottom.font = newFont
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Disable camera button if camera is not available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    @IBAction func launchCamera(_ sender: UIBarButtonItem) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        self.present(picker, animated: true, completion: nil)
    }
    
    func configure(textField: UITextField, withText: String) {
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextFieldAttributes
        textField.text = withText
        textField.textAlignment = .center
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Only move view if editing bottom textfield
        if self.memeTextFieldBottom.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func configureBars(hidden: Bool) {
        navBar.isHidden = hidden
        toolBar.isHidden = hidden
    }
    
    func generateMeme() -> UIImage {
        // Hide navbar and toolbar
        configureBars(hidden: true)
        
        // Render view to image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show navbar and toolbar
        configureBars(hidden: false)
        
        // Return image with textfields without toolbar and navbar
        return memedImage!
    }
    
    func save(meme: UIImage) {
        // Create meme object from Meme struct
        let savedMeme = Meme(topString: memeTextFieldTop.text!, bottomString: memeTextFieldBottom.text!, original: imageView.image!, memeImage: meme)
        // Save meme in shared model (AppDelegate)
        appDelegate.memes.append(savedMeme)
        // Show saved memes
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareMeme() {
        let memedImage = generateMeme()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        // Save meme before using activity controller
        activityController.completionWithItemsHandler = {
            (_,successful,_,_) in
            
            if successful {
                self.save(meme: memedImage)
            }
        }
        self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func chooseFont() {
        let fontViewController = storyboard?.instantiateViewController(withIdentifier: "FontViewController") as! FontViewController
        self.present(fontViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme() {
        dismiss(animated: true, completion: nil)
    }
}

