//
//  DeployDAL.swift
//  MLModel
//
//  Created by Monkey hammer on 8/9/24.
//
private let maxCacheDateTime: TimeInterval = 60
let classes = [Deploy.self, DendriteModel.self, NerveEndingModel.self, CellBodyModel.self, NucleusModel.self, DNAModel.self, NSDate.self, NSArray.self, NSString.self, NSNumber.self, NSDictionary.self, NeuronCell.self, NerveTissue.self]
open class DeployDAL {
    public class func clearDataCache() {
        let date = Date(timeIntervalSinceNow: -maxCacheDateTime)
        let df = DateFormatter()
        df.locale = Locale(identifier: "en")
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = df.string(from: date)
        let sql = "DELETE FROM T_Status WHERE createtime < '?'"
        SqliteManager.shared.queue.inDatabase { db in
            try? db.executeUpdate(sql, values: [dateStr])
        }
    }
    public class func removeCache(_ statusId: Int) {
        let sql = "DELETE FROM T_Status WHERE statusId = \(statusId)"
        SqliteManager.shared.queue.inDatabase { db in
            try? db.executeUpdate(sql, values: nil)
        }
    }
    public static func collectCellBody() throws -> CellBodyModel{
        var dnas = [DNAModel]()
        for _ in 0...4 {
            var integers = [Int]()
            for _ in 0...4 {
                integers.append(Int.random(in: 1..<100000000000))
            }
            dnas.append(try DNAModel(rnaId: integers))
        }
        return CellBodyModel(nucleus: try NucleusModel(dnas: dnas))
    }
    ///防止过多model因范围不足重复，所以生成4个数为一组，若其中有组元素完全相同再重新生成
    public static var loadNewId: Int {
        var iden = Int.random(in: 0...100000000)
        var sql = "SELECT * FROM T_Status WHERE id = \(iden) ORDER BY create_at DESC;"
        while !SqliteManager.shared.execRecordSet(sql: sql).isEmpty {
            iden = Int.random(in: 0...100000000)
            sql = "SELECT * FROM T_Status WHERE id = \(iden) ORDER BY create_at DESC;"
        }
        return iden
    }
    public static var loadNewCellBody: CellBodyModel? {
        let sql = "SELECT status FROM T_Status;"
        let dictionaries = SqliteManager.shared.execRecordSet(sql: sql)
        var cellBodies = [CellBodyModel]()
        for dictionary in dictionaries {
            guard let nerveTissue = dictionary["nerveTissue"] as? NerveTissue else{
                continue
            }
            for neuronCell in nerveTissue.neuronCells {
                cellBodies.append(neuronCell.cellBody)
            }
        }
        do {
            var cellBody = try collectCellBody()
            while cellBodies.contains(cellBody) {
                cellBody = try collectCellBody()
            }
            return cellBody
        } catch {
            NSLog(error.localizedDescription)
        }
        return nil
    }
    public static var expiresDates = [Int:Date]()
    public class func saveSingleCache(array dict: [String:Any]) {
        let sql = "INSERT INTO T_Status(id, status, create_at) VALUES (?, ?, ?);"
        // 3. 遍历数组 - 如果不能确认数据插入的消耗时间，可以在实际开发中写测试代码
        SqliteManager.shared.queue.inTransaction { (db, rollback) -> Void in
            let statusId = dict["id"] as! Int
            let create_at = (dict["create_at"] as! String)
            guard let json = try? NSKeyedArchiver.archivedData(withRootObject: dict, requiringSecureCoding: true).base64EncodedString() else {
                return
            }
            // 插入数据
            do {
                try db.executeUpdate(sql, values: [statusId, json, create_at])
                guard db.changes > 0 else {
                    return
                }
            } catch {
            }
        }
    }
    public class func saveCache(array data: [[String:Any]]) {
        for dict in data {
            saveSingleCache(array: dict)
        }
    }
    public class func loadStatus() throws -> [NerveTissue] {
        let sql = "SELECT status FROM T_Status ORDER BY create_at;"
        var nerveTissues = [NerveTissue]()
        let list = SqliteManager.shared.execRecordSet(sql: sql)
        for i in list {
            guard let s = i["status"] as? String,let status = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: classes, from: Data(base64Encoded: s) ?? Data()) as? [String:Any], let nerveTissue = status["nerveTissue"] as? NerveTissue else {
                continue
            }
            nerveTissues.append(nerveTissue)
        }
        return nerveTissues
    }
}
