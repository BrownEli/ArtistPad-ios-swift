//
//  Constents.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/23/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//

import Foundation
import UIKit

class ConstentEntityNames {
    //Entity Names for use of operations in database.
    static let Folder = "Folder",Song = "Song";
}

class ConstentPageTitles{
    //Display of Page titles.
    static let Albums = "Albums", Mixtapes = "Mixtapes", Singles = "Singles", Covers = "Covers", Poems = "Poems";
}

class ConstentAlertMessgages{
    //About App Title and message.
    static let ABOUT_APP_TITLE = "About" , ABOUT_APP_MESSAGE = "Artist pad by Eli Brown version 1.0";
    //Alert controller button text.
    static let Done = "Done" , Ok = "Ok"
    //Alert controller text field placeholder.
    static let Enter_Album = "Enter album name", Enter_Mixtape = "Enter mixtape name" , Enter_Single = "Enter single name" , Enter_Cover = "Enter cover name" , Enter_Poem = "Enter poem name", Enter_Song = "Enter song name";
}

class ID {
    //Folder and Song gets their id from here.
    static var id : Int = 0;
}

class IsFirstTimeRunningApp{
    //for creation of Contstent Folders Singles,Covers,Poem.
    //when value is true these folders are created then value becomes false.
    static var isFirstTimeRunningApp : Bool = true;
}

class ConstentValues {
    //App Name.
    static let AppName = "Artist Pad";
    //Table view cell identifier.
    static let Identifier = "identifier";
    //My Email
    static let Contact_Info = "elibrown62@gmail.com";
    
    //Toolbar button text.
    static let Toolbar_Save = "Save", Toolbar_Delete = "Delete", Toolbar_Share = "Share",Toolbar_Contact = "Contact", Toolbar_About = ConstentAlertMessgages.ABOUT_APP_TITLE,Toolbar_Add_Album = "Add Album", Toolbar_Add_Mixtape = "Add Mixtape", Toolbar_Add_Single = "Add Single", Toolbar_Add_Cover = "Add Cover", Toolbar_Add_Poem = "Add Poem", Toolbar_Add_Song = "Add Song";
}

class ConstentColors{
    //Navigation background color.
    static let NAVIGATION_BG_COLOR = UIColor.blueColor();
    //App tinp color.
    static let APP_TINT_COLOR  = UIColor.whiteColor();
    
    //static let CONTENT_BG_COLOR = UIColor.whiteColor().colorWithAlphaComponent(0.3);
}

class ConstentTypes{
    //Types of folders and songs.
    static let TYPE_ALBUMS = 0, TYPE_MIXTAPES = 1, TYPE_SINGLES = 2, TYPE_COVERS = 3, TYPE_POEMS = 4;
}

class ConstentRects{
    //Rect for the window.
    static var windowFrame : CGRect!;
    //Rect for tableViews.
    static let TABLE_RECT = CGRect(x: windowFrame.origin.x, y: 0, width: windowFrame.width, height: windowFrame.height);
    static let MAIN_TABLE_RECT = CGRect(x: 0, y: 100, width: windowFrame.width, height: windowFrame.height - 200);
    //Rect for UITextView.
    static let TF_RECT = CGRect(x: windowFrame.origin.x, y: 0, width: windowFrame.width, height: windowFrame.height);
    //Rect for title of page.
    static let NAV_TITLE_RECT = CGRect(x: 0, y: 0, width: 80, height: 30);
}

