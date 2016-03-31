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
    static let Folder = "Folder",Song = "Song";
}

class ConstentPageTitles{
    static let Albums = "Albums", Mixtapes = "Mixtapes", Singles = "Singles", Covers = "Covers", Poems = "Poems";
}

class ConstentAlertMessgages{
    static let ABOUT_APP_TITLE = "About" , ABOUT_APP_MESSAGE = "Artist pad by Eli Brown version 1.0";
    static let Done = "Done" , Ok = "Ok"
    static let Add_Album = "Add Album", Add_Mixtape = "Add Mixtape", Add_Single = "Add Single", Add_Cover = "Add Cover", Add_Poem = "Add Poem", Add_Song = "Add Song";
    static let Enter_Album = "Enter album name", Enter_Mixtape = "Enter mixtape name" , Enter_Single = "Enter single name" , Enter_Cover = "Enter cover name" , Enter_Poem = "Enter poem name", Enter_Song = "Enter song name";
}

class ID {
    static var id : Int = 0;
}

class IsFirstTimeRunningApp{
    static var isFirstTimeRunningApp : Bool = true;
}

class ConstentValues {
    static let AppName = "Artist Pad", SETTINGS = "Settings"
    static let Identifier = "identifier";
    static let NUM_OF_SECTIONS_TABLEVIEW = 1;
    static let TOOLBAR_SAVE = "Save", TOOLBAR_DELETE = "Delete", TOOLBAR_SHARE = "Share",TOOLBAR_CONTACT = "Contact", TOOLBAR_ABOUT = ConstentAlertMessgages.ABOUT_APP_TITLE,EDIT_SONG = "Edit Song Here";
    private static let TableStartY : CGFloat = ConstentRects.windowFrame.origin.y + 50;
}

class ConstentColors{
    static let NAVIGATION_BG_COLOR = UIColor.blueColor();
    static let APP_TINT_COLOR  = UIColor.whiteColor();
    static let CONTENT_BG_COLOR = UIColor.whiteColor().colorWithAlphaComponent(0.3);
}

class ConstentTypes{
    static let TYPE_ALBUMS = 0, TYPE_MIXTAPES = 1, TYPE_SINGLES = 2, TYPE_COVERS = 3, TYPE_POEMS = 4;
}

class ConstentRects{
    static var windowFrame : CGRect!;
    static let TABLE_RECT = CGRect(x: windowFrame.origin.x, y: 0, width: windowFrame.width, height: windowFrame.height);
    static let TF_RECT = CGRect(x: windowFrame.origin.x, y: 0, width: windowFrame.width, height: windowFrame.height);
    static let NAV_TITLE_RECT = CGRect(x: 0, y: 0, width: 80, height: 30);
}

