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
    var navigator : UINavigationBar!;
    var add : String!;
    var placeholderTF : String!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setDetails();
        //displayAd();
        initNavController();
        initTable();
        initAddBtn();
    }
    
    func setDetails(){
        switch (folder.type as! Int){
        case 2:
            add = ConstentValues.Add_Single;
            placeholderTF = ConstentValues.Enter_Single
        case 3:
            add = ConstentValues.Add_Cover;
            placeholderTF = ConstentValues.Enter_Cover
        case 4:
            add = ConstentValues.Add_Poem;
            placeholderTF = ConstentValues.Enter_Poem
        default:
            break;
        }
        delegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    }
    
    func displayAd(){
        let ad = UIView(frame: ConstentValues.GAB);
        ad.backgroundColor = UIColor.greenColor();
        view.addSubview(ad);
    }
    
    func initAddBtn(){
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
    
    func initNavController(){
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30));
        lable.text = self.folder.folderName;
        lable.textColor = UIColor.whiteColor();
        self.navigationItem.titleView = lable;
        self.navigationItem.leftItemsSupplementBackButton = true;
        navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor();
        navigationController?.navigationBar.tintColor = UIColor.whiteColor();
        
    }
    
    
    func initTable(){
        tableData = UITableView(frame: ConstentValues.TABLE_RECT);
        tableData.delegate = self;
        tableData.dataSource = self;
        tableData.backgroundColor = UIColor.lightGrayColor();
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
        cell.textLabel?.textColor = UIColor.darkGrayColor();
        cell.backgroundColor = UIColor.lightGrayColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let theNavigationController = navigationController {
            let editSong = EditSong();
            editSong.song = list[indexPath.row];
            theNavigationController.pushViewController(editSong, animated: true);
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            delegate.managedObjectContext.deleteObject(list[indexPath.row]);
            delegate.saveContext();
            list.removeAtIndex(indexPath.row);
            tableData.reloadData();
        }
    }
    
    
    //app simple alerter
    func alert(title : String , msg : String)->UIAlertController{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert);
        let action = UIAlertAction(title: ConstentValues.Ok, style: .Default, handler: {(action: UIAlertAction) -> Void in});
        alert.addAction(action);
        return alert;
    }
    
    //app textfiled alerter
    func alertTextField(){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .Alert);
        
        let action = UIAlertAction(title: ConstentValues.Done, style: .Default, handler: {(action: UIAlertAction) -> Void in
            
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
    
    override func viewDidAppear(animated: Bool) {
        list = delegate.getListOfSongs(self.folder.id as! Int, type: self.folder.type as! Int);
        tableData.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
