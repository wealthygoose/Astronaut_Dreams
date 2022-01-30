//
//  newentry.swift
//  Astronaut
//
//  Created by Administrator on 29/09/2018.
//  Copyright © 2018 Incentro. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import SwiftMessages


class newentry: UIViewController, UITextViewDelegate {
    
    
    //UI Elements
    @IBOutlet weak var date_label: UIButton!
    @IBOutlet weak var new_dream_entry: UITextView!
    @IBOutlet weak var select_label: UIButton!
    @IBOutlet weak var submit_button_outlet: UIButton!
    
    
    //Variables
    var tagplat = UIScrollView()
    var newtag = UITextField()
    var submitnewtag = UIButton()
    var closebutton = UIButton()
    var background = UIImageView()
    var selectedtag = ""
    var tagnames = [String]()

    //3
    
    //Submit button function
    @IBAction func submit_dream_entry(_ sender: Any) {

        //Dream Date
        var dayComp = DateComponents()
        dayComp.day = 0
        let dateday = Calendar.current.date(byAdding: dayComp, to: Date())!
        let formatterday = DateFormatter()
        formatterday.dateStyle = DateFormatter.Style.full
        let dateStringday = formatterday.string(from: dateday)
        
        //Dream Time
        let datet = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: datet)
        let minutes = calendar.component(.minute, from: datet)
        let seconds = calendar.component(.second, from: datet)
        let mill = calendar.component(.nanosecond, from: datet)
        let time = String(hour) + String(minutes)
        
        
        //Get dream text
        let dream_string = new_dream_entry.text!
        let tag_details = selectedtag
        let dream_details = dream_string+"xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx"+tag_details+"xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx"+time+"xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx"+dateStringday
        
        if dream_string != "  What was your dream about?" && dream_string != nil {
            
        
        print("dream_details")
        print(dream_details)
            
        //Get dream list string from 'userdefaults'. Alternative is using Core Data
            let dreamlist_string = UserDefaults.standard.string(forKey: "dreamlist")!
        print("dreamlist_string")
        print(dreamlist_string)
        //Make dream array from string
        var dream_list_array =  dreamlist_string.components(separatedBy: "----------incentro----------")
        print("dream_list_array")
        print(dream_list_array)
        
        //Append new dream text to array
        dream_list_array.append(dream_details)
        
        print("dream_list_array2")
        print(dream_list_array)
            dream_list_array = dream_list_array.filter { $0 != "" }
            dream_list_array = dream_list_array.filter { $0 != "nil" }

        //Make new dreams string with dream dream details included
        let finalstring = dream_list_array.joined(separator: "------incentro----------")
        //Save dream string to user defaults*
        
        print("finalstring")
        print(finalstring)
        
        
        UserDefaults.standard.set(finalstring, forKey: "dreamlist")
        
        
        let view = MessageView.viewFromNib(layout: .statusLine)
        
        // Theme message elements with the warning style.
        view.configureTheme(.success)
        
        
        // Add a drop shadow.
        view.configureDropShadow()
        view.button?.isHidden = true
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["📡"].sm_random()!
        let str = "You have successfully saved your dream details"
        view.configureContent(title: "", body: str, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "!", buttonTapHandler: nil )
        
        view.bodyLabel?.numberOfLines = 1
        view.bodyLabel?.adjustsFontSizeToFitWidth = true
        view.button?.isHidden = true
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        
        view.preferredHeight = CGFloat(300.00)
        
        // Show the message.
        SwiftMessages.show(view: view)
        

        } else {
            
            let view = MessageView.viewFromNib(layout: .statusLine)
            
            // Theme message elements with the warning style.
            view.configureTheme(.info)
            
            
            // Add a drop shadow.
            view.configureDropShadow()
            view.button?.isHidden = true
            
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            let iconText = ["📡"].sm_random()!
            let str = "Please describe your dream"
            view.configureContent(title: "", body: str, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "!", buttonTapHandler: nil )
            
            view.bodyLabel?.numberOfLines = 1
            view.bodyLabel?.adjustsFontSizeToFitWidth = true
            view.button?.isHidden = true
            
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            
            view.preferredHeight = CGFloat(300.00)
            
            // Show the message.
            SwiftMessages.show(view: view)
            
        }
        
    }
    
   // The function below is resposnible for showing the 'add new tag' elements
    @objc func shownewtagelements(_ sender: Any) {
        
        
    
        background.isHidden = false
        self.view.bringSubview(toFront: background)
        submitnewtag.isHidden = false
        self.view.bringSubview(toFront: submitnewtag)
        closebutton.isHidden = false
        self.view.bringSubview(toFront: closebutton)
        tagplat.isHidden = false
        self.view.bringSubview(toFront: tagplat)
        newtag.isHidden = false
        self.view.bringSubview(toFront: newtag)
    
    }
    
    // The function below is resposnible for hiding the 'add new tag' elements
    @objc func hidenewtagelements(_ sender: Any) {
        
        
        print("Hide")
        background.isHidden = true
        submitnewtag.isHidden = true
        closebutton.isHidden = true
        tagplat.isHidden = true
        newtag.isHidden = true
        
    }
    
    
    
    // The function below is resposnible for selecting a tag for a dream before final dream description submission
    @objc func select_tag(sender:UIButton!) {
        
        print("Select tag")
        selectedtag = sender.titleLabel!.text!
        
        // 'Add new tag' UI element being hidden afetr user select a tag
        background.isHidden = true
        submitnewtag.isHidden = true
        closebutton.isHidden = true
        tagplat.isHidden = true
        newtag.isHidden = true
        
        //Change to some UI element. Changes will indicate that the dream description is ready for saving / submission
        
        select_label.setFAText(prefixText: "", icon: FAType.FACheck, postfixText: "       Tag: " + selectedtag, size: 15, forState: .normal)
        submit_button_outlet.setFAText(prefixText: "", icon: FAType.FAPlus, postfixText: "       Add dream", size: 15, forState: .normal)
        submit_button_outlet.backgroundColor = orange
        submit_button_outlet.isUserInteractionEnabled = true
        submit_button_outlet.setFATitleColor(color: UIColor.white, forState: .normal)
        
    }
    
    //The function below is resposible for deleting tags
    @objc func delete_tag(sender:UIButton!) {
        
         //Make dream array from string
        let taglist_string = UserDefaults.standard.string(forKey: "taglist")!
        var tag_list_array =  taglist_string.components(separatedBy: "------incentro----------")
        tag_list_array = tag_list_array.filter { $0 != "" }
        tag_list_array = tag_list_array.filter { $0 != "nil" }
        tagnames.remove(at: sender.tag)
        
        //Make new dreams string with dream dream details included
        let finalstring = tagnames.joined(separator: "------incentro----------")
        
        //Save new tag string to user defaults and refresh the tag scrollview
        UserDefaults.standard.set(finalstring, forKey: "taglist")
        refreshtaglist()
        
    }
    
    //This a test for commit
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.shared.statusBarStyle = .lightContent
        

        //Dream Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let result = formatter.string(from: date)
        
        let dateday = Date()
        let formatterday = DateFormatter()
        formatterday.dateStyle = DateFormatter.Style.full
        let dateStringday = formatterday.string(from: dateday)
 
        
        //UI eements initilization
        
        date_label.setFAText(prefixText: "", icon: FAType.FACalendar, postfixText: "   Date:    " + dateStringday, size: 14, forState: .normal)
        date_label.setFATitleColor(color: UIColor.white)
        
        new_dream_entry.layer.cornerRadius = 5
        new_dream_entry.layer.masksToBounds = true
        new_dream_entry.layer.borderWidth = 0.5
        new_dream_entry.layer.borderColor =  UIColor.gray.cgColor
        new_dream_entry.text = "  What was your dream about?"
        new_dream_entry.textColor = UIColor.lightGray
        new_dream_entry.delegate = self
        
        select_label.setFAText(prefixText: "", icon: FAType.FATag, postfixText: "       Select tag", size: 16, forState: .normal)
        select_label.setFATitleColor(color: UIColor.white)
        select_label.layer.cornerRadius = 5
        select_label.layer.masksToBounds = true
        select_label.layer.borderWidth = 0
        select_label.addTarget(self, action: #selector(self.shownewtagelements(_:)), for: UIControlEvents.touchDown)
        select_label.layer.borderColor =  UIColor.lightGray.cgColor
        select_label.backgroundColor = UIColor(rgb: 0xE88703)
        
        
        submit_button_outlet.setFAText(prefixText: "", icon: FAType.FALock, postfixText: "       Add dream", size: 16, forState: .normal)
        submit_button_outlet.setFATitleColor(color: UIColor.lightGray)
        submit_button_outlet.layer.cornerRadius = 5
        submit_button_outlet.layer.masksToBounds = true
        submit_button_outlet.layer.borderWidth = 0
        submit_button_outlet.isUserInteractionEnabled = false
        submit_button_outlet.layer.borderColor =  UIColor.lightGray.cgColor
        submit_button_outlet.backgroundColor = UIColor.darkGray
        
        
        tagplat = UIScrollView(frame : CGRect (x: 20, y: 125, width: Int(self.view.frame.width) - 40, height: Int(self.view.frame.height) - 185))
        tagplat.isHidden = true
        tagplat.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        tagplat.layer.borderColor = UIColor.gray.cgColor
        tagplat.layer.borderWidth = 0.5
        tagplat.layer.cornerRadius = 3
        self.view.addSubview(tagplat)

        
        newtag = UITextField(frame : CGRect (x: 20, y: 70, width: self.view.frame.width - 120, height:  50))
        newtag.isHidden = true
        newtag.placeholder = "    Enter new tag .."
        newtag.textColor = UIColor.white
        newtag.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        newtag.layer.borderColor = UIColor.lightGray.cgColor
        newtag.layer.borderWidth = 0
        newtag.layer.cornerRadius = 3
        newtag.textAlignment = .center
        newtag.keyboardAppearance = .dark
        newtag.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.view.addSubview(newtag)

        
        submitnewtag = UIButton(frame : CGRect (x: (self.view.frame.width - 100), y: 70, width: (self.view.frame.width) - (self.view.frame.width - 80), height:  50))
        submitnewtag.isHidden = true
        submitnewtag.setFAText(prefixText: "", icon: FAType.FAPlus, postfixText: "  Add tag", size: 12, forState: .normal)
        submitnewtag.setFATitleColor(color: UIColor.white)
        submitnewtag.backgroundColor = UIColor(rgb: 0xE88703)
        submitnewtag.layer.borderColor = UIColor.lightGray.cgColor
        submitnewtag.layer.borderWidth = 0
        submitnewtag.layer.cornerRadius = 3
        submitnewtag.addTarget(self, action: #selector(self.addnewtag(_:)), for: UIControlEvents.touchDown)
        submitnewtag.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.view.addSubview(submitnewtag)
        
        
        closebutton = UIButton(frame : CGRect (x: (self.view.frame.width - 100), y: 30, width: (self.view.frame.width) - (self.view.frame.width - 80), height:  30))
        closebutton.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "  Close", size: 12, forState: .normal)
        closebutton.setFATitleColor(color: UIColor.white)
        closebutton.isHidden = true
        closebutton.backgroundColor = UIColor(rgb: 0xE88703)
        closebutton.layer.borderColor = UIColor.lightGray.cgColor
        closebutton.layer.borderWidth = 0
        closebutton.layer.cornerRadius = 3
        closebutton.addTarget(self, action: #selector(self.hidenewtagelements(_:)), for: UIControlEvents.touchDown)
        self.view.addSubview(closebutton)
        
        
        background = UIImageView(frame : CGRect (x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height))
        background.isHidden = true
        background.alpha =  0.7
        background.backgroundColor = UIColor.black
        self.view.addSubview(background)
        
      
        refreshtaglist()
        
    }
    
    
    //The function below is responsible for clearing the placeholder of the dream description textview
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    //The function below is responsible for adding a placeholder of the dream description textview
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "  What was your dream about?"
            textView.textColor = UIColor.lightGray
        }
    }
    

    //The function beleow is resposnible for populating the tags scrollview
    func refreshtaglist() {

        //Clear tag scrollview
        for subview in tagplat.subviews {
            if subview is UIView {
                subview.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }

        //Make dream array from string

        let taglist_string = UserDefaults.standard.string(forKey: "taglist")!
        var tag_list_array =  taglist_string.components(separatedBy: "------incentro----------")
        
        //Array cleansing
        tag_list_array = tag_list_array.filter { $0 != "" }
        tag_list_array = tag_list_array.filter { $0 != "nil" }
        
        var yaxis = 10

        // If statemnts check if tags array is empty
        if tag_list_array.count == 0 {
            
            
            let tag = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(tagplat.frame.width) - 20, height:60))
            tag.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       There are no tags" + selectedtag, size: 15, forState: .normal)
            tag.setFATitleColor(color: UIColor.white, forState: .normal)
            tag.layer.masksToBounds = true
            tag.layer.borderWidth = 0.5
            tag.layer.borderColor =  UIColor.darkGray.cgColor
            tag.layer.cornerRadius = 4
            tag.backgroundColor = UIColor.gray
            tagplat.addSubview(tag)

        }
        
        tagnames.removeAll()
        
        
        //Populating tag scrollview
        for (index, element) in tag_list_array.enumerated(){
            
            let tag = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(tagplat.frame.width) - 20, height:60))
            tag.setTitle(element, for: .normal)
            tag.setFATitleColor(color: UIColor.white, forState: .normal)
            tag.layer.masksToBounds = true
            tag.layer.borderWidth = 0.5
            tag.layer.borderColor =  UIColor.lightGray.cgColor
            tag.layer.cornerRadius = 4
            tag.backgroundColor = orange.withAlphaComponent(0.6)
            tag.addTarget(self, action: #selector(self.select_tag(sender:)), for: UIControlEvents.touchDown)
            tagplat.addSubview(tag)
           
            tagnames.append(element)
            
            let deletetag = UIButton(frame : CGRect (x: Int(tagplat.frame.size.width) - 60, y: yaxis, width: 60, height:60))
            deletetag.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "", size: 14, forState: .normal)
            deletetag.setFATitleColor(color: UIColor.white, forState: .normal)
            deletetag.tag = index
            deletetag.addTarget(self, action: #selector(self.delete_tag(sender:)), for: UIControlEvents.touchDown)
            tagplat.addSubview(deletetag)
           
            yaxis = yaxis + 80
            
             tagplat.contentSize = CGSize(width: Int(tagplat.frame.size.width), height: yaxis)
        }
       
        
        
    }
    
    
    //The function below is resposible for adding new tags
    @objc func addnewtag(_ sender: Any)  {
        
        print("Adding new tag")
        print(newtag.text!)
        print("Adding new tag")

        let tag_details = newtag.text!
        
        if tag_details != "" && tag_details != nil {
            

            //Make dream array from string

            let taglist_string =  UserDefaults.standard.string(forKey: "taglist")!
            var tag_list_array =  taglist_string.components(separatedBy: "------incentro----------")
            
            //Append new dream text to array
            tag_list_array.append(tag_details)
            tag_list_array = tag_list_array.filter { $0 != "" }
            
            //Make new dreams string with dream dream details included
            let finalstring = tag_list_array.joined(separator: "------incentro----------")
            
            //Save dream string to user defaults
            UserDefaults.standard.set(finalstring, forKey: "taglist")
            
            let view = MessageView.viewFromNib(layout: .statusLine)
            
            // Theme message elements with the warning style.
            view.configureTheme(.success)
            
            // Add a drop shadow.
            view.configureDropShadow()
            view.button?.isHidden = true
            
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            let iconText = ["📡"].sm_random()!
            let str = "You have successfully added a new tag"
            view.configureContent(title: "", body: str, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "!", buttonTapHandler: nil )
            
            view.bodyLabel?.numberOfLines = 1
            view.bodyLabel?.adjustsFontSizeToFitWidth = true
            view.button?.isHidden = true
            
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            
            view.preferredHeight = CGFloat(300.00)
            
            // Show the message.
            SwiftMessages.show(view: view)
            
            refreshtaglist()
            
        } else {
            
            
            let view = MessageView.viewFromNib(layout: .statusLine)
            
            // Theme message elements with the warning style.
            view.configureTheme(.info)
            
            
            // Add a drop shadow.
            view.configureDropShadow()
            view.button?.isHidden = true
            
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            let iconText = ["📡"].sm_random()!
            let str = "Please enter a new tag"
            view.configureContent(title: "", body: str, iconImage: nil, iconText: iconText, buttonImage: nil, buttonTitle: "!", buttonTapHandler: nil )
            
            view.bodyLabel?.numberOfLines = 1
            view.bodyLabel?.adjustsFontSizeToFitWidth = true
            view.button?.isHidden = true
            
            // Set message title, body, and icon. Here, we're overriding the default warning
            // image with an emoji character.
            
            view.preferredHeight = CGFloat(300.00)
            
            // Show the message.
            SwiftMessages.show(view: view)
            
            
            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
