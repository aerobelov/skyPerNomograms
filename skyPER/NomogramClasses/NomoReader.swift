
import UIKit

class NomoReader {
    
    var data: Data?
    
    init(file: String) {
        if let url = Bundle.main.url(forResource: file, withExtension: ".json") {
            //print("file exist")
            if let data = try? Data(contentsOf: url) {
                self.data = data
            }
        } else {
            print("EOF")
        }
    }
  
    func dataToPolyNomogram() -> [MyLine]? {
        guard self.data != nil else { return nil }
        let decoder = JSONDecoder()
        let parsedData = try! decoder.decode(MyNomogramm.self, from: self.data!) //{
        return parsedData.lines.sorted(by: {$0.outer > $1.outer})
    }
    
    func dataToShiftedLineNomogram() -> [LinedObject]? {
        guard self.data != nil else { return nil }
        let decoder = JSONDecoder()
        if let parsedData = try? decoder.decode(ShiftedLine.self, from: self.data!) {
            //print(parsedData)
            return parsedData.lines.sorted(by: {$0.in > $1.in})
        }
        return nil
    }
  
}
