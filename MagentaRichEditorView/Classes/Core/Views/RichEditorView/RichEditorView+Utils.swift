//
// Created by Pavel Volkhin on 28.10.2020.
//

import UIKit

extension  RichEditorView {
    func getContentEditable(handler: @escaping (Bool) -> Void) {
        if self.isEditorLoaded {
            self.runJS("zss_editor.contentEditable") { string in
                handler(Bool(string) ?? false)
            }
        }
        handler(self.editingEnabledVar)
    }

    func updateHeight() {
        self.runJS("document.getElementById('zss_editor_content').clientHeight;") { [weak self] heightString in
            guard let `self` = self else { return }
            let height = Int(heightString) ?? 0
            if self.editorHeight != height {
                self.editorHeight = height
            }
        }
    }
}
