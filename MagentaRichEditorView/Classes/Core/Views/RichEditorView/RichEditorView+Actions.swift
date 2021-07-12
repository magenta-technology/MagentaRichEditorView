//
// Created by Pavel Volkhin on 27.10.2020.
//

import UIKit

extension  RichEditorView {
    public func removeFormat() {
        self.runJS("zss_editor.removeFormating();")
    }

    public func setFontSize(_ size: Int) {
        self.runJS("zss_editor.setFontSize('\(size)px');")
    }

    public func setEditorBackgroundColor(_ color: UIColor) {
        self.runJS("zss_editor.setEditorBackgoundColor('\(color.hex)');")
    }

    public func undo() {
        self.runJS("zss_editor.undo();")
    }

    public func redo() {
        self.runJS("zss_editor.redo();")
    }

    public func bold() {
        self.runJS("zss_editor.setBold();")
    }

    public func italic() {
        self.runJS("zss_editor.setItalic();")
    }

    // "superscript" is a keyword
    public func subscriptText() {
        self.runJS("zss_editor.setSubscript();")
    }

    public func superscript() {
        self.runJS("zss_editor.setSuperscript();")
    }

    public func strikethrough() {
        self.runJS("zss_editor.setStrikeThrough();")
    }

    public func underline() {
        self.runJS("zss_editor.setUnderline();")
    }

    public func setTextColor(_ color: UIColor) {
        self.runJS("zss_editor.prepareInsert();")
        self.runJS("zss_editor.setTextColor('\(color.hex)');")
    }

    public func setEditorFontColor(_ color: UIColor) {
        self.runJS("zss_editor.setBaseTextColor('\(color.hex)');")
    }

    public func setTextBackgroundColor(_ color: UIColor) {
        self.runJS("zss_editor.prepareInsert();")
        self.runJS("zss_editor.setBackgroundColor('\(color.hex)');")
    }

    public func header(_ h: Int) {
        self.runJS("zss_editor.setHeading('h\(h)');")
    }

    public func indent() {
        self.runJS("zss_editor.setIndent();")
    }

    public func outdent() {
        self.runJS("zss_editor.setOutdent();")
    }

    public func orderedList() {
        self.runJS("zss_editor.setOrderedList();")
    }

    public func unorderedList() {
        self.runJS("zss_editor.setUnorderedList();")
    }

    public func blockquote() {
        self.runJS("zss_editor.setBlockquote()");
    }

    public func alignLeft() {
        self.runJS("zss_editor.setJustifyLeft();")
    }

    public func alignCenter() {
        self.runJS("zss_editor.setJustifyCenter();")
    }

    public func alignRight() {
        self.runJS("zss_editor.setJustifyRight();")
    }

    public func insertImage(_ url: String, alt: String) {
        self.runJS("zss_editor.prepareInsert();")
        self.runJS("zss_editor.insertImage('\(url.escaped)', '\(alt.escaped)');")
    }

    public func insertLink(_ href: String, title: String) {
        self.runJS("zss_editor.prepareInsert();")
        self.runJS("zss_editor.insertLink('\(href.escaped)', '\(title.escaped)');")
    }

    public func updateLink(_ href: String, title: String) {
        self.runJS("zss_editor.updateLink('\(href.escaped)', '\(title.escaped)');")
    }

    public func unlink() {
        self.runJS("zss_editor.unlink();")
    }

    public func quickLink() {
        self.runJS("zss_editor.quickLink();")
    }

    public func focus() {
        self.runJS("zss_editor.focusEditor();")
    }

    public func blur() {
        self.runJS("zss_editor.blurEditor()")
    }

    public func paragraph() {
        self.runJS("zss_editor.setParagraph()")
    }
    
    public func setFontFamily(_ familyName: String) {
        self.runJS("zss_editor.setFontFamily(\(familyName));")
    }
}
