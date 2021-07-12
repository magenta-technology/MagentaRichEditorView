//
//  Bundle+CustomToolbars.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import Foundation

extension Bundle {
    internal static var customToolbars: Bundle {
        let bundle = Bundle(for: OutlookToolbar.self)
        if let url = bundle.resourceURL?.appendingPathComponent("MagentaRichEditorViewCustomToolbars.bundle"),
           let resourceBundle = Bundle(url: url) {
            return resourceBundle
        }
        return Bundle.main
    }
}
