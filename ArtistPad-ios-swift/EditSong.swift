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
        initVanToolbar();
    }
    
    func displayAd(){
        let ad = UIView(frame: ConstentValues.GAB);
        ad.backgroundColor = UIColor.greenColor();
        view.addSubview(ad);
    }
    
    func initVanToolbar(){
        let toolbar = UIToolbar(frame: ConstentValues.GAB);
        toolbar.frame.origin.y = view.frame.maxY - toolbar.frame.height + 5;
        let save = UIBarButtonItem(title: "save", style: .Plain, target: self, action: "saveSongData");
        var items = [UIBarButtonItem]();
        items.append(save);
        toolbar.items = items;
    }
    
    func initNavController(){
        songNameTF = UITextField(frame: CGRect(x: 0, y: 0, width: 80, height: 30));
        songNameTF.text = song.songName;
        songNameTF.textColor = UIColor.blueColor();
        self.navigationItem.titleView = songNameTF;
        let barBtnSettings = UIBarButtonItem(title: ConstentValues.SETTINGS, style: .Plain, target: self, action: nil);
        self.navigationItem.rightBarButtonItem = barBtnSettings;
        self.navigationItem.leftItemsSupplementBackButton = true;
    }
    
    func initTextField(){
        songBodyTF = UITextField(frame: ConstentValues.TF_RECT);
        songBodyTF.placeholder = ConstentValues.EDIT_SONG;
        songBodyTF.text = song.songBody;
        songBodyTF.textAlignment = .Center;
        view.addSubview(songBodyTF);
    }
    
    func saveSongData(){
        song.songBody = songBodyTF.text;
        song.songName = songNameTF.text;
        delegate.saveContext();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}