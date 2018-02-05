//
//  ViewController.swift
//  SlotMachine
//  Copyright © 2018年 Centennial College. All rights reserved.
//

import UIKit
import AVFoundation
//extension function convert emoji to string
extension String {
    func emojiToImage() -> UIImage? {
        let size = CGSize(width: 30, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: CGPoint(), size: size)
        UIRectFill(CGRect(origin: CGPoint(), size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var winMoney: UILabel!
    @IBOutlet weak var ownMoney: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    var imageArray:[UIImage]!
    var audioPlayer:AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        playBgMusic()
        imageArray = ["🍎".emojiToImage()!,
                      "😍".emojiToImage()!,
                      "🐮".emojiToImage()!,
                      "🐼".emojiToImage()!,
                      "🐔".emojiToImage()!,
                      "🎅".emojiToImage()!,
                      "🚍".emojiToImage()!,
                      "💖".emojiToImage()!,
                      "👑".emojiToImage()!,
                      "👻".emojiToImage()!]

        resultLabel.text = ""
        winMoney.text = "0"
        ownMoney.text = "5000"
      
        arc4random_stir()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    //Spin function pickview rolls
    @IBAction func buttonClicked(_ sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        var winnedMoney = Int(winMoney.text!)!
        var ownnedMoney = Int(ownMoney.text!)!
        if ownnedMoney>0{
        for i in 0..<5{
            let newValue = Int(arc4random_uniform(UInt32(imageArray.count)))
            if newValue == lastVal{
            numInRow += 1
        }else {
            numInRow = 1
        }
        lastVal = newValue
        
            pickerView.selectRow(newValue, inComponent: i, animated: true)
            pickerView.reloadComponent(i)
            ownnedMoney = ownnedMoney - 40
            ownMoney.text = String(ownnedMoney)
            if numInRow >= 3{
                winnedMoney = winnedMoney + 1000
                ownnedMoney = ownnedMoney + 1000
                winMoney.text = String(winnedMoney)
                ownMoney.text = String(ownnedMoney)
                win = true
            }
    }
        resultLabel.text = win ? "WINNER" : ""
        if ownnedMoney == 0{
            resultLabel.text = "You Lose!"
        }
    }
    }
    
    @IBAction func fillClicked(_ sender: UIButton) {
        
        var ownedMoney = Int(ownMoney.text!)!
        
        ownedMoney = ownedMoney + 200
        ownMoney.text = String(ownedMoney)
    }
    
    // returns the number of 'columns' to display.
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return	5
    }
    
    
    // returns the # of rows in each component..
    @available(iOS 2.0, *)
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return imageArray.count
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 32
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let image = imageArray[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    func playBgMusic(){
        
        let musicPath = Bundle.main.path(forResource: "bm", ofType: "mp3")
        
        //Music Path
        
        let url = NSURL(fileURLWithPath: musicPath!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url as URL)
        } catch {
            print("Player not available")
        }
          
        
        audioPlayer.numberOfLoops = -1
        
        audioPlayer.volume = 1
        
        audioPlayer.prepareToPlay()
        
        audioPlayer.play()
        
    }

    

    


}

