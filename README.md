# Reusable iOS Components

This framework contains iOS components that can be reused throughout your project

## Available Components

- Two lined button 
- Button with icon
- Button with activity indicator
- Custom alert that will animate in and out
- Confirm alert, can be used to take users confirmation
- Alert that allows to take input from user

All Components are customizable and written using auto layouts. Feel free to modify as per your requirement.

## Usage

### **TwoLineButton**
Twolinebutton displays 2 labels

``` Swift
let twoLineButton: TwoLineButton = {
        let twoLineButton = TwoLineButton()
        twoLineButton.config(data: TwoLineButtonData(primaryLabel: "Buy Now", secondaryLabel: "20$ Extra Later"))
        return twoLineButton
}()
```
You can add target as a normal button from uikit
```
twoLineButton.addTarget(self, action: #selector(twoLineButtonTapped), for: .touchUpInside)
```

### **LoadingButton**
LoadingButton contains an activity indicator that can be displayed and stopped as per the requirement.

``` Swift
let loadingButton: LoadingButton = {
        let loadingButton = LoadingButton()
        loadingButton.config(data: LoadingButtonData(label: "Sign up!!"))
        return loadingButton
}()
```
You can start and stop loading using below methods
```
loadingButton.showLoading()
loadingButton.stopLoading()
```

### **IconButton**
IconButton allows to display an icon. Icon can be passed during during config as `UIImage`

``` Swift
let iconButton: IconButton = {
        let iconButton = IconButton()
        iconButton.config(data: IconButtonData(label: "Save Profile", icon: UIImage(systemName: "square.and.arrow.down")))
        return iconButton
}()
```

### **Alert**
Alert is a custom alert that can be used to display message to user. Alert animates from top to center of the screen. You can use callback to perfrom some task when alert is closed.

``` Swift
let alert = Alert()
alert.showAlert(title: "Alert Message", message: "custom message from view controller.", on: self) { closed in
    if closed {
        print("alert closed")
    }
}
```

### **ConfirmAlert**
ConfirmAlert is a custom alert that can be used to display message and take confirmation from user. Alert animates from top to center of the screen. You can use callback to perfrom some task when user confirms or closed the alert.

``` Swift
let confirmAlert = ConfirmAlert()
confirmAlert.showAlert(title: "Delete User", message: "Are you sure you want to delete this user from the system?", on: self) { confirmed in
    if confirmed {
        print("user confirmed")
    } else {
        print("user closed")
    }
}
```

### **InputAlert**
InputAlert is a custom alert that can be used to take an input from the user. Alert animates from top to center of the screen. You can use callback to perfrom some task after user provides input.

``` Swift
let inputAlert = InputAlert()
inputAlert.showAlert(title: "Add User", message: "Add new user to the system.", on: self) { data in
    if let data = data {
        print(data)
    } else {
        print("No data is entered")
    }
 }
```

## License

MIT

**Free Software, Hell Yeah!**
