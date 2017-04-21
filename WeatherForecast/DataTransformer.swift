

import Foundation
import SwiftDate

class DataTransformer {
    public func timeStringToDate(timeString: String, formatString: String) -> DateInRegion? {
        guard let dateInUTC = DateInRegion(string: timeString, format: .custom(formatString), fromRegion: Region.GMT()) else {
            return DateInRegion()
        }
        
        return dateInUTC
    }
}

