import UIKit

public class Alert {
    
    // MARK: - Con(De)structor
    public init(_ title: String? = nil, _ message: String? = nil, style: UIAlertController.Style = .alert) {
        self.title = title
        self.message = message
        self.style = style
    }
    
    // MARK: - Properties
    public private(set) var title: String?
    public private(set) var message: String?
    public private(set) var style: UIAlertController.Style = .alert
    public private(set) var options: [AlertOption] = []
    
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
        return self
    }
    
    @discardableResult
    public func setOption(_ option: AlertOption) -> Alert {
        self.options = [ option ]
        return self
    }
    
    @discardableResult
    public func setOption(title: String? = nil, style: UIAlertAction.Style = .default, action: ((UIAlertAction) -> Void)? = nil) -> Alert {
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
    public func addOption(title: String? = nil, style: UIAlertAction.Style = .default, action: ((UIAlertAction) -> Void)? = nil) -> Alert {
        self.options.append(AlertOption(title: title, style: style, action: action))
        return self
    }
    
    @discardableResult
    public func addOptions(_ options: [AlertOption]) -> Alert {
        options.forEach { self.options.append($0) }
        return self
    }
    
    public func show(at view: UIViewController) {
        build(view)
    }
    
    // MARK: - Private Methods
    private func build(_ vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        options.forEach { option in
            alert.addAction( UIAlertAction(title: option.title, style: option.style, handler: { option.action($0) }) )
        }
        vc.present(alert, animated: true)
    }
}

public struct AlertOption {
    
    // MARK: - Properties
    private(set) var title: String?
    private(set) var style: UIAlertAction.Style
    private(set) var action: ((UIAlertAction) -> Void)
    
    // MARK: - Con(De)structor
    public init(title: String? = nil, style: UIAlertAction.Style = .default, action: ((UIAlertAction) -> Void)? = nil) {
        self.title = title
        self.style = style
        if let _action = action { self.action = _action }
        else { self.action = { _ in } }
    }
}
