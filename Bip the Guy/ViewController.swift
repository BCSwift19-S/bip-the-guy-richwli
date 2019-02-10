//
//  ViewController.swift
//  Bip the Guy
//
//  Created by BC Swift Student Loan 1 on 2/3/19.
//  Copyright © 2019 Richard Li. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var imageToPunch: UIImageView!
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageToPunch.isUserInteractionEnabled = true
    }

    func animateImage(){
        let bounds = self.imageToPunch.bounds
        let decreaseBySize: CGFloat = 60
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + decreaseBySize, y: self.imageToPunch.bounds.origin.y+decreaseBySize, width:self.imageToPunch.bounds.size.width-decreaseBySize, height: self.imageToPunch.bounds.size.height-decreaseBySize)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10, options: [],
                       animations: {self.imageToPunch.bounds = bounds}, completion: nil)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }else{
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        if let sound = NSDataAsset(name: soundName) {
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()

            } catch {
                print("ERROR: data in \(soundName) couldn't be played as a sound. ")
            }
        } else {
            print ("ERROR: file \(soundName) didn't load.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageToPunch.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: "Camera Not Available",message: "There is no camera available on this device",preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController,animated: true, completion: nil)
    }
}
