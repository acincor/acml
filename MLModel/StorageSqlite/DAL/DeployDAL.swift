//
//  DeployDAL.swift
//  MLModel
//
//  Created by Monkey hammer on 8/9/24.
//
private let maxCacheDateTime: TimeInterval = 60
let classes = [Deploy.self, DendriteModel.self, NerveEndingModel.self, CellBodyModel.self, NucleusModel.self, DNAModel.self, NSDate.self, NSArray.self, NSString.self, NSNumber.self, NSDictionary.self, NeuronCell.self]
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
    public static var loadNewCellBody: CellBodyModel? {
        do {
            var cellBody = try collectCellBody()
            var sql = "SELECT * FROM T_Status WHERE cellBody = '\(try NSKeyedArchiver.archivedData(withRootObject: cellBody, requiringSecureCoding: true).base64EncodedString())' ORDER BY create_at DESC;"
            while !SqliteManager.shared.execRecordSet(sql: sql).isEmpty {
                cellBody = try collectCellBody()
                sql = "SELECT * FROM T_Status WHERE cellBody = '?' ORDER BY create_at DESC;"
            }
            return cellBody
        } catch let e {
            NSLog(e.localizedDescription)
        }
        return nil
    }
    public static var expiresDates = [Int:Date]()
    public class func saveSingleCache(array dict: [String:Any]) {
        let sql = "INSERT INTO T_Status(status, cellBody, create_at) VALUES (?, ?, ?);"
        // 3. 遍历数组 - 如果不能确认数据插入的消耗时间，可以在实际开发中写测试代码
        SqliteManager.shared.queue.inTransaction { (db, rollback) -> Void in
            let create_at = (dict["create_at"] as! String)
            guard let json = try? NSKeyedArchiver.archivedData(withRootObject: dict, requiringSecureCoding: true).base64EncodedString() else {
                return
            }
            guard let cellBody = try? NSKeyedArchiver.archivedData(withRootObject:(dict["cell"] as! NeuronCell).cellBody, requiringSecureCoding: true).base64EncodedString() else {
                return
            }
            // 插入数据
            do {
                try db.executeUpdate(sql, values: [json, cellBody, create_at])
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
    public class func loadStatus() throws -> [NeuronCell] {
        let sql = "SELECT status FROM T_Status ORDER BY create_at;"
        var neuronCells = [NeuronCell]()
        let list = SqliteManager.shared.execRecordSet(sql: sql)
        for i in list {
            guard let s = i["status"] as? String,let status = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: classes, from: Data(base64Encoded: s) ?? Data()) as? [String:Any], let cell = status["cell"] as? NeuronCell else {
                continue
            }
            neuronCells.append(cell)
        }
        return neuronCells
    }
}
