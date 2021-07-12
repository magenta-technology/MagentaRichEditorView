//
// Created by Pavel Volkhin on 28.10.2020.
//

import Foundation
import WebKit

extension RichEditorView: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController,
                                      didReceive message: WKScriptMessage) {
        guard let messageString = message.body as? String else {
            return
        }
        if messageString == "paste" {
            self.editorPaste = true
        }

        if messageString == "input" {
            if self.receiveEditorDidChangeEvents {
                self.runJS("zss_editor.getHTML();") { [weak self] content in
                    guard let `self` = self else { return }
                    self.contentHTML = content
                    self.updateHeight()
                }
            }

            if self.editorPaste {
                self.blur()
                self.editorPaste = false
            }
        }
    }
}
