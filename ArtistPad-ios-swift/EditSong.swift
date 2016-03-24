//
//  EditSong.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/23/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditSong : UIViewController{
    var delegate : AppDelegate!;
    var song : Song!;
    var songNameTF : UITextField!;
    var songBodyTF : UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        displayAd();
        initNavController();
        initTextField();
        initToolbar();
    }
    
    func displayAd(){
        let ad = UIView(frame: ConstentValues.GAB);
        ad.backgroundColor = UIColor.greenColor();
        view.addSubview(ad);
    }
    
    func initToolbar(){
        var items = [UIBarButtonItem]();
        let save = UIBarButtonItem(title: "save", style: .Plain, target: self, action: "saveSongData");
        let share = UIBarButtonItem(title: "share", style: .Plain, target: self, action: "shareSong");
        let delete = UIBarButtonItem(title: "delete", style: .Plain, target: self, action: "deleteSong");
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        items.append(flex);
        items.append(save);
        items.append(share);
        items.append(delete);
        items.append(flex);
        self.toolbarItems = items;
        navigationController?.toolbarHidden = false;
        navigationController?.toolbar.barTintColor = UIColor.darkGrayColor();
        navigationController?.toolbar.tintColor = UIColor.whiteColor();
    }
    
    func initNavController(){
        songNameTF = UITextField(frame: CGRect(x: 0, y: 0, width: 80, height: 30));
        songNameTF.text = song.songName;
        songNameTF.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = songNameTF;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController?.navigationBar.tintColor = UIColor.whiteColor();
        navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor();
    }
    
    func initTextField(){
        songBodyTF = UITextField(frame: ConstentValues.TF_RECT);
        songBodyTF.placeholder = ConstentValues.EDIT_SONG;
        songBodyTF.text = song.songBody;
        view.addSubview(songBodyTF);
    }
    
    func saveSongData(){
        song.songBody = songBodyTF.text;
        song.songName = songNameTF.text;
        delegate.saveContext();
        navigationController?.popViewControllerAnimated(true);
        alert("song saved");
    }
    
    func deleteSong(){
        delegate.managedObjectContext.deleteObject(song);
        delegate.saveContext();
        navigationController?.popViewControllerAnimated(true);
        alert("song deleted");
    }
    
    func shareSong(){
        
    }
    
    func alert(msg : String){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentValues.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        presentViewController(alert, animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}