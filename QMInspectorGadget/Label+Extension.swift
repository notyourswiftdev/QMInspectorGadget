import UIKit
import ObjectiveC

public extension UILabel {
    @objc func qmSetText(_ text: String) {
        self.qmSetText(text)
        print("[INSPECTOR GADGET - LOGGING] - UILabel: \(self) text changed to: \(text)")
    }
}
