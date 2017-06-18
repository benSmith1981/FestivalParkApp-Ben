/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Location {
	public var name : String?
	public var city : String?
	public var adress : String?
	public var zipcode : String?
	public var latitude : String?
	public var longitude : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let location_list = Location.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Location Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Location]
    {
        var models:[Location] = []
        for item in array
        {
            models.append(Location(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let location = Location(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Location Instance.
*/
	required public init?(dictionary: NSDictionary) {

		name = dictionary["name"] as? String
		city = dictionary["city"] as? String
		adress = dictionary["adress"] as? String
		zipcode = dictionary["zipcode"] as? String
		latitude = dictionary["latitude"] as? String
		longitude = dictionary["longitude"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.city, forKey: "city")
		dictionary.setValue(self.adress, forKey: "adress")
		dictionary.setValue(self.zipcode, forKey: "zipcode")
		dictionary.setValue(self.latitude, forKey: "latitude")
		dictionary.setValue(self.longitude, forKey: "longitude")

		return dictionary
	}

}