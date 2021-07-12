//
//  OutlookAdditionOption.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import Foundation

public struct OutlookAdditionOption {
    let image: UIImage
    let action: (() -> Void)?
    
    public init (image: UIImage, action: (() -> Void)? = nil) {
        self.image = image
        self.action = action
    }
}
