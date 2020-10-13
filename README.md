
# NibAlert

![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/Nahanwoong/NibAlert/blob/main/LICENSE)

## Summary

- [Requirements](#requirements)
- [Usage](#usage)
- [Installation](#installation)
- [Example](#example)


## Requirements

- Swift 4.2
- iOS 9.0+


## Usage

> Alert
```
Alert("Test Title", "Test Message", style: .alert)
    .setTitle("New Title")
    .setMessage("New Message")
    .setStyle(.alert)
    .addOption(title: "OK", style: .default, action: { (action, alert) in
        print("OK Clicked!")
    })
    .addOptions([
        AlertOption(title: "Cancel", style: .cancel),
        AlertOption(title: "OK", style: .default, action: { (action, alert) in
            print("OK Clicked!")
        }),
        AlertOption(title: "Destructive", style: .destructive, action: { (action, alert) in
            print("Destructive Clicked!")
        })
    ])
    .setOption(title: "Cancel", style: .cancel, action: { (action, alert) in
        print("Cancel Clicked!")
    })
    .setOptions([
        AlertOption(title: "Cancel", style: .cancel),
        AlertOption(title: "OK", style: .default, action: { (action, alert) in
            print("OK Clicked!")
        }),
        AlertOption(title: "Destructive", style: .destructive, action: { (action, alert) in
            print("Destructive Clicked!")
        })
    ])
    .show(at: viewController)
    
Alert("Sign In")
    .addTextField({ (textField) in
        textField.placeholder = "Email"
        textField.textContentType = .emailAddress
    })
    .addTextField({
        $0.placeholder = "password"
        $0.isSecureTextEntry = true
    })
    .addOption(title: "Cancel", style: .cancel)
    .addOption(title: "OK", style: .default, action: { action, alert in
        guard let textFields = alert.textFields, textFields.count == 2 else { return }
        print("Email: \(textFields[0].text ?? "")")
        print("Password: \(textFields[1].text ?? "")")
    })
    .show(at: self)
```

> Alert Sheet
```
Alert("Test Title", "Test Message", style: .actionSheet)
    .setTitle("New Title")
    .setMessage("New Message")
    .setStyle(.actionSheet)
    .addOption(title: "OK", style: .default, action: { (action, alert) in
        print("OK Clicked!")
    })
    .addOptions([
        AlertOption(title: "Cancel", style: .cancel),
        AlertOption(title: "OK", style: .default, action: { (action, alert) in
            print("OK Clicked!")    
        }),
        AlertOption(title: "Destructive", style: .destructive, action: { (action, alert) in
            print("Destructive Clicked!")
        })
    ])
    .setOption(title: "Cancel", style: .cancel, action: { action in
        print("Cancel Clicked!")
    })
    .setOptions([
        AlertOption(title: "Cancel", style: .cancel),
        AlertOption(title: "OK", style: .default, action: { (action, alert) in
            print("OK Clicked!")
        }),
        AlertOption(title: "Destructive", style: .destructive, action: { (action, alert) in
            print("Destructive Clicked!")
        })
    ])
    .show(at: self)
```

## Installation

NibAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

pod 'NibAlert', :tag => '1.1.0', :git => 'https://github.com/Nahanwoong/NibAlert'

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## License

These works are available under the MIT license. See the [LICENSE][license] file
for more info.

  
[license]: LICENSE
