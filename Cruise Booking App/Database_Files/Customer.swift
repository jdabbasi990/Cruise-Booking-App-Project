import Foundation

class Customer {
    var id: Int
    var fullName: String?
    var email: String?
    var password: String?
    var number: String?
    var country: String?
    var userName: String?
    var address: String?

    init(id: Int, fullName: String?, email: String?, password: String?, number: String?, country: String?, userName: String?, address: String?) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.password = password
        self.number = number
        self.country = country
        self.userName = userName
        self.address = address
    }
}
