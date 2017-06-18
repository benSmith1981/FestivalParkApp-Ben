/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Details {
	public var de : De?
	public var en : En?
	public var fr : Fr?
	public var nl : Nl?
	public var it : It?
	public var es : Es?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let details_list = Details.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Details Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Details]
    {
        var models:[Details] = []
        for item in array
        {
            models.append(Details(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let details = Details(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Details Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["de"] != nil) { de = De(dictionary: dictionary["de"] as! NSDictionary) }
		if (dictionary["en"] != nil) { en = En(dictionary: dictionary["en"] as! NSDictionary) }
		if (dictionary["fr"] != nil) { fr = Fr(dictionary: dictionary["fr"] as! NSDictionary) }
		if (dictionary["nl"] != nil) { nl = Nl(dictionary: dictionary["nl"] as! NSDictionary) }
		if (dictionary["it"] != nil) { it = It(dictionary: dictionary["it"] as! NSDictionary) }
		if (dictionary["es"] != nil) { es = Es(dictionary: dictionary["es"] as! NSDictionary) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.de?.dictionaryRepresentation(), forKey: "de")
		dictionary.setValue(self.en?.dictionaryRepresentation(), forKey: "en")
		dictionary.setValue(self.fr?.dictionaryRepresentation(), forKey: "fr")
		dictionary.setValue(self.nl?.dictionaryRepresentation(), forKey: "nl")
		dictionary.setValue(self.it?.dictionaryRepresentation(), forKey: "it")
		dictionary.setValue(self.es?.dictionaryRepresentation(), forKey: "es")

		return dictionary
	}

}