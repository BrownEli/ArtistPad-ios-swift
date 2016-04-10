//
//  ViewController.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/23/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
    var delegate : AppDelegate!;
    var entityList : [String]!;
    var entityTable : UITableView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        configEntityList();
        initNavController();
        initToolBar();
        initTable();
    }
    
    /*
     Function for configuring the entityList.
     */
    func configEntityList(){
        entityList = [String]();
        entityList.append(ConstentPageTitles.Albums);
        entityList.append(ConstentPageTitles.Mixtapes);
        entityList.append(ConstentPageTitles.Singles);
        entityList.append(ConstentPageTitles.Covers);
        entityList.append(ConstentPageTitles.Poems);
        //If this is the first time app was opened this code is executed.
        if IsFirstTimeRunningApp.isFirstTimeRunningApp{
            initConstentFolder();
        }
    }
    
    /*
     Function for create's a folder for singles, covers and poems,
     and saves them to the database.
     */
    func initConstentFolder(){
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        var i = ConstentTypes.TYPE_SINGLES;
        while i < entityList.count{
            delegate.insertFolder(entityList[i], type: i);
            i += 1;
        }
        //this code set's the value of isFirstTimeRunningApp to false, so that the above code do not get executed again.
        IsFirstTimeRunningApp.isFirstTimeRunningApp = !IsFirstTimeRunningApp.isFirstTimeRunningApp;
    }
    
    /*
     Function for initializing and navigation items,
     and set navigation bg color
     */
    func initNavController(){
        let lable = UILabel(frame: ConstentRects.NAV_TITLE_RECT);
        lable.text = ConstentValues.AppName;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        navigationController!.navigationBar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR;
        navigationController!.navigationBar.tintColor = ConstentColors.APP_TINT_COLOR;
    }
    
    /*
     Function for initializing and toolbar items, 
     and seting toolbar bg color.
     */
    func initToolBar(){
        var items = [UIBarButtonItem]();
        let contact = UIBarButtonItem(title: ConstentValues.Toolbar_Contact, style: .Plain, target: self, action: #selector(ViewController.ContactMe));
        let about = UIBarButtonItem(title: ConstentValues.Toolbar_About, style: .Plain, target: self, action: #selector(ViewController.alert));
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.append(contact);
        items.append(flex);
        items.append(about);
        self.toolbarItems = items;
        navigationController!.toolbarHidden = false;
        navigationController!.toolbar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR
        navigationController!.toolbar.tintColor = ConstentColors.APP_TINT_COLOR
    }
    
    /*
     Function for initializing and the table view.
     */
    func initTable(){
        entityTable = UITableView(frame: ConstentRects.MAIN_TABLE_RECT);
        entityTable.delegate = self;
        entityTable.dataSource = self;
        entityTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: ConstentValues.Identifier);
        view.addSubview(entityTable);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entityList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ConstentValues.Identifier, forIndexPath: indexPath);
        cell.textLabel?.textAlignment = NSTextAlignment.Center;
        cell.textLabel?.text = entityList[indexPath.row];
        cell.textLabel?.textColor = UIColor.blueColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let theNavigationController = navigationController{
            if indexPath.row <= ConstentTypes.TYPE_MIXTAPES{
                //If the selected row is smaller or equal to ConstentTypes.TYPE_MIXTAPES, than it's of type mixtape or album. which means there are folders to be displayed and displayFolders viewController should be pushed to the screan.
                let displayFolders = DisplayFolders();
                displayFolders.type = indexPath.row;
                theNavigationController.pushViewController(displayFolders, animated: true);
            }else{
                //If the selected row is grater then ConstentTypes.TYPE_MIXTAPES, than it's of type single, covers or poem. which means there are songs to be displayed and displaySongs viewController should be pushed to the screan.
                let list = delegate.getlistOfFolders(indexPath.row);
                let folder = list[0];
                let displaySongs = DisplaySongs();
                displaySongs.folder = folder;
                theNavigationController.pushViewController(displaySongs, animated: true);
            }
        }
    }
    
    /*
     Function for sending email.
     */
    func ContactMe(){
        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: []);
        activityViewController.excludedActivityTypes = [UIActivityTypeMail];
        activityViewController.setValuesForKeysWithDictionary(["email" : ConstentValues.Contact_Info])
        presentViewController(activityViewController, animated : true, completion : nil);
    }
    
    /*
     Function for alerting the about app message.
     */
    func alert(){
        let alert = UIAlertController(title: ConstentAlertMessgages.ABOUT_APP_TITLE, message: ConstentAlertMessgages.ABOUT_APP_MESSAGE, preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentAlertMessgages.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        presentViewController(alert, animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
