//
// Created by Pavel Volkhin on 28.10.2020.
//

import Foundation

extension RichEditorView {
    func updateToolbar(_ commands: String) {
        let itemNames = commands.components(separatedBy: ",")
        var enabledActions: ToolbarActionType = []
        itemNames.forEach { linkItem in
            var updatedItem = linkItem
            if linkItem.hasPrefix("link:") {
                updatedItem = "link"
                self.selectedLinkURL = linkItem.replacingOccurrences(of: "link:", with: "")
            } else if linkItem.hasPrefix("link-title:") {
                self.selectedLinkTitle = linkItem.byDecodingURLFormat
            } else if linkItem.hasPrefix("image:") {
                updatedItem = "image"
                self.selectedImageURL = linkItem.replacingOccurrences(of: "image:", with: "")
            } else if linkItem.hasPrefix("image-alt:") {
                self.selectedImageAlt = linkItem.replacingOccurrences(of: "image-alt:", with: "").byDecodingURLFormat
            } else {
                self.selectedLinkTitle = nil
                self.selectedLinkURL = nil
                self.selectedImageURL = nil
                self.selectedImageAlt = nil
            }
            if let action = ToolbarActionType.action(by: linkItem) {
                enabledActions.insert(action)
            }
            if let action = ToolbarActionType.action(by: updatedItem) {
                enabledActions.insert(action)
            }
        }
        self.enabledActionsHandler?(enabledActions)
    }
}
