import Foundation
import UIKit
import ObjectiveC

public class QMInspectorGadget {
    public static let shared = QMInspectorGadget()
    private static var didSwizzle = false
    
    public init() {
        self.swizzleTextSetter()
    }
    
    public func loggingScreenName(screenName: String) {
        print("[INSPECTOR GADGET - LOGGING] - Screen Name: \(screenName)")
    }
    
    private func swizzleTextSetter() {
        guard !Self.didSwizzle else { return }
        Self.didSwizzle = true
        let anyClass: AnyClass = UILabel.self
        let originalSelector = #selector(setter: UILabel.text)
        let swizzledSelector = #selector(UILabel.qmSetText(_:))
        
        guard let originalMethod = class_getInstanceMethod(anyClass, originalSelector),
              let swizzledMethod = class_getInstanceMethod(anyClass, swizzledSelector) else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

//// QMTextChangeLogger: A framework-style utility for logging UILabel text changes via swizzling
//import UIKit
//import ObjectiveC
//
//public class QMTextChangeLogger {
//    public static let shared = QMTextChangeLogger()
//    private static var didSwizzle = false
//
//    private init() {
//        self.swizzleUILabelTextSetter()
//    }
//
//    private func swizzleUILabelTextSetter() {
//        guard !Self.didSwizzle else { return }
//        Self.didSwizzle = true
//        let cls: AnyClass = UILabel.self
//        let originalSelector = #selector(setter: UILabel.text)
//        let swizzledSelector = #selector(UILabel.qm_setText(_:))
//
//        guard let originalMethod = class_getInstanceMethod(cls, originalSelector),
//              let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector) else { return }
//
//        method_exchangeImplementations(originalMethod, swizzledMethod)
//    }
//}
//
//extension UILabel {
//    @objc func qm_setText(_ text: String?) {
//        // Call the original setter (now swapped)
//        self.qm_setText(text)
//        print("[QMTextChangeLogger] UILabel: \(self) text changed to: \(text ?? "<nil>")")
//    }
//}
