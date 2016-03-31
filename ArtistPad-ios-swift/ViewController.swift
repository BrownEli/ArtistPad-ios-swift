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
    
    func configEntityList(){
        entityList = [String]();
        entityList.append(ConstentPageTitles.Albums);
        entityList.append(ConstentPageTitles.Mixtapes);
        entityList.append(ConstentPageTitles.Singles);
        entityList.append(ConstentPageTitles.Covers);
        entityList.append(ConstentPageTitles.Poems);
        if IsFirstTimeRunningApp.isFirstTimeRunningApp{
            initConstentFolder();
        }
    }
    
    func initConstentFolder(){
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        for var i = ConstentTypes.TYPE_SINGLES; i < entityList.count; i++ {
            delegate.insertFolder(entityList[i], type: i);
        }
        IsFirstTimeRunningApp.isFirstTimeRunningApp = !IsFirstTimeRunningApp.isFirstTimeRunningApp;
    }
    
    func initNavController(){
        let lable = UILabel(frame: ConstentRects.NAV_TITLE_RECT);
        lable.text = ConstentValues.AppName;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        navigationController!.navigationBar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR;
        navigationController!.navigationBar.tintColor = ConstentColors.APP_TINT_COLOR;
    }
    
    func initToolBar(){
        var items = [UIBarButtonItem]();
        let contact = UIBarButtonItem(title: ConstentValues.TOOLBAR_CONTACT, style: .Plain, target: self, action: "ContactMe");
        let about = UIBarButtonItem(title: ConstentValues.TOOLBAR_ABOUT, style: .Plain, target: self, action: "alert");
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.append(contact);
        items.append(flex);
        items.append(about);
        self.toolbarItems = items;
        navigationController!.toolbarHidden = false;
        navigationController!.toolbar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR
        navigationController!.toolbar.tintColor = ConstentColors.APP_TINT_COLOR
    }
    
    func initTable(){
        entityTable = UITableView(frame: ConstentRects.TABLE_RECT);
        entityTable.delegate = self;
        entityTable.dataSource = self;
        //entityTable.backgroundColor = ConstentColors.CONTENT_BG_COLOR;
        entityTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: ConstentValues.Identifier);
        view.addSubview(entityTable);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ConstentValues.NUM_OF_SECTIONS_TABLEVIEW;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entityList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ConstentValues.Identifier, forIndexPath: indexPath);
        cell.textLabel?.text = entityList[indexPath.row];
        cell.textLabel?.textColor = UIColor.blueColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let theNavigationController = navigationController{
            if indexPath.row <= ConstentTypes.TYPE_MIXTAPES{
                let displayFolders = DisplayFolders();
                displayFolders.type = indexPath.row;
                theNavigationController.pushViewController(displayFolders, animated: true);
            }else{
                let list = delegate.getlistOfFolders(indexPath.row);
                let folder = list[0];
                let displaySongs = DisplaySongs();
                displaySongs.folder = folder;
                theNavigationController.pushViewController(displaySongs, animated: true);
            }
        }
    }
    
    func ContactMe(){
        let activityViewController = UIActivityViewController(activityItems: [], applicationActivities: []);
        activityViewController.excludedActivityTypes = [UIActivityTypeMail];
        presentViewController(activityViewController, animated : true, completion : nil);
    }
    
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
