//
//  OutlookEditorSectionOption.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import Foundation

public enum OutlookEditorSectionOption {
    case text(textsPararms: [OutlookEditorOptionTextParams])
    case image(normalImage: UIImage,
               selectedImage: UIImage,
               actionType: ToolbarActionType,
               action: (() ->  Void)? = nil)
}
