//
//  Bundle.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import Foundation

extension Bundle {
    internal static var richEditor: Bundle {
        let bundle = Bundle(for: RichEditorView.self)
        if let url = bundle.resourceURL?.appendingPathComponent("MagentaRichEditorView.bundle"),
           let resourceBundle = Bundle(url: url) {
            return resourceBundle
        }
        return Bundle.main
    }
}
