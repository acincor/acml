//
//  SqliteManager.swift
//  MLModel
//
//  Created by Monkey hammer on 8/7/24.
//

class SqliteManager {
    static let shared = SqliteManager()
    let dbName = "readme.db"
    let queue: FMDatabaseQueue
    init() {
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        path = (path as NSString).appendingPathComponent(dbName)
        queue = FMDatabaseQueue(path: path)!
        NSLog(path)
        createTable()
    }
    private func createTable() {
        let path = Bundle(for: SqliteManager.self).path(forResource: "db", ofType: "sql")!
        let sql = try! String(contentsOfFile: path,encoding: .utf8)
        queue.inDatabase { db in
            if db.executeStatements(sql) == true {
            } else {
            }
        }
    }
    func execRecordSet(sql: String) -> [[String:Any]] {
        var result = [[String:Any]]()
        SqliteManager.shared.queue.inDatabase { db in
            //print(values)
            guard let rs = try? db.executeQuery(sql,values: nil) else {
                return
            }
            while rs.next() {
                let colCount = rs.columnCount
                var dict = [String:Any]()
                for col in 0..<colCount {
                    let name = rs.columnName(for: col)
                    let obj = rs.object(forColumnIndex: col)
                    dict[name!] = obj
                }
                result.append(dict)
            }
        }
        return result
    }
}
