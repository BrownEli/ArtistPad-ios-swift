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
    
    static let Albums = "Albums", Mixtapes = "Mixtapes", Singles = "Singles", Covers = "Covers", Poems = "Poems";
}

class ID {
    static var id : Int = 0;
}

class IsFirstTime{
    static var isFirstTime : Bool = true;
}

class ConstentValues {
    static let AppName = "Artist Pad", SETTINGS = "Settings"
    
    static let Done = "Done" , Ok = "Ok"
    
    static let Identifier = "identifier"
    
    static let Add_Album = "Add Album", Add_Mixtape = "Add Mixtape", Add_Single = "Add Single", Add_Cover = "Add Cover", Add_Poem = "Add Poem"
    static let Enter_Album = "Enter album's name", Enter_Mixtape = "Enter mixtape's name" , Enter_Single = "Enter single's name" , Enter_Cover = "Enter cover's name" , Enter_Poem = "Enter poem's name" , EDIT_SONG = "Edit Song Here";
    
    
    static var windowFrame : CGRect!;
    private static let GABStartY : CGFloat = windowFrame.origin.y + 50;
    private static let GABHeight : CGFloat = windowFrame.origin.y + 50;
    private static let TABLE_START_Y : CGFloat = GABStartY + GABHeight;
    
    static let TABLE_RECT = CGRect(x: windowFrame.origin.x, y: TABLE_START_Y, width: windowFrame.width, height: windowFrame.height - 140);
    
    static let TF_RECT = CGRect(x: windowFrame.origin.x, y: TABLE_START_Y, width: windowFrame.width, height: windowFrame.height - 100);
    
    static let GAB = CGRect(x: windowFrame.origin.x, y: GABStartY, width: windowFrame.width, height: GABHeight);
}

