/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Festival {
	public var trcid : String?
	public var title : String?
	public var details : Details?
	public var types : Array<Types>?
	public var location : Location?
	public var urls : Array<String>?
	public var media : Array<Media>?
	public var dates : Dates?
	public var lastupdated : String?
	public var eigenschappen : Array<String>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let Festival_list = Festival.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Festival Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Festival]
    {
        var models:[Festival] = []
        for item in array
        {
            models.append(Festival(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let Festival = Festival(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Festival Instance.
*/
	required public init?(dictionary: NSDictionary) {

		trcid = dictionary["trcid"] as? String
		title = dictionary["title"] as? String
		if (dictionary["details"] != nil) { details = Details(dictionary: dictionary["details"] as! NSDictionary) }
		if (dictionary["types"] != nil) { types = Types.modelsFromDictionaryArray(array: dictionary["types"] as! NSArray) }
		if (dictionary["location"] != nil) { location = Location(dictionary: dictionary["location"] as! NSDictionary) }
        // TODO: unescape urls
		if (dictionary["urls"] != nil) { urls = dictionary["urls"] as? Array<String> }
		if (dictionary["media"] != nil) { media = Media.modelsFromDictionaryArray(array: dictionary["media"] as! NSArray) }
		if (dictionary["dates"] != nil) { dates = Dates(dictionary: dictionary["dates"] as! NSDictionary) }
		lastupdated = dictionary["lastupdated"] as? String
		// TODO: maybe parse "eigenschappen" property
        //if (dictionary["eigenschappen"] != nil) { eigenschappen = Eigenschappen.modelsFromDictionaryArray(dictionary["eigenschappen"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.trcid, forKey: "trcid")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.details?.dictionaryRepresentation(), forKey: "details")
		dictionary.setValue(self.location?.dictionaryRepresentation(), forKey: "location")
		dictionary.setValue(self.dates?.dictionaryRepresentation(), forKey: "dates")
		dictionary.setValue(self.lastupdated, forKey: "lastupdated")

		return dictionary
	}

    
    /// Loads the main image of the selection 
    ///
    /// - Returns: ""
    func getMainMedia() -> String {
        guard let media = self.media else {
            return ""
        }
        
        for mediaEntry in media {
            if let isEntryMain = mediaEntry.main {
                if isEntryMain == "true" {
                    return mediaEntry.url ?? ""
                }
            }
        }
        return ""
    }
    
    fileprivate static func getCategoryFromText(_ text: String) -> EventCategory {
        if text.containsAnyOf(["eten", "drinken", "food", "restaurant", "bar"]) {
            return .food
        }
        if text.containsAnyOf(["dance", "muziek", "music", "dj", "zanger", "jazz", "trance", "concert", "club"]) {
            return .dance
        }
        if text.containsAnyOf(["kunst", "theater", "film", "foto", "cabaret"]) {
            return .art
        }
        if text.containsAnyOf(["sport", "sneaker", "voetbal", "Bootcamp"]) {
            return .sport
        }
        
        return .festival
    }
    
    func getCategory() -> EventCategory {
        guard let title = self.title else {
            return .festival
        }
        let category = Festival.getCategoryFromText(title)
        if category != .festival {
            return category
        }
        
        // Try to extract info from description
        guard let description = self.details?.nl?.shortdescription else {
            return .festival
        }
        return Festival.getCategoryFromText(description)
    }
}
