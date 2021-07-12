//
//  RichEditorView.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import UIKit
import WebKit

let DefaultLineHeight: Int = 28

@objcMembers public class RichEditorView: UIView {
    public private(set) var webView: RichEditorWebView!

    public weak var delegate: RichEditorDelegate?

    public var enabledActionsHandler: ((ToolbarActionType) -> Void)?

    public var isScrollEnabled: Bool = true {
        didSet {
            self.webView.scrollView.isScrollEnabled = self.isScrollEnabled
        }
    }

    public var editingEnabled: Bool = false {
        didSet {
            self.contentEditable = self.editingEnabled
        }
    }

    public var receiveEditorDidChangeEvents: Bool = true

    public internal(set) var contentHTML: String = "" {
        didSet {
            self.delegate?.richEditor?(self, contentDidChange: self.contentHTML)
        }
    }

    public internal(set) var editorHeight: Int = 0 {
        didSet {
            self.delegate?.richEditor?(self, heightDidChange: self.editorHeight)
        }
    }

    /// The line height of the editor. Defaults to 28.
    open internal(set) var lineHeight: Int = DefaultLineHeight {
        didSet {
            self.lineHeightVar = self.lineHeight
            if self.isEditorLoaded {
                self.runJS("zss_editor.setLineHeight('\(self.lineHeight)px');")
            }
        }
    }

    public var html: String = "" {
        didSet {
            self.setHTML(html)
        }
    }

    public var selectedImageURL: String?

    public var selectedImageAlt: String?

    public var selectedLinkURL: String?

    public var selectedLinkTitle: String?

    public var placeholder: String = "" {
        didSet {
            self.placeholderText = self.placeholder
            if self.isEditorLoaded {
                self.runJS("zss_editor.setPlaceholder('\(self.placeholder.escaped)');")
            }
        }
    }

    public var contentHeight: CGFloat = 244 {
        didSet {
            self.contentHeightVar = self.contentHeight
            if self.isEditorLoaded {
                self.runJS("zss_editor.contentHeight = \(self.contentHeight)")
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override open func becomeFirstResponder() -> Bool {
        if !self.webView.isFirstResponder {
            self.focus()
            return true
        } else {
            return false
        }
    }

    open override func resignFirstResponder() -> Bool {
        self.blur()
        return true
    }

    public override var inputAccessoryView: UIView? {
        get { self.webView.accessoryView }
        set { self.webView.accessoryView = newValue }
    }

    public func runJS(_ js: String, handler: ((String) -> Void)? = nil) {
        self.webView.evaluateJavaScript(js) { result, error in
            if let error = error {
                print("WKWebViewJavascriptBridge Error: \(String(describing: error)) - JS: \(js)")
                handler?("")
                return
            }
            guard let handler = handler else {
                return
            }
            if let resultInt = result as? Int {
                handler("\(resultInt)")
                return
            }
            if let resultBool = result as? Bool {
                handler(resultBool ? "true" : "false")
                return
            }
            if let resultStr = result as? String {
                handler(resultStr)
                return
            }
            handler("")
        }
    }

    public func getText(handler: @escaping (String) -> Void) {
        self.runJS("zss_editor.getText()") { string in
            handler(string)
        }
    }

    public func isEditingEnabled(handler: @escaping (Bool) -> Void) {
        self.getContentEditable(handler: handler)
    }

    var contentEditable: Bool = false {
        didSet {
            self.editingEnabledVar = self.contentEditable
            if self.isEditorLoaded {
                let value = (self.contentEditable ? "true" : "false")
                self.runJS("zss_editor.setContentEditable(\(value));")
            }
        }
    }
    var lineHeightVar = DefaultLineHeight
    var placeholderText: String = ""
    var isEditorLoaded = false
    var editingEnabledVar = true
    var editorPaste = false
    var contentHeightVar: CGFloat = 244
    private var resourcesLoaded = false
}

// MARK: - Private Methods

extension RichEditorView {
    private func setup() {
        backgroundColor = .clear

        let config = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        contentController.add(self, name: "jsm")
        config.userContentController = contentController
        let scriptString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        let script = WKUserScript(source: scriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(script)
        config.dataDetectorTypes = WKDataDetectorTypes()

        self.webView = RichEditorWebView(frame: bounds, configuration: config)
        self.webView.navigationDelegate = self
        self.webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.webView.configuration.dataDetectorTypes = WKDataDetectorTypes()
        self.webView.isOpaque = false
        self.webView.backgroundColor = .clear
        self.webView.scrollView.backgroundColor = .clear
        self.webView.scrollView.isScrollEnabled = self.isScrollEnabled
        self.webView.scrollView.bounces = false
        self.webView.scrollView.delegate = self
        self.webView.scrollView.clipsToBounds = false
        
        self.addSubview(self.webView)
        
        if !self.resourcesLoaded {
            self.loadResources()
        }
    }

    func setHTML(_ value: String) {
        if self.isEditorLoaded {
            self.runJS("zss_editor.setHTML('\(value.escaped)')") { _ in
                self.updateHeight()
            }
        }
    }

    private func loadResources() {
        if let filePath = Bundle.richEditor.path(forResource: "rich_editor", ofType: "html") {
            let url = URL(fileURLWithPath: filePath, isDirectory: false)
            self.webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        self.resourcesLoaded = true
    }
}
