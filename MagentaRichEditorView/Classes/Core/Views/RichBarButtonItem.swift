//
//  RichBarButtonItem.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import UIKit

/// RichBarButtonItem is a subclass of UIBarButtonItem that takes a callback as opposed to the target-action pattern
@objcMembers open class RichBarButtonItem: UIBarButtonItem {
    open var actionHandler: (() -> Void)?
    
    public convenience init(image: UIImage? = nil, handler: (() -> Void)? = nil) {
        self.init(image: image, style: .plain, target: nil, action: nil)
        target = self
        action = #selector(RichBarButtonItem.buttonWasTapped)
        actionHandler = handler
    }
    
    public convenience init(title: String = "", handler: (() -> Void)? = nil) {
        self.init(title: title, style: .plain, target: nil, action: nil)
        target = self
        action = #selector(RichBarButtonItem.buttonWasTapped)
        actionHandler = handler
    }
    
    @objc func buttonWasTapped() {
        actionHandler?()
    }
}
