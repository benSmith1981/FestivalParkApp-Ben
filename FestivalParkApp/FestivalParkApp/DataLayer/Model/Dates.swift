/*
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public enum Dates: Comparable {
    case singles(Array<String>)
    case period(String, String)
    
/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let dates_list = Dates.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Dates Instances.
*/
    public static func modelsFromDictionaryArray(array:NSArray) -> [Dates]
    {
        var models:[Dates] = []
        for item in array
        {
            models.append(Dates(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let dates = Dates(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Dates Instance.
*/
	public init?(dictionary: NSDictionary) {

        func removeLast5(_ str: String) -> String {
            let endIndex = str.index(str.endIndex, offsetBy: -5)
            return str.substring(to: endIndex)
        }
 
        if (dictionary["singles"] != nil) {
            let tempSingles = dictionary["singles"] as? Array<String>
            
            var singleDates = [String]()
            for date in tempSingles ?? [] {
                let strippedDate = removeLast5(date)
                singleDates.append(strippedDate)
            }
            
            // Some of the festivals come with unordered singles dates
            singleDates = singleDates.sorted(by: { (lhs, rhs) -> Bool in
                let lhsDate = Date(lhs)
                let rhsDate = Date(rhs)
                
                if lhsDate == nil {
                    return false
                }
                if rhsDate == nil {
                    return true
                }
                
                return lhsDate! < rhsDate!
            })
            self = .singles(singleDates)
        } else if (dictionary["startdate"] != nil && dictionary["enddate"] != nil) {
            let startDate = removeLast5(dictionary["startdate"] as? String ?? "")
            let endDate = removeLast5(dictionary["startdate"] as? String ?? "")
            
            self = .period(startDate, endDate)
        } else {
            return nil
        }
	}
    
    func getFirstDate() -> String {
        switch self {
        case let .singles(singleDates):
            return singleDates[0]
        case let .period(startDate, _):
            return startDate
        }
    }

    func getLastDate() -> String {
        switch self {
        case let .singles(singleDates):
            let endIndex = singleDates.count-1
            return singleDates[endIndex]
        case let .period(_, endDate):
            return endDate
        }
    }

    func getDatesSpan() -> (String, String) {
        return (self.getFirstDate(), self.getLastDate())
    }
    
    struct Date: Comparable {
        var day: Int
        var month: Int
        
        // Initialize from "DD-MM" format
        init?(_ dateString: String) {
            guard dateString.characters.count == 5 else {
                return nil
            }
            
            let dayStr = dateString.substring(to: dateString.index(dateString.startIndex, offsetBy: 2))
            let monthStr = dateString.substring(from: dateString.index(dateString.startIndex, offsetBy: 3))
            if let day = Int(dayStr),
                let month = Int(monthStr) {
                self.day = day
                self.month = month
            } else {
                return nil
            }
        }

        public static func < (lhs: Date, rhs: Date) -> Bool {
            if lhs.month == rhs.month {
                return lhs.day < rhs.day
            }
            return lhs.month < rhs.month
        }
        
        public static func == (lhs: Date, rhs: Date) -> Bool {
            return lhs.month == rhs.month && lhs.day == rhs.day
        }
    }

    public static func < (lhs: Dates, rhs: Dates) -> Bool {
        let lhsFirstDate = Date.init(lhs.getFirstDate())
        let rhsFirstDate = Date.init(rhs.getFirstDate())
        
        if lhsFirstDate == nil {
            return false
        }
        if rhsFirstDate == nil {
            return true
        }
        
        if lhsFirstDate! == rhsFirstDate! {
            // Sort by last date
            let lhsLastDate = Date.init(lhs.getLastDate())
            let rhsLastDate = Date.init(rhs.getLastDate())

            if lhsLastDate == nil {
                return false
            }
            if rhsLastDate == nil {
                return true
            }

            return lhsLastDate! < rhsLastDate!
        }
        return lhsFirstDate! < rhsFirstDate!
    }
    
    public static func == (lhs: Dates, rhs: Dates) -> Bool {
        return lhs.getDatesSpan() == rhs.getDatesSpan()
    }
    
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()


		return dictionary
	}

}
