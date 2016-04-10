//
//  DisplaySongs.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/23/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DisplaySongs : UIViewController, UITableViewDelegate
,UITableViewDataSource{
    var delegate : AppDelegate!;
    var folder : Folder!;
    var list : [Song]!;
    var tableData : UITableView!;
    var add : String!;
    var alertTitle : String!;
    var placeholderTF : String!;
    var wasOpen : Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setContentDetails();
        initNavController();
        initTable();
        initToolbar();
    }
    
    /*
     Function for seting the text for the toolbar add button and the placeholder for the alert text filed.
     */
    func setContentDetails(){
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        switch (folder.type as! Int){
        case ConstentTypes.TYPE_SINGLES:
            add = ConstentValues.Toolbar_Add_Single;
            placeholderTF = ConstentAlertMessgages.Enter_Single
        case ConstentTypes.TYPE_COVERS:
            add = ConstentValues.Toolbar_Add_Cover;
            placeholderTF = ConstentAlertMessgages.Enter_Cover
        case ConstentTypes.TYPE_POEMS:
            add = ConstentValues.Toolbar_Add_Poem;
            placeholderTF = ConstentAlertMessgages.Enter_Poem
        default:
            add = ConstentValues.Toolbar_Add_Song;
            placeholderTF = ConstentAlertMessgages.Enter_Song
        }
        alertTitle = add;
    }
    
    /*
     Function for initializing and toolbar items,
     and seting toolbar bg color.
     */
    func initToolbar(){
        let add = UIBarButtonItem(title: self.add, style: .Plain, target: self, action: #selector(DisplaySongs.alertTextField));
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        var items = [UIBarButtonItem]();
        items.append(flex);
        items.append(add);
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
        let lable = UILabel(frame : ConstentRects.NAV_TITLE_RECT);
        lable.text = self.folder.folderName;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController!.navigationBar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR;
        navigationController!.navigationBar.tintColor = ConstentColors.APP_TINT_COLOR;
    }
    
    /*
     Function for initializing and the table view.
     */
    func initTable(){
        tableData = UITableView(frame: ConstentRects.TABLE_RECT);
        tableData.delegate = self;
        tableData.dataSource = self;
        tableData.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: ConstentValues.Identifier);
        list = delegate.getListOfSongs(self.folder.id as! Int, type: self.folder.type as! Int);
        view.addSubview(tableData);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ConstentValues.Identifier, forIndexPath: indexPath);
        cell.textLabel?.text = list[indexPath.row].songName;
        cell.textLabel?.textColor = UIColor.blueColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let editSong = EditSong();
        editSong.song = list[indexPath.row];
        navigationController!.pushViewController(editSong, animated: true);
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //allow's row editing for deletion.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            //deletes a song.
            delegate.managedObjectContext.deleteObject(list[indexPath.row]);
            delegate.saveContext();
            list.removeAtIndex(indexPath.row);
            tableData.reloadData();
        }
    }
    
    
    /*
     Function for alerting a simple message.
     */
    func alert(title : String , msg : String)->UIAlertController{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentAlertMessgages.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        return alert;
    }
    
    /*
     Function for alerting a textField to add a new Song.
     */
    func alertTextField(){
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentAlertMessgages.Done, style: .Default, handler: {(action: UIAlertAction) -> Void in
            if let theTextFields = alert.textFields{
                let songName = theTextFields[0].text!;
                let song = self.delegate.insertSong(self.folder.id! as Int, type : self.folder.type! as Int, songName: songName, songBody: "");
                self.list.append(song);
                self.tableData.reloadData();
            }
        });
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = self.placeholderTF;
        }
        alert.addAction(action);
        presentViewController(alert, animated: true, completion: nil);
    }
    
    override func viewWillAppear(animated: Bool) {
        if wasOpen {
            //If user navigated back to this viewController after changing a detail about a song.
            list = delegate.getListOfSongs(self.folder.id as! Int, type: self.folder.type as! Int);
            tableData.reloadData();
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        wasOpen = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
