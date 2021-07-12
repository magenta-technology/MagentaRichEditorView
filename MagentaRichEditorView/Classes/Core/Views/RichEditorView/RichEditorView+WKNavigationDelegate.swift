//
// Created by Pavel Volkhin on 27.10.2020.
//

import UIKit
import WebKit

extension RichEditorView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let callbackPrefix = "callback://0/"
        let url = navigationAction.request.url?.absoluteString
        if let urlString = url, urlString.hasPrefix(callbackPrefix) {
            self.updateToolbar(urlString.replacingOccurrences(of: callbackPrefix, with: ""))
            return decisionHandler(WKNavigationActionPolicy.cancel);
        }
        if navigationAction.navigationType == .linkActivated,
           let url = navigationAction.request.url,
           self.delegate?.richEditor?(self, shouldInteractWith: url) ?? false {
            decisionHandler(WKNavigationActionPolicy.allow);
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.isEditorLoaded = true
        self.setHTML(html)
        self.contentEditable = self.editingEnabledVar
        self.placeholder = self.placeholderText
        self.lineHeight = self.lineHeightVar
        self.contentHeight = self.contentHeightVar
        self.delegate?.richEditorDidLoad?(self)
        self.updateHeight()

        /*

        Create listeners for when text is changed, solution by @madebydouglas derived from richardortiz84 https://github.com/nnhubbard/ZSSRichTextEditor/issues/5

        */

        let inputListener = "document.getElementById('zss_editor_content').addEventListener('input', function() {window.webkit.messageHandlers.jsm.postMessage('input');});"
        let pasteListener = "document.getElementById('zss_editor_content').addEventListener('paste', function() {window.webkit.messageHandlers.jsm.postMessage('paste');});"
        self.runJS(inputListener)
        self.runJS(pasteListener)
    }
}
