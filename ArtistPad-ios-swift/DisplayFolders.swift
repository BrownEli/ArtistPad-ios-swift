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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setDetails();
        //displayAd();
        initNavController();
        initToolbar();
        initTable();
    }
    
    func displayAd(){
        let ad = UIView(frame: ConstentValues.GAB);
        ad.backgroundColor = UIColor.greenColor();
        view.addSubview(ad);
    }
    
    func setDetails(){
        if type == 0 {
            pageTitle = ConstentEntityNames.Albums
            add = ConstentValues.Add_Album;
            placeholderTF = ConstentValues.Enter_Album
        }else{
            pageTitle = ConstentEntityNames.Mixtapes
            add = ConstentValues.Add_Mixtape;
            placeholderTF = ConstentValues.Enter_Mixtape
        }
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    }
    
    func initNavController(){
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30));
        lable.text = pageTitle;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor();
        navigationController?.navigationBar.tintColor = UIColor.whiteColor();
    }
    
    func initToolbar(){
        let add = UIBarButtonItem(title: self.add, style: .Plain, target: self, action: "alertTextField");
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        var items = [UIBarButtonItem]();
        items.append(flex);
        items.append(add);
        items.append(flex);
        self.toolbarItems = items;
        navigationController?.toolbarHidden = false;
        navigationController?.toolbar.barTintColor = UIColor.darkGrayColor();
        navigationController?.toolbar.tintColor = UIColor.whiteColor();
    }
    
    func initTable(){
        _tableData = UITableView(frame: ConstentValues.TABLE_RECT);
        _tableData.delegate = self;
        _tableData.dataSource = self;
        _tableData.backgroundColor = UIColor.lightGrayColor();
        _tableData.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: ConstentValues.Identifier);
        _list = delegate.getlistOfFolders(type);
        view.addSubview(_tableData);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _list.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ConstentValues.Identifier, forIndexPath: indexPath);
        let s = _list[indexPath.row].folderName;
        cell.textLabel?.text = s;
        cell.textLabel?.textColor = UIColor.darkGrayColor();
        cell.backgroundColor = UIColor.lightGrayColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let theNavigationController = navigationController{
            let displaySongs = DisplaySongs();
            displaySongs.folder = _list[indexPath.row];
            theNavigationController.pushViewController(displaySongs, animated: true);
        }
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
        let action = UIAlertAction(title: ConstentValues.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        navigationController?.pushViewController(alert, animated: true);
    }
    
    //app textfiled alerter
    func alertTextField(){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentValues.Done, style: .Default, handler: {(action: UIAlertAction) -> Void in
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
        navigationController?.pushViewController(alert, animated: true);
    }
    
    override func viewDidAppear(animated: Bool) {
        _list = delegate.getlistOfFolders(type);
        _tableData.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}