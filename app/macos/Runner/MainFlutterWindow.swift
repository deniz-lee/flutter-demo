import Cocoa
import FlutterMacOS
import google_sign_in_macos

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    FLTGoogleSignInPlugin.register(with: flutterViewController.registrar(forPlugin: "FLTGoogleSignInPlugin"))

    super.awakeFromNib()
  }
}
