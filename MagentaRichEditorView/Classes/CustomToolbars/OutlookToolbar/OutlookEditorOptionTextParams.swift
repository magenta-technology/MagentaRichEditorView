//
//  OutlookEditorOptionTextParams.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 28.10.2020.
//

import UIKit

public struct OutlookEditorOptionTextParams {
    public let text: String
    public let font: UIFont
    public let actionType: ToolbarActionType?
    public let action: (() -> Void)?

    public init(text: String,
                font: UIFont,
                actionType: ToolbarActionType? = nil,
                action: (() -> Void)? = nil) {
        self.text = text
        self.font = font
        self.actionType = actionType
        self.action = action
    }
}
