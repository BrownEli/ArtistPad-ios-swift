//
//  DisplayFolders.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/23/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//

import UIKit
import CoreData


class DisplayFolders: UIViewController , UITableViewDataSource, UITableViewDelegate{
    var navigator : UINavigationBar!;
    var delegate : AppDelegate!;
    var _list : [Folder]!;
    var _tableData : UITableView!;
    var pageTitle : String!;
    var add : String!;
    var placeholderTF : String!;
    var type : Int!;
    var wasOpen : Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setContentDetails();
        initNavController();
        initToolbar();
        initTable();
    }
    
    func setContentDetails(){
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        if type == ConstentTypes.TYPE_ALBUMS {
            pageTitle = ConstentPageTitles.Albums
            add = ConstentAlertMessgages.Add_Album;
            placeholderTF = ConstentAlertMessgages.Enter_Album
        }else if type == ConstentTypes.TYPE_MIXTAPES{
            pageTitle = ConstentPageTitles.Mixtapes
            add = ConstentAlertMessgages.Add_Mixtape;
            placeholderTF = ConstentAlertMessgages.Enter_Mixtape
        }
    }
    
    func initNavController(){
        let lable = UILabel(frame: ConstentRects.NAV_TITLE_RECT);
        lable.text = pageTitle;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController!.navigationBar.barTintColor = ConstentColors.NAVIGATION_BG_COLOR;
        navigationController!.navigationBar.tintColor = ConstentColors.APP_TINT_COLOR;
    }
    
    func initToolbar(){
        let add = UIBarButtonItem(title: self.add, style: .Plain, target: self, action: "alertTextField");
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
    
    func initTable(){
        _tableData = UITableView(frame: ConstentRects.TABLE_RECT);
        _tableData.delegate = self;
        _tableData.dataSource = self;
        //_tableData.backgroundColor = ConstentColors.CONTENT_BG_COLOR;
        _tableData.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: ConstentValues.Identifier);
        _list = delegate.getlistOfFolders(type);
        view.addSubview(_tableData);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ConstentValues.NUM_OF_SECTIONS_TABLEVIEW;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _list.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ConstentValues.Identifier, forIndexPath: indexPath);
        let s = _list[indexPath.row].folderName;
        cell.textLabel?.text = s;
        cell.textLabel?.textColor = UIColor.blueColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let displaySongs = DisplaySongs();
        displaySongs.folder = _list[indexPath.row];
        navigationController!.pushViewController(displaySongs, animated: true);
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            delegate.managedObjectContext.deleteObject(_list[indexPath.row]);
            delegate.saveContext();
            self._list.removeAtIndex(indexPath.row);
            self._tableData.reloadData();
        }
    }
    
    
    //app simple alerter
    func alert(title : String , msg : String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentAlertMessgages.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        navigationController?.pushViewController(alert, animated: true);
    }
    
    //app textfiled alerter
    func alertTextField(){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentAlertMessgages.Done, style: .Default, handler: {(action: UIAlertAction) -> Void in
            if let theTextFields = alert.textFields{
                let entityData = theTextFields[0].text!;
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
                let folder = delegate.insertFolder(entityData, type : self.type);
                self._list.append(folder);
                self._tableData.reloadData();
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
            _list = delegate.getlistOfFolders(type);
            _tableData.reloadData();
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        wasOpen = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}