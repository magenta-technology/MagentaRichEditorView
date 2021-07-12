//
//  RichEditorDefaultToolbar.swift
//  MagentaRichEditorView
//
//  Created by Pavel Volkhin on 20.10.2020.
//

import UIKit

/// RichEditorToolbar is UIView that contains the toolbar for actions that can be performed on a RichEditorView
@objcMembers open class RichEditorToolbar: UIView {

    /// The delegate to receive events that cannot be automatically completed
    open weak var delegate: RichEditorToolbarDelegate?

    /// A reference to the RichEditorView that it should be performing actions on
    open weak var editor: RichEditorView?

    /// The list of options to be displayed on the toolbar
    open var options: [RichEditorOption] = [] {
        didSet {
            updateToolbar()
        }
    }
    
    /// The tint color to apply to the toolbar background.
    open var barTintColor: UIColor? {
        get { return toolbar.barTintColor }
        set { toolbar.barTintColor = newValue }
    }

    private var toolbarScroll: UIScrollView
    private var toolbar: UIToolbar
    
    public override init(frame: CGRect) {
        toolbarScroll = UIScrollView()
        toolbar = UIToolbar()
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        toolbarScroll = UIScrollView()
        toolbar = UIToolbar()
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        autoresizingMask = .flexibleWidth
        backgroundColor = .clear

        toolbar.autoresizingMask = .flexibleWidth
        toolbar.backgroundColor = .clear
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        toolbarScroll.frame = bounds
        toolbarScroll.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        toolbarScroll.showsHorizontalScrollIndicator = false
        toolbarScroll.showsVerticalScrollIndicator = false
        toolbarScroll.backgroundColor = .clear

        toolbarScroll.addSubview(toolbar)

        addSubview(toolbarScroll)
        updateToolbar()
    }
    
    private func updateToolbar() {
        var buttons = [UIBarButtonItem]()
        for option in options {
            let handler = { [weak self] in
                if let strongSelf = self {
                    option.action(strongSelf)
                }
            }

            if let image = option.image {
                let button = RichBarButtonItem(image: image, handler: handler)
                buttons.append(button)
            } else {
                let title = option.title
                let button = RichBarButtonItem(title: title, handler: handler)
                buttons.append(button)
            }
        }
        toolbar.items = buttons

        let defaultIconWidth: CGFloat = 28
        let barButtonItemMargin: CGFloat = 11
        let width: CGFloat = buttons.reduce(0) {sofar, new in
            if let view = new.value(forKey: "view") as? UIView {
                return sofar + view.frame.size.width + barButtonItemMargin
            } else {
                return sofar + (defaultIconWidth + barButtonItemMargin)
            }
        }
        
        if width < frame.size.width {
            toolbar.frame.size.width = frame.size.width
        } else {
            toolbar.frame.size.width = width
        }
        toolbar.frame.size.height = 44
        toolbarScroll.contentSize.width = width
    }
    
}
