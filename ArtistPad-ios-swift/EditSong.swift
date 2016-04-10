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
    var songBodyLV : LinedView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        initNavController();
        initTextField();
        initToolbar();
    }
    
    /*
     Function for initializing and toolbar items,
     and seting toolbar bg color.
     */
    func initToolbar(){
        var items = [UIBarButtonItem]();
        let save = UIBarButtonItem(title: ConstentValues.Toolbar_Save, style: .Plain, target: self, action: #selector(EditSong.saveSongData));
        let share = UIBarButtonItem(title: ConstentValues.Toolbar_Share, style: .Plain, target: self, action: #selector(EditSong.shareSong));
        let delete = UIBarButtonItem(title: ConstentValues.Toolbar_Delete, style: .Plain, target: self, action: #selector(EditSong.deleteSong));
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        items.append(flex);
        items.append(save);
        items.append(share);
        items.append(delete);
        items.append(flex);
        self.toolbarItems = items;
        navigationController!.toolbarHidden = false;
        navigationController!.toolbar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR
        navigationController!.toolbar.tintColor = ConstentColors.APP_TINT_COLOR
    }
    
    /*
     Function for initializing and navigation items,
     and set navigation bg color
     */
    func initNavController(){
        songNameTF = UITextField(frame: ConstentRects.NAV_TITLE_RECT);
        songNameTF.text = song.songName;
        songNameTF.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = songNameTF;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController!.navigationBar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR;
        navigationController!.navigationBar.tintColor = ConstentColors.APP_TINT_COLOR;
    }
    
    /*
     Function for initializing the lined textView.
     */
    func initTextField(){
        songBodyLV = LinedView(frame: ConstentRects.TF_RECT);
        songBodyLV.backgroundColor = ConstentColors.APP_TINT_COLOR
        songBodyLV.text = song.songBody;
        view.addSubview(songBodyLV);
    }
    
    /*
     Function for saving the song detail's in the database.
     */
    func saveSongData(){
        song.songBody = songBodyLV.text;
        song.songName = songNameTF.text;
        delegate.saveContext();
    }
    
    /*
     Function for deleteing the song from the database.
     */
    func deleteSong(){
        delegate.managedObjectContext.deleteObject(song);
        delegate.saveContext();
    }
    
    /*
     Function for sharing a song via messagess and Email.
     */
    func shareSong(){
        let activityViewController = UIActivityViewController(activityItems: [songNameTF.text!,songBodyLV.text!], applicationActivities: []);
        activityViewController.excludedActivityTypes = [UIActivityTypeMail,UIActivityTypeMessage];
        presentViewController(activityViewController, animated : true, completion : nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}