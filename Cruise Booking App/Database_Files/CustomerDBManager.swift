import Foundation
import SQLite3

class CustomerDBManager {
    init() {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "MyDb.sql"
    var db: OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)

        var db: OpaquePointer? = nil

        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            debugPrint("Could not open database")
            return nil
        } else {
            print("Database connected to database successfully")
            return db
        }
    }
    
//
//    func createTable() {
//        let createTableString = "CREATE TABLE IF NOT EXISTS Customer (id INTEGER PRIMARY KEY, fullName TEXT, email TEXT, password TEXT, number TEXT, country TEXT, userName TEXT, address TEXT);"
//
//        var createTableStatement: OpaquePointer? = nil
//
//        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
//            if sqlite3_step(createTableStatement) == SQLITE_DONE {
//                print("Customer table created successfully!")
//            } else {
//                print("Customer table failed!")
//            }
//        } else {
//            print("Failed to perform CREATE TABLE statement.")
//        }
//
//        sqlite3_finalize(createTableStatement)
//    }

    func createTable() {
        let createCustomerTableString = """
        CREATE TABLE IF NOT EXISTS Customer (
            id INTEGER PRIMARY KEY,
            fullName TEXT,
            email TEXT,
            password TEXT,
            number TEXT,
            country TEXT,
            userName TEXT,
            address TEXT
        );
        """

        let createBookingTableString = """
        CREATE TABLE IF NOT EXISTS Booking (
            id INTEGER PRIMARY KEY,
            customerName TEXT,
            customerEmail TEXT,
            customerPhone TEXT,
            customerAddress TEXT,
            numberOfAdults INTEGER,
            numberOfMinors INTEGER,
            numberOfSeniors INTEGER,
            cruisePackage INTEGER,
            departureDate TEXT,
            selectedCruise TEXT
        );
        """

        // Create the Customer table
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createCustomerTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Customer table created successfully!")
            } else {
                print("Customer table creation failed!")
            }
        } else {
            print("Failed to perform CREATE TABLE statement for Customer.")
        }
        sqlite3_finalize(createTableStatement)

        // Create the Booking table
        createTableStatement = nil
        if sqlite3_prepare_v2(db, createBookingTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Booking table created successfully!")
            } else {
                print("Booking table creation failed!")
            }
        } else {
            print("Failed to perform CREATE TABLE statement for Booking.")
        }
        sqlite3_finalize(createTableStatement)
    }

    func insert(customer: Customer) {
        
        let customers = read()
        
        // Find the maximum ID in the existing customers
        let maxID = customers.map { $0.id }.max() ?? 0
        
        // Assign a new ID by incrementing the maximum ID
        customer.id = maxID + 1

        let insertStatementString = "INSERT INTO Customer (id, fullName, email, password, number, country, userName, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"

        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(customer.id))
            sqlite3_bind_text(insertStatement, 2, (customer.fullName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (customer.email as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (customer.password as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (customer.number as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (customer.country as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (customer.userName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (customer.address as NSString?)?.utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("A customer added successfully!")
                // Read all records again after adding a customer
                let updatedCustomers = read()
                print("All Records After Inserting:")
                for customer in updatedCustomers {
                    print("\(customer.id) | \(customer.fullName ?? "N/A") | \(customer.email ?? "N/A") | \(customer.password ?? "N/A") | \(customer.number ?? "N/A") | \(customer.country ?? "N/A") | \(customer.userName ?? "N/A") | \(customer.address ?? "N/A")")
                }
//                print("Customer Details Before Insert:")
//                print("ID: \(customer.id)")
//                print("FullName: \(customer.fullName ?? "N/A")")

            } else {
                print("Couldn't add any row?")
            }
        } else {
            print("INSERT statement failed to succeed!!!")
        }

        sqlite3_finalize(insertStatement)
    }
    // ... (Your existing code)


    func read() -> [Customer] {
        let queryStatementString = "SELECT * FROM Customer;"

        var queryStatement: OpaquePointer? = nil
        var customers: [Customer] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)

                // Check if the value is NULL before converting to Swift String
                guard let fullNameCString = sqlite3_column_text(queryStatement, 1) else {
                    print("Error: NULL value in the database for 'fullName'.")
                    continue
                }

                let fullName = String(cString: fullNameCString)
                let email = String(cString: sqlite3_column_text(queryStatement, 2))
                let password = String(cString: sqlite3_column_text(queryStatement, 3))
                let number = String(cString: sqlite3_column_text(queryStatement, 4))
                let country = String(cString: sqlite3_column_text(queryStatement, 5))
                let userName = String(cString: sqlite3_column_text(queryStatement, 6))
                let address = String(cString: sqlite3_column_text(queryStatement, 7))

                customers.append(Customer(id: Int(id), fullName: fullName, email: email, password: password, number: number, country: country, userName: userName, address: address))

                print("Customer Details:")
                print("\(id) | \(fullName) | \(email) | \(password) | \(number) | \(country) | \(userName) | \(address)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }

        sqlite3_finalize(queryStatement)
        return customers
    }


    func deleteByID(id: Int) {
        let deleteStatementStirng = "DELETE FROM Customer WHERE id = ?;"

        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("A customer deleted successfully!")
            } else {
                print("Couldn't delete given customer")
            }
        } else {
            print("DELETE statement failed to succeed!")
        }

        sqlite3_finalize(deleteStatement)
    }
    

    func update(customer: Customer) {
        let updateStatementString = "UPDATE Customer SET fullName = ?, email = ?, password = ?, number = ?, country = ?, userName = ?, address = ? WHERE id = ?;"

        var updateStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (customer.fullName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (customer.email as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (customer.password as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (customer.number as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (customer.country as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (customer.userName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 7, (customer.address as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 8, Int32(customer.id))

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Customer updated successfully!")
            } else {
                print("Couldn't update customer.")
            }
        } else {
            print("UPDATE statement failed to succeed!")
        }

        sqlite3_finalize(updateStatement)
    }
    
    func customerExists(email: String, password: String) -> Bool {
        var queryStatement: OpaquePointer?
        let query = "SELECT * FROM Customer WHERE email = ? AND password = ?;"
        
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // A matching customer was found
                sqlite3_finalize(queryStatement)
                return true
            }
        }
        
        sqlite3_finalize(queryStatement)
        return false
    }

    func insertBooking(booking: Booking) {
        let insertStatementString = """
        INSERT INTO Booking (
            customerName, customerEmail, customerPhone, customerAddress,
            numberOfAdults, numberOfMinors, numberOfSeniors, cruisePackage, departureDate, selectedCruise
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """

        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (booking.customerName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (booking.customerEmail as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (booking.customerPhone as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (booking.customerAddress as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, Int32(booking.numberOfAdults))
            sqlite3_bind_int(insertStatement, 6, Int32(booking.numberOfMinors))
            sqlite3_bind_int(insertStatement, 7, Int32(booking.numberOfSeniors))
            sqlite3_bind_int(insertStatement, 8, Int32(booking.cruisePackage))
            sqlite3_bind_text(insertStatement, 9, (booking.departureDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (booking.selectedCruise! as NSString).utf8String, -1, nil)  // Add this line

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                // Retrieve the last inserted row ID
                let lastRowID = sqlite3_last_insert_rowid(db)

                print("A booking added successfully with ID: \(lastRowID)")
                // Print the details of the added booking
                print("Booking Details:")
                print("Customer Name: \(booking.customerName ?? "N/A")")
                print("Customer Email: \(booking.customerEmail ?? "N/A")")
                print("Customer Phone: \(booking.customerPhone ?? "N/A")")
                print("Customer Address: \(booking.customerAddress ?? "N/A")")
                print("Number of Adults: \(booking.numberOfAdults)")
                print("Number of Minors: \(booking.numberOfMinors)")
                print("Number of Seniors: \(booking.numberOfSeniors)")
                print("Cruise Package: \(booking.cruisePackage)")
                print("Departure Date: \(booking.departureDate)")
                print("Selected Cruise: \(String(describing: booking.selectedCruise))")  // Add this line
            } else {
                print("Couldn't add any booking row?")
            }
        } else {
            print("INSERT statement failed to succeed!!!")
        }

        sqlite3_finalize(insertStatement)
    }
    
    func getLastBooking() -> Booking? {
        let queryStatementString = "SELECT * FROM Booking ORDER BY id DESC LIMIT 1;"

        var queryStatement: OpaquePointer? = nil
        var lastBooking: Booking?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                lastBooking = extractBookingFromQuery(queryStatement: queryStatement!)
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }

        sqlite3_finalize(queryStatement)
        return lastBooking
    }

    private func extractBookingFromQuery(queryStatement: OpaquePointer) -> Booking {
        let id = sqlite3_column_int(queryStatement, 0)
        let customerName = String(cString: sqlite3_column_text(queryStatement, 1))
        let customerEmail = String(cString: sqlite3_column_text(queryStatement, 2))
        let customerPhone = String(cString: sqlite3_column_text(queryStatement, 3))
        let customerAddress = String(cString: sqlite3_column_text(queryStatement, 4))
        let numberOfAdults = Int(sqlite3_column_int(queryStatement, 5))
        let numberOfMinors = Int(sqlite3_column_int(queryStatement, 6))
        let numberOfSeniors = Int(sqlite3_column_int(queryStatement, 7))
        let cruisePackage = Int(sqlite3_column_int(queryStatement, 8))
        let departureDate = String(cString: sqlite3_column_text(queryStatement, 9))
        let selectedCruise = String(cString: sqlite3_column_text(queryStatement, 10))

        return Booking(
            id: Int(id),
            customerName: customerName,
            customerEmail: customerEmail,
            customerPhone: customerPhone,
            customerAddress: customerAddress,
            numberOfAdults: numberOfAdults,
            numberOfMinors: numberOfMinors,
            numberOfSeniors: numberOfSeniors,
            cruisePackage: cruisePackage,
            departureDate: departureDate,
            selectedCruise: selectedCruise
        )
    }

}
