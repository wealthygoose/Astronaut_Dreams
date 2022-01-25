//
//  showdreams.swift
//  Astronaut
//
//  Created by Administrator on 29/09/2018.
//  Copyright © 2018 Incentro. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import SwiftMessages

//hello world

class showdreams: UIViewController {
    
    //Test pull, commit, push, pull
    //UIElements linked to the main storyboard
    //Written code for loading bar - complete
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var search_space: UITextField!
    @IBOutlet weak var tagscroller: UIScrollView!
    @IBOutlet weak var switch_outlet: UISwitch!
    @IBOutlet weak var searchbutton: UIButton!
    
    //Variables
    var dream_array = [String]()
    var tagnames = [String]()
    var selectedtags = [String]()
    var tagsearch = [String]()
    var search_triggered = 0
    var bckgrd = UIView()
    var closebutton = UIButton()
    var dreamtext = UITextView()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Will use viewdid appear

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        super.viewDidAppear(animated)


        // UI Elements initialzation
        
        search_space.isHidden = true
        search_space.placeholder = "    Search dream keywords .."
        search_space.textColor = UIColor.white
        search_space.backgroundColor = UIColor.gray
        search_space.textAlignment = .center
        search_space.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)

        tagscroller.isHidden = false
        
        searchbutton.setFAText(prefixText: "", icon: FAType.FASearch, postfixText: "", size: 30, forState: .normal)
        searchbutton.addTarget(self, action: #selector(self.show_search_textfield(sender:)), for: UIControlEvents.touchDown)
        searchbutton.setFATitleColor(color: UIColor.white, forState: .normal)
        
        bckgrd = UIView(frame : CGRect (x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        bckgrd.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        bckgrd.isHidden = true
        self.view.addSubview(bckgrd)
        
        closebutton = UIButton(frame : CGRect (x: self.view.frame.width - 50, y: 20, width: 30, height: 30))
        closebutton.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "", size: 30, forState: .normal)
        closebutton.addTarget(self, action: #selector(self.hide_dream(sender:)), for: UIControlEvents.touchDown)
        closebutton.isHidden = true
        closebutton.setFATitleColor(color: orange)
        self.view.addSubview(closebutton)
        
        dreamtext = UITextView(frame : CGRect (x: 40, y: 60, width: self.view.frame.width - 80, height: self.view.frame.height - 120))
        dreamtext.text = ""
        dreamtext.isHidden = true
        dreamtext.textColor = UIColor.white
        dreamtext.isScrollEnabled = true
        dreamtext.backgroundColor = UIColor.clear
        dreamtext.isUserInteractionEnabled = true
        dreamtext.isEditable = false
        dreamtext.clipsToBounds = false
        self.view.addSubview(dreamtext)
        
        refreshdreamlist()
        
    }
    
    
    //The function below is resposnible for showing results based on time i.e. day or night
    @IBAction func night_switch(_ sender: Any) {
        if switch_outlet.isOn {
            night_results()
        } else {
            refreshdreamlist()

        }
    }
    
    
    //The function below is resposible for popluting the dreams scrollview
    func refreshdreamlist() {
        
        dream_array.removeAll()
        tagnames.removeAll()
        
        //Clear tag scrollview
        print("Refreshing list")
        
        
        for subview in scroller.subviews {
            if subview is UIView {
                subview.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }
        
        
        // Y-axis declaration
        
        var yaxis = 10
        for subview in tagscroller.subviews {
            if subview is UIView {
                subview.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }
        
        //Get dream list string from 'userdefaults'. Alternative is Core Data
        let dreamlist_string = UserDefaults.standard.string(forKey: "dreamlist")!
        
        print("dreamlist_string")
        print(dreamlist_string)
        
        //Make dream array from string
        var dream_list_array =  dreamlist_string.components(separatedBy: "------incentro----------")
        
        dream_list_array = dream_list_array.filter { $0 != "" }
        dream_list_array = dream_list_array.filter { $0 != "nil" }
        
        //Check if aray is empty
        if dream_list_array.count == 0 {
            
            
            let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
             nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       There are no dreams", size: 15, forState: .normal)
            nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
            nodreams.layer.masksToBounds = true
            nodreams.layer.borderWidth = 0.5
            nodreams.layer.cornerRadius = 5
            nodreams.layer.borderColor =  UIColor.darkGray.cgColor
            nodreams.backgroundColor = UIColor.lightGray
            scroller.addSubview(nodreams)
            
            
        }
        

        //Populate scrollview
        for (index, element) in dream_list_array.enumerated(){
            
            //Appends dreams array
            dream_array.append(element)
            
            //Dream attribute array
            let dream_attributes_array = element.components(separatedBy: "xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx")
            
            //Dream details
            let dreamdets = dream_attributes_array[0]

            //Tag details
            let tagdets = dream_attributes_array[1]

            //Time details
            let timedets = dream_attributes_array[2]

            //Date details
            let datedets = dream_attributes_array[3]

            let dreambackground = UIView(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
            dreambackground.backgroundColor = orange.withAlphaComponent(0.6)
            dreambackground.layer.cornerRadius = 5
            scroller.addSubview(dreambackground)
            
            let dreamday = UILabel(frame : CGRect (x: 70, y: yaxis + 20, width: Int(scroller.frame.width - 80), height:20))
            dreamday.setFAText(prefixText: "", icon: FAType.FACalendar, postfixText: "  " + datedets, size: 8, iconSize: 9)
            dreamday.textColor = UIColor.white
            dreamday.textAlignment = .left
            dreamday.adjustsFontSizeToFitWidth = true
            scroller.addSubview(dreamday)
            
            let dreamtag = UILabel(frame : CGRect (x: 70, y: yaxis + 40, width: Int(scroller.frame.width - 80), height:20))
            dreamtag.setFAText(prefixText: "", icon: FAType.FATag, postfixText: "  " + tagdets, size: 10, iconSize: 12)
            dreamtag.textAlignment = .left
            dreamtag.textColor = UIColor.white
            dreamtag.adjustsFontSizeToFitWidth = true
            scroller.addSubview(dreamtag)
            
            if !tagnames.contains(tagdets) { tagnames.append(tagdets) }
            
            let dreamviewbutton = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
            dreamviewbutton.addTarget(self, action: #selector(self.show_dream(sender:)), for: UIControlEvents.touchDown)
            dreamviewbutton.layer.borderColor = UIColor.gray.cgColor
            dreamviewbutton.backgroundColor = .clear
            dreamviewbutton.setTitle(dreamdets, for: .normal)
            dreamviewbutton.setFATitleColor(color: UIColor.clear)
            dreamviewbutton.layer.borderWidth = 0.5
            dreamviewbutton.layer.cornerRadius = 5
            dreamviewbutton.layer.masksToBounds = true
            scroller.addSubview(dreamviewbutton)
            
            let dreamdeletebutton = UIButton(frame : CGRect (x: Int(scroller.frame.width) - 50, y: yaxis, width: 40, height: 80))
            dreamdeletebutton.layer.borderColor = UIColor.gray.cgColor
            dreamdeletebutton.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "", size: 30, forState: .normal)
            dreamdeletebutton.setFATitleColor(color: UIColor.white)
            dreamdeletebutton.layer.borderWidth = 0.0
                dreamdeletebutton.isHidden = true
            dreamdeletebutton.layer.masksToBounds = true
            scroller.addSubview(dreamdeletebutton)
            
            
            let dreamimg = UIImageView(frame : CGRect (x:20 , y: yaxis + 20, width: 40, height:40))
            dreamimg.contentMode = .scaleAspectFit
            dreamimg.image = UIImage(named: "people")
            scroller.addSubview(dreamimg)
            
            yaxis = yaxis + 100
            scroller.contentSize = CGSize(width: Int(scroller.frame.size.width), height: yaxis)
            
        }

        // the if ststement below check whater there are any tags
        if tagnames.count == 0 {
            
            
            let tagviewbutton = UIButton(frame : CGRect (x: 10, y: 10, width: 90, height:Int(tagscroller.frame.height - 20)))
            tagviewbutton.layer.borderColor = UIColor.gray.cgColor
            tagviewbutton.backgroundColor = .gray
            tagviewbutton.layer.cornerRadius = 5
            tagviewbutton.layer.borderWidth = 0.5
            tagviewbutton.layer.masksToBounds = true
            tagscroller.addSubview(tagviewbutton)
            
            
            let tagname = UILabel(frame : CGRect (x: 20, y: Int(tagscroller.frame.height/2) - 15, width: 70, height:20))
            tagname.font = UIFont.boldSystemFont(ofSize: tagname.font.pointSize)
            tagname.text = "There are no tags"
            tagname.adjustsFontSizeToFitWidth = true
            tagname.textAlignment = .center
            tagname.textColor = UIColor.white
            tagname.adjustsFontSizeToFitWidth = true
            tagscroller.addSubview(tagname)
            
        }
        
        var xaxis = 10
        
        for (index, element) in tagnames.enumerated(){
            

        
            
            
            let tagviewbutton = UIButton(frame : CGRect (x: xaxis, y: 10, width: 90, height:Int(tagscroller.frame.height - 20)))
            tagviewbutton.setTitle(element, for: .normal)
            tagviewbutton.setTitleColor(UIColor.white, for: .normal)
            tagviewbutton.addTarget(self, action: #selector(self.tag_selected(sender:)), for: UIControlEvents.touchDown)
            tagviewbutton.layer.borderColor = UIColor.gray.cgColor
            tagviewbutton.backgroundColor = UIColor.darkGray
            tagviewbutton.layer.borderWidth = 0.5
            tagviewbutton.layer.cornerRadius = 5
            tagviewbutton.layer.masksToBounds = true
            tagscroller.addSubview(tagviewbutton)
            


            xaxis = xaxis + 100
            
            tagscroller.contentSize = CGSize(width: Int(xaxis), height: Int(tagscroller.frame.size.height))
            
        }
        
        
        
    }
    
    

    
    
    @objc func show_dream(sender: UIButton!) {
        
        
        
        bckgrd.isHidden = false
        self.view.bringSubview(toFront: bckgrd)
        closebutton.isHidden = false
        self.view.bringSubview(toFront: closebutton)
        dreamtext.text = sender.titleLabel!.text!
        dreamtext.textColor = UIColor.white
        dreamtext.isHidden = false
        self.view.bringSubview(toFront: dreamtext)

        
        
    }
    
    
    @objc func hide_dream(sender: UIButton!) {
            
            
        bckgrd.isHidden = true
        closebutton.isHidden = true
        dreamtext.isHidden = true
        
    }
    

    
    
    @objc func show_search_textfield(sender: UIButton!) {
        
        if search_triggered == 0 {
        UIView.animate(withDuration: 0.2, animations: {
            print("Primed")
           
            self.tagscroller.isHidden = true
            sender.setFATitleColor(color: orange)
            self.search_space.isHidden = false
            self.view.bringSubview(toFront: self.search_space)
            self.view.bringSubview(toFront: self.searchbutton)

            self.search_triggered = 1
            
        })
        
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                print("Un-primed")
         
                self.tagscroller.isHidden = false
                self.search_space.isHidden = true
                sender.setFATitleColor(color: UIColor.white)
                self.view.bringSubview(toFront: self.tagscroller)
                self.view.bringSubview(toFront: self.searchbutton)

                self.search_triggered = 0

            })
            
        }
        
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        print("Editing")
        print(textField.text)
        
        let keyword = textField.text!
        
        refreshdreamlist()
        
        
        for subview in scroller.subviews {
            if subview is UIView {
                subview.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }
        
        
        // Y-axis declaration
        
        var yaxis = 10
        
        
        
        
        
        //Get dream list string from 'userdefaults'. Alternative is Core Data
        let dreamlist_string = UserDefaults.standard.string(forKey: "dreamlist")!
        
        print("dreamlist_string")
        print(dreamlist_string)
        
        //Make dream array from string
        var dream_list_array =  dreamlist_string.components(separatedBy: "------incentro----------")
        
        dream_list_array = dream_list_array.filter { $0 != "" }
        dream_list_array = dream_list_array.filter { $0 != "nil" }
        
        //Check if aray is empty
        if dream_list_array.count == 0 {
            
            
            let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
            nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       There are no dreams", size: 15, forState: .normal)
            nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
            nodreams.layer.masksToBounds = true
            nodreams.layer.borderWidth = 0.5
            nodreams.layer.cornerRadius = 5
            nodreams.layer.borderColor =  UIColor.darkGray.cgColor
            nodreams.backgroundColor = UIColor.lightGray
            scroller.addSubview(nodreams)
            
            
        }
        
        print("dream_list_array")
        print(dream_list_array.count)
        
        var counter = 0
        //Populate scrollview
        for (index, element) in dream_list_array.enumerated(){
            
            //Appends dreams array
            dream_array.append(element)
            
            counter = counter + 1
            
            //Dream attribute array
            let dream_attributes_array = element.components(separatedBy: "xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx")
            
            //Dream details
            let dreamdets = dream_attributes_array[0]
            print("dreamdets")
            print(dreamdets)
            //Tag details
            let tagdets = dream_attributes_array[1]
            print("tagdets")
            print(tagdets)
            //Time details
            let timedets = dream_attributes_array[2]
            print("timedets")
            print(timedets)
            //Date details
            let datedets = dream_attributes_array[3]
            print("datedets")
            print(datedets)
            
     
            print("SearchXXXXXX")
            print(dreamdets)
            print(keyword)
            print("SearchXXXXXX")

            
            if dreamdets.lowercased().range(of:keyword) != nil {
                
                print("found!")
                
                let dreambackground = UIView(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
                dreambackground.backgroundColor = orange.withAlphaComponent(0.6)
                dreambackground.layer.cornerRadius = 5
                scroller.addSubview(dreambackground)
                
                
                let dreamday = UILabel(frame : CGRect (x: 70, y: yaxis + 20, width: Int(scroller.frame.width - 80), height:20))
                dreamday.setFAText(prefixText: "", icon: FAType.FACalendar, postfixText: "  " + datedets, size: 10, iconSize: 12)
                dreamday.textColor = UIColor.white
                dreamday.textAlignment = .left
                scroller.addSubview(dreamday)
                
                
                let dreamtag = UILabel(frame : CGRect (x: 70, y: yaxis + 40, width: Int(scroller.frame.width - 80), height:20))
                dreamtag.setFAText(prefixText: "", icon: FAType.FATag, postfixText: "  " + tagdets, size: 10, iconSize: 12)
                dreamtag.textAlignment = .left
                dreamtag.textColor = UIColor.white
                dreamtag.adjustsFontSizeToFitWidth = true
                scroller.addSubview(dreamtag)
                
                
                let dreamviewbutton = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
                dreamviewbutton.addTarget(self, action: #selector(self.show_dream(sender:)), for: UIControlEvents.touchDown)
                dreamviewbutton.setTitle(dreamdets, for: .normal)
                dreamviewbutton.setFATitleColor(color: UIColor.clear)
                dreamviewbutton.layer.borderColor = UIColor.gray.cgColor
                dreamviewbutton.backgroundColor = .clear
                dreamviewbutton.layer.borderWidth = 0.5
                dreamviewbutton.layer.cornerRadius = 5
                dreamviewbutton.layer.masksToBounds = true
                scroller.addSubview(dreamviewbutton)
                
                let dreamdeletebutton = UIButton(frame : CGRect (x: Int(scroller.frame.width) - 50, y: yaxis, width: 40, height: 80))
                dreamdeletebutton.layer.borderColor = UIColor.gray.cgColor
                dreamdeletebutton.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "", size: 30, forState: .normal)
                dreamdeletebutton.setFATitleColor(color: UIColor.white)
                dreamdeletebutton.layer.borderWidth = 0.0
                dreamdeletebutton.isHidden = true
                dreamdeletebutton.layer.masksToBounds = true
                scroller.addSubview(dreamdeletebutton)
                
                
                
                let dreamimg = UIImageView(frame : CGRect (x:20 , y: yaxis + 20, width: 40, height:40))
                dreamimg.contentMode = .scaleAspectFit
                dreamimg.image = UIImage(named: "people")
                scroller.addSubview(dreamimg)
                
                yaxis = yaxis + 100
                
                scroller.contentSize = CGSize(width: Int(scroller.frame.size.width), height: yaxis)
                
            }
            
        }
        
        
        if counter == 0 {
            
            
            let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
            nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       No results", size: 15, forState: .normal)
            nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
            nodreams.layer.masksToBounds = true
            nodreams.layer.borderWidth = 0.5
            nodreams.layer.cornerRadius = 5
            nodreams.layer.borderColor =  UIColor.darkGray.cgColor
            nodreams.backgroundColor = UIColor.lightGray
            scroller.addSubview(nodreams)
            
            
        }
        
        
        
    }
    
    
    func night_results(){
        
        
        
        for subview in scroller.subviews {
            if subview is UIView {
                subview.removeFromSuperview()
            } else {
                subview.removeFromSuperview()
            }
        }
        
        
        // Y-axis declaration
        
        var yaxis = 10
        
        
        
        
        
        //Get dream list string from 'userdefaults'. Alternative is Core Data
        let dreamlist_string = UserDefaults.standard.string(forKey: "dreamlist")!
        
        print("dreamlist_string")
        print(dreamlist_string)
        
        //Make dream array from string
        var dream_list_array =  dreamlist_string.components(separatedBy: "------incentro----------")
        
        dream_list_array = dream_list_array.filter { $0 != "" }
        dream_list_array = dream_list_array.filter { $0 != "nil" }
        
        //Check if aray is empty
        if dream_list_array.count == 0 {
            
            
            let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
            nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       There are no dreams", size: 15, forState: .normal)
            nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
            nodreams.layer.masksToBounds = true
            nodreams.layer.borderWidth = 0.5
            nodreams.layer.cornerRadius = 5
            nodreams.layer.borderColor =  UIColor.darkGray.cgColor
            nodreams.backgroundColor = UIColor.lightGray
            scroller.addSubview(nodreams)
            
            
        }
        
        print("dream_list_array")
        print(dream_list_array.count)
        
        var counter = 0
        //Populate scrollview
        for (index, element) in dream_list_array.enumerated(){
            
            //Appends dreams array
            dream_array.append(element)
            
            counter = counter + 1
            
            //Dream attribute array
            let dream_attributes_array = element.components(separatedBy: "xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx")
            
            //Dream details
            let dreamdets = dream_attributes_array[0]
            print("dreamdets")
            print(dreamdets)
            //Tag details
            let tagdets = dream_attributes_array[1]
            print("tagdets")
            print(tagdets)
            //Time details
            let timedets = dream_attributes_array[2]
            print("timedets")
            print(timedets)
            //Date details
            let datedets = dream_attributes_array[3]
            print("datedets")
            print(datedets)
            
            
        
            
            
            if Int(timedets)! > 1800 {
                
                print("found!")
                
                let dreambackground = UIView(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
                dreambackground.backgroundColor = orange.withAlphaComponent(0.6)
                dreambackground.layer.cornerRadius = 5
                scroller.addSubview(dreambackground)
                
                
                let dreamday = UILabel(frame : CGRect (x: 70, y: yaxis + 20, width: Int(scroller.frame.width - 80), height:20))
                dreamday.setFAText(prefixText: "", icon: FAType.FACalendar, postfixText: "  " + datedets, size: 10, iconSize: 12)
                dreamday.textColor = UIColor.white
                dreamday.textAlignment = .left
                scroller.addSubview(dreamday)
                
                
                let dreamtag = UILabel(frame : CGRect (x: 70, y: yaxis + 40, width: Int(scroller.frame.width - 80), height:20))
                dreamtag.setFAText(prefixText: "", icon: FAType.FATag, postfixText: "  " + tagdets, size: 10, iconSize: 12)
                dreamtag.textAlignment = .left
                dreamtag.textColor = UIColor.white
                dreamtag.adjustsFontSizeToFitWidth = true
                scroller.addSubview(dreamtag)
                
                
                let dreamviewbutton = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
                dreamviewbutton.addTarget(self, action: #selector(self.show_dream(sender:)), for: UIControlEvents.touchDown)
                dreamviewbutton.setTitle(dreamdets, for: .normal)
                dreamviewbutton.setFATitleColor(color: UIColor.clear)
                dreamviewbutton.layer.borderColor = UIColor.gray.cgColor
                dreamviewbutton.backgroundColor = .clear
                dreamviewbutton.layer.borderWidth = 0.5
                dreamviewbutton.layer.cornerRadius = 5
                dreamviewbutton.layer.masksToBounds = true
                scroller.addSubview(dreamviewbutton)
                
                let dreamdeletebutton = UIButton(frame : CGRect (x: Int(scroller.frame.width) - 50, y: yaxis, width: 40, height: 80))
                dreamdeletebutton.layer.borderColor = UIColor.gray.cgColor
                dreamdeletebutton.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "", size: 30, forState: .normal)
                dreamdeletebutton.setFATitleColor(color: UIColor.white)
                dreamdeletebutton.layer.borderWidth = 0.0
                dreamdeletebutton.isHidden = true
                dreamdeletebutton.layer.masksToBounds = true
                scroller.addSubview(dreamdeletebutton)
                
                
                
                let dreamimg = UIImageView(frame : CGRect (x:20 , y: yaxis + 20, width: 40, height:40))
                dreamimg.contentMode = .scaleAspectFit
                dreamimg.image = UIImage(named: "people")
                scroller.addSubview(dreamimg)
                
                yaxis = yaxis + 100
                
                scroller.contentSize = CGSize(width: Int(scroller.frame.size.width), height: yaxis)
                
            }
            
        }
        
        
        if counter == 0 {
            
            
            let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
            nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       No results", size: 15, forState: .normal)
            nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
            nodreams.layer.masksToBounds = true
            nodreams.layer.borderWidth = 0.5
            nodreams.layer.cornerRadius = 5
            nodreams.layer.borderColor =  UIColor.darkGray.cgColor
            nodreams.backgroundColor = UIColor.lightGray
            scroller.addSubview(nodreams)
            
            
        }
        
        
        
    }
    
    
    @objc func tag_selected(sender: UIButton!) {
        
        
        let tag_name = sender.titleLabel!.text!
        
        if selectedtags.contains(tag_name) {
            
            
            selectedtags = selectedtags.filter { $0 != tag_name }
            sender.backgroundColor = UIColor.darkGray

            
        } else {
            
            
            selectedtags.append(tag_name)
            sender.backgroundColor = orange.withAlphaComponent(0.7)

        }

        
        
        
            print("Refreshing list")
        print(tagnames)
            
            
            for subview in scroller.subviews {
                if subview is UIView {
                    subview.removeFromSuperview()
                } else {
                    subview.removeFromSuperview()
                }
            }
            
            
            // Y-axis declaration
            
            var yaxis = 10

            
            
            
            
            //Get dream list string from 'userdefaults'. Alternative is Core Data
            let dreamlist_string = UserDefaults.standard.string(forKey: "dreamlist")!
            
            print("dreamlist_string")
            print(dreamlist_string)
            
            //Make dream array from string
            var dream_list_array =  dreamlist_string.components(separatedBy: "------incentro----------")
            
            dream_list_array = dream_list_array.filter { $0 != "" }
            dream_list_array = dream_list_array.filter { $0 != "nil" }
            
            //Check if aray is empty
            if dream_list_array.count == 0 {
                
                
                let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
                nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       There are no dreams", size: 15, forState: .normal)
                nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
                nodreams.layer.masksToBounds = true
                nodreams.layer.borderWidth = 0.5
                nodreams.layer.cornerRadius = 5
                nodreams.layer.borderColor =  UIColor.darkGray.cgColor
                nodreams.backgroundColor = UIColor.lightGray
                scroller.addSubview(nodreams)
                
                
            }
            
            print("dream_list_array")
            print(dream_list_array.count)
            
            var counter = 0
            //Populate scrollview
            for (index, element) in dream_list_array.enumerated(){
                
                //Appends dreams array
                dream_array.append(element)
                
                counter = counter + 1
                
                //Dream attribute array
                let dream_attributes_array = element.components(separatedBy: "xxxxxxxxxxxxxxxxxx--incentro--xxxxxxxxxxxxxxxxxx")
                
                //Dream details
                let dreamdets = dream_attributes_array[0]
                print("dreamdets")
                print(dreamdets)
                //Tag details
                let tagdets = dream_attributes_array[1]
                print("tagdets")
                print(tagdets)
                //Time details
                let timedets = dream_attributes_array[2]
                print("timedets")
                print(timedets)
                //Date details
                let datedets = dream_attributes_array[3]
                print("datedets")
                print(datedets)
                
                
        
                if selectedtags.contains(tagdets) {

                
                let dreambackground = UIView(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
                dreambackground.backgroundColor = orange.withAlphaComponent(0.6)
                dreambackground.layer.cornerRadius = 5
                scroller.addSubview(dreambackground)
                
                
                let dreamday = UILabel(frame : CGRect (x: 70, y: yaxis + 20, width: Int(scroller.frame.width - 80), height:20))
                dreamday.setFAText(prefixText: "", icon: FAType.FACalendar, postfixText: "  " + datedets, size: 8, iconSize: 9)
                dreamday.textColor = UIColor.white
                dreamday.textAlignment = .left
                scroller.addSubview(dreamday)
                
                
                let dreamtag = UILabel(frame : CGRect (x: 70, y: yaxis + 40, width: Int(scroller.frame.width - 80), height:20))
                dreamtag.setFAText(prefixText: "", icon: FAType.FATag, postfixText: "  " + tagdets, size: 10, iconSize: 12)
                dreamtag.textAlignment = .left
                dreamtag.textColor = UIColor.white
                dreamtag.adjustsFontSizeToFitWidth = true
                scroller.addSubview(dreamtag)
                
                
                let dreamviewbutton = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:80))
                    dreamviewbutton.addTarget(self, action: #selector(self.show_dream(sender:)), for: UIControlEvents.touchDown)
                    dreamviewbutton.setTitle(dreamdets, for: .normal)
                    dreamviewbutton.setFATitleColor(color: UIColor.clear)
                dreamviewbutton.layer.borderColor = UIColor.gray.cgColor
                dreamviewbutton.backgroundColor = .clear
                dreamviewbutton.layer.borderWidth = 0.5
                dreamviewbutton.layer.cornerRadius = 5
                dreamviewbutton.layer.masksToBounds = true
                scroller.addSubview(dreamviewbutton)
                
                let dreamdeletebutton = UIButton(frame : CGRect (x: Int(scroller.frame.width) - 50, y: yaxis, width: 40, height: 80))
                dreamdeletebutton.layer.borderColor = UIColor.gray.cgColor
                dreamdeletebutton.setFAText(prefixText: "", icon: FAType.FAClose, postfixText: "", size: 30, forState: .normal)
                dreamdeletebutton.setFATitleColor(color: UIColor.white)
                dreamdeletebutton.layer.borderWidth = 0.0
                dreamdeletebutton.isHidden = true
                dreamdeletebutton.layer.masksToBounds = true
                scroller.addSubview(dreamdeletebutton)
                
                
                
                let dreamimg = UIImageView(frame : CGRect (x:20 , y: yaxis + 20, width: 40, height:40))
                dreamimg.contentMode = .scaleAspectFit
                dreamimg.image = UIImage(named: "people")
                scroller.addSubview(dreamimg)
                
                yaxis = yaxis + 100
                
                scroller.contentSize = CGSize(width: Int(scroller.frame.size.width), height: yaxis)
                
                }
                
            }
        
            
            if counter == 0 {
                
                
                let nodreams = UIButton(frame : CGRect (x: 10, y: yaxis, width: Int(scroller.frame.width) - 20, height:60))
                nodreams.setFAText(prefixText: "", icon: FAType.FAInfoCircle, postfixText: "       There are no dreams using the selected tags", size: 15, forState: .normal)
                nodreams.setFATitleColor(color: UIColor.white, forState: .normal)
                nodreams.layer.masksToBounds = true
                nodreams.layer.borderWidth = 0.5
                nodreams.layer.cornerRadius = 5
                nodreams.layer.borderColor =  UIColor.darkGray.cgColor
                nodreams.backgroundColor = UIColor.lightGray
                scroller.addSubview(nodreams)
                
                
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
