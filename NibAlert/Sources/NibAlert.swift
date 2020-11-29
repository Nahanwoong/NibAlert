import UIKit

public protocol AlertContentViewable: UIViewController {
    var alertContentSize: CGSize { get }
}

public final class Alert {
    
    // MARK: - Con(De)structor
    public init(_ title: String? = nil, _ message: String? = nil, style: UIAlertController.Style = .alert) {
        self.title = title
        self.message = message
        self.style = style
    }
    
    // MARK: - Properties
    public typealias ConfigurationHandler = ((UITextField) -> Void)?
    
    private let CONTENTVIEWCONTROLLER_KEY: String = "contentViewController"
    
    public private(set) var alertController: UIAlertController?
    public private(set) var title: String?
    public private(set) var message: String?
    public private(set) var style: UIAlertController.Style = .alert
    public private(set) var options: [AlertOption] = []
    public private(set) var configurations: [ConfigurationHandler] = []
    public private(set) var contentView: AlertContentViewable? = nil
    
    // MARK: - Public Methods
    
    @discardableResult
    public func setTitle(_ title: String?) -> Alert {
        self.title = title
        return self
    }
    
    @discardableResult
    public func setMessage(_ msg: String?) -> Alert {
        self.message = msg
        return self
    }
    
    @discardableResult
    public func setStyle(_ style: UIAlertController.Style) -> Alert {
        self.style = style
        configurations = self.style == .alert ? configurations : []
        return self
    }
    
    @discardableResult
    public func setOption(_ option: AlertOption) -> Alert {
        self.options = [ option ]
        return self
    }
    
    @discardableResult
    public func setOption(title: String? = nil, style: UIAlertAction.Style = .default, action: ((UIAlertAction, UIAlertController) -> Void)? = nil) -> Alert {
        self.options = [ AlertOption(title: title, style: style, action: action) ]
        return self
    }
    
    @discardableResult
    public func setOptions(_ options: [AlertOption]) -> Alert {
        self.options = options
        return self
    }
    
    @discardableResult
    public func addOption(_ option: AlertOption) -> Alert {
        self.options.append(option)
        return self
    }
    
    @discardableResult
    public func addOption(title: String? = nil, style: UIAlertAction.Style = .default, action: ((UIAlertAction, UIAlertController) -> Void)? = nil) -> Alert {
        self.options.append(AlertOption(title: title, style: style, action: action))
        return self
    }
    
    @discardableResult
    public func addOptions(_ options: [AlertOption]) -> Alert {
        options.forEach { self.options.append($0) }
        return self
    }
    
    @discardableResult
    public func setTextField(_ configuration: ConfigurationHandler) -> Alert {
        guard style == .alert else { return self }
        self.configurations = [ configuration ]
        return self
    }
    
    @discardableResult
    public func setTextFields(_ configurations: [ConfigurationHandler]) -> Alert {
        guard style == .alert else { return self }
        self.configurations = configurations
        return self
    }
    
    @discardableResult
    public func addTextField(_ configuration: ConfigurationHandler) -> Alert {
        guard style == .alert else { return self }
        self.configurations.append(configuration)
        return self
    }
    
    @discardableResult
    public func addTextFields(_ configurations: [ConfigurationHandler]) -> Alert {
        guard style == .alert else { return self }
        configurations.forEach { self.configurations.append($0) }
        return self
    }
    
    @discardableResult
    public func setContentView(_ contentView: AlertContentViewable?) -> Alert {
        guard style == .alert else { return self }
        self.contentView = contentView
        return self
    }
    
    @discardableResult
    public func show(at view: UIViewController) -> Alert {
        build(view)
        return self
    }
    
    public func hide() {
        guard let alert = self.alertController else { return }
        alert.dismiss(animated: true, completion: { self.alertController = nil })
    }
    
    // MARK: - Private Methods
    private func build(_ vc: UIViewController) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        guard let alert = alertController else { return }
        options.forEach { option in
            alert.addAction(UIAlertAction(title: option.title, style: option.style, handler: {
                option.action($0, alert)
                self.alertController = nil
            }))
        }
        
        if self.style == .alert {
            configurations.forEach { configuration in
                alert.addTextField(configurationHandler: configuration)
            }
            
            if let cv = contentView {
                cv.preferredContentSize = cv.alertContentSize
                alert.setValue(cv, forKey: CONTENTVIEWCONTROLLER_KEY)
            }
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad, let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.center.x, y: vc.view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
            vc.present(alert, animated: true)
        } else {
            vc.present(alert, animated: true)
        }
    }
}

public struct AlertOption {
    
    // MARK: - Properties
    private(set) var title: String?
    private(set) var style: UIAlertAction.Style
    private(set) var action: ((UIAlertAction, UIAlertController) -> Void)
    
    // MARK: - Con(De)structor
    public init(title: String? = nil, style: UIAlertAction.Style = .default, action: ((UIAlertAction, UIAlertController) -> Void)? = nil) {
        self.title = title
        self.style = style
        if let _action = action { self.action = _action }
        else { self.action = { (_ ,_) in } }
    }
}
