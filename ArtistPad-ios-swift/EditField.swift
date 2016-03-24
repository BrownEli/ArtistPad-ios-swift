//
//  EditField.swift
//  ArtistPad-ios-swift
//
//  Created by Eli Brown on 3/24/16.
//  Copyright © 2016 Eli Brown. All rights reserved.
//

import Foundation
import UIKit

class EditField : UITextField {
    var editField : UITextField;
    
    override init(frame: CGRect) {
        editField = UITextField(frame: frame);
        super.init(frame: frame);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
}