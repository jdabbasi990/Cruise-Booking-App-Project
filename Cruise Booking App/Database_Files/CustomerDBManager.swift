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

    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Customer (id INTEGER PRIMARY KEY, fullName TEXT, email TEXT, password TEXT, number TEXT, country TEXT, userName TEXT, address TEXT);"

        var createTableStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Customer table created successfully!")
            } else {
                print("Customer table failed!")
            }
        } else {
            print("Failed to perform CREATE TABLE statement.")
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
                  // Read all records again after updating a customer
                  let updatedCustomers = read()
                  print("All Records After Updating:")
                  for customer in updatedCustomers {
                      print("\(customer.id) | \(customer.fullName ?? "N/A") | \(customer.email ?? "N/A") | \(customer.password ?? "N/A") | \(customer.number ?? "N/A") | \(customer.country ?? "N/A") | \(customer.userName ?? "N/A") | \(customer.address ?? "N/A")")
                  }
              } else {
                  print("Couldn't update customer!")
              }
          } else {
              print("UPDATE statement failed to succeed!!!")
          }

          sqlite3_finalize(updateStatement)
      }
}
