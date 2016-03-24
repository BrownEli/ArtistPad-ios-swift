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
        //displayAd();
        initNavController();
        initToolBar();
        initTable();
    }
    
    func displayAd(){
        let ad = UIView(frame: ConstentValues.GAB);
        ad.backgroundColor = UIColor.init(red: 1, green: 2, blue: 1, alpha: 1);
        view.addSubview(ad);
    }
    
    func configEntityList(){
        entityList = [String]();
        entityList.append(ConstentEntityNames.Albums);
        entityList.append(ConstentEntityNames.Mixtapes);
        entityList.append(ConstentEntityNames.Singles);
        entityList.append(ConstentEntityNames.Covers);
        entityList.append(ConstentEntityNames.Poems);
        if IsFirstTime.isFirstTime{
            initConstentFolder();
        }
    }
    
    func initConstentFolder(){
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        for var i = 2; i < entityList.count; i++ {
            delegate.insertFolder(entityList[i], type: i);
        }
        IsFirstTime.isFirstTime = !IsFirstTime.isFirstTime;
    }
    
    func initNavController(){
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30));
        lable.text = ConstentValues.AppName;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor();
        navigationController?.navigationBar.tintColor = UIColor.whiteColor();
    }
    
    func initToolBar(){
        var items = [UIBarButtonItem]();
        let contact = UIBarButtonItem(title: "Contact", style: .Plain, target: self, action: nil);
        let about = UIBarButtonItem(title: "About", style: .Plain, target: self, action: "alert");
        let flex = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.append(contact);
        items.append(flex);
        items.append(about);
        self.toolbarItems = items;
        navigationController?.toolbarHidden = false;
        navigationController?.toolbar.barTintColor = UIColor.darkGrayColor();
        navigationController?.toolbar.tintColor = UIColor.whiteColor();
    }
    
    
    func initTable(){
        entityTable = UITableView(frame: ConstentValues.TABLE_RECT);
        entityTable.delegate = self;
        entityTable.dataSource = self;
        entityTable.backgroundColor = UIColor.lightGrayColor();
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
        cell.textLabel?.text = entityList[indexPath.row];
        cell.textLabel?.textColor = UIColor.darkGrayColor();
        cell.backgroundColor = UIColor.lightGrayColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let theNavigationController = navigationController{
            if indexPath.row < 2{
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
    
    func alert(){
        let alert = UIAlertController(title: "About", message: "Artist pad by Eli Brown version 1.0", preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentValues.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        presentViewController(alert, animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
