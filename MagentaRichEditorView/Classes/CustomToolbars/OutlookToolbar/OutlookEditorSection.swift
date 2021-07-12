//
//  OutlookEditorSection.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 21.10.2020.
//

import Foundation

public struct OutlookEditorSection {
    let items: [OutlookEditorSectionOption]
    
    public init(items: [OutlookEditorSectionOption]) {
        self.items = items
    }
}
