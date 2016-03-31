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
    var songBodyTV : LinedView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        initNavController();
        initTextField();
        initToolbar();
    }
    
    
    
    func initToolbar(){
        var items = [UIBarButtonItem]();
        let save = UIBarButtonItem(title: ConstentValues.TOOLBAR_SAVE, style: .Plain, target: self, action: "saveSongData");
        let share = UIBarButtonItem(title: ConstentValues.TOOLBAR_SHARE, style: .Plain, target: self, action: "shareSong");
        let delete = UIBarButtonItem(title: ConstentValues.TOOLBAR_DELETE, style: .Plain, target: self, action: "deleteSong");
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
    
    func initNavController(){
        songNameTF = UITextField(frame: ConstentRects.NAV_TITLE_RECT);
        songNameTF.text = song.songName;
        songNameTF.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = songNameTF;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController!.navigationBar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR;
        navigationController!.navigationBar.tintColor = ConstentColors.APP_TINT_COLOR;
    }
    
    
    func initTextField(){
        songBodyTV = LinedView(frame: ConstentRects.TF_RECT);
        songBodyTV.backgroundColor = ConstentColors.APP_TINT_COLOR
        songBodyTV.text = song.songBody;
        view.addSubview(songBodyTV);
    }
    
    func saveSongData(){
        song.songBody = songBodyTV.text;
        song.songName = songNameTF.text;
        delegate.saveContext();
        navigationController!.popViewControllerAnimated(true);
    }
    
    func deleteSong(){
        delegate.managedObjectContext.deleteObject(song);
        delegate.saveContext();
        navigationController!.popViewControllerAnimated(true);
    }
    
    func shareSong(){
        let activityViewController = UIActivityViewController(activityItems: [songNameTF.text!,songBodyTV.text!], applicationActivities: []);
        activityViewController.excludedActivityTypes = [UIActivityTypeMail,UIActivityTypePostToFacebook,UIActivityTypeMessage,UIActivityTypePostToTwitter];
        presentViewController(activityViewController, animated : true, completion : nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}