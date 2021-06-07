//
//  WKWebView.swift
//  ProjectLightning
//
//  Created by Ram on 2021-04-02.
//

import Foundation
import WebKit

extension WKWebView {

    func setScrollEnabled(enabled: Bool) {
        self.scrollView.isScrollEnabled = enabled
        self.scrollView.panGestureRecognizer.isEnabled = enabled
        self.scrollView.bounces = enabled

        for subview in self.subviews {
            if let subview = subview as? UIScrollView {
                subview.isScrollEnabled = enabled
                subview.bounces = enabled
                subview.panGestureRecognizer.isEnabled = enabled
            }

            for subScrollView in subview.subviews {
                if type(of: subScrollView) == NSClassFromString("WKContentView")! {
                    for gesture in subScrollView.gestureRecognizers! {
                        subScrollView.removeGestureRecognizer(gesture)
                    }
                }
            }
        }
    }
}
