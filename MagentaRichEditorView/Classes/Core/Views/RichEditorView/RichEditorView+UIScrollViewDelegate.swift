//
// Created by Pavel Volkhin on 27.10.2020.
//

import UIKit

extension RichEditorView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // We use this to keep the scroll view from changing its offset when the keyboard comes up
        if !self.isScrollEnabled {
            scrollView.bounds = self.webView.bounds
        }
    }
}
