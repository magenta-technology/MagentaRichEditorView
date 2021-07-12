//
//  RichEditorWebView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import WebKit

public final class RichEditorWebView: WKWebView {

    public var accessoryView: UIView?

    public override var inputAccessoryView: UIView? {
        self.accessoryView
    }

}
