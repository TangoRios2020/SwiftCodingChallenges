import UIKit

/*:
String 01: Are the letters unique?
 */

func challenge01a(input: String) -> Bool {
    var usedLetters = [Character]()
    for letter in input {
        if usedLetters.contains(letter) {
            return false
        }
        usedLetters.append(letter)
    }
    return true
}

func challenge01b(input: String) -> Bool {
    return Set(input).count == input.count
}

challenge01b(input: "He World")
challenge01b(input: "Hello World")

/*:
 String 02: Is a string a palindrome?
 */

func challenge02(input: String) -> Bool {
    let lowcase = input.lowercased()
    return lowcase.reversed() == Array(lowcase)
}

challenge02(input: "abbaac")
challenge02(input: " ")
challenge02(input: "Abba")

/*:
String 3: Do two strings contain the same characters?
*/

func challenge03(string1: String, string2: String) -> Bool {
    let array1 = Array(string1)
    let array2 = Array(string2)
    return array1.sorted() == array2.sorted()
}

challenge03(string1: "abacaadsa", string2: "abacaaasd")
challenge03(string1: "abacaadsa", string2: "abaca")
challenge03(string1: "a ab ", string2: "aba  ")

/*:
 String 4: Does one string contain another?
  cannot use contains
 */

extension String {
    func fuzzyContains(_ string: String) -> Bool {
        return self.uppercased().range(of: string.uppercased()) != nil
    }
}

"Hello, world".fuzzyContains("WORL")

/*:
 Challenge 5: Count the characters
 Write a function that accepts a string, and returns how many times a specific character appears,
 taking case into account
 */

func challenge05a(input: String, count: Character) -> Int {
    var letterCount = 0
    for letter in input {
        if letter == count {
            letterCount += 1
        }
    }
    return letterCount
}

challenge05a(input: "Hello world", count: "o")
challenge05a(input: "HellO world", count: "o")

func challenge05b(input: String, count: Character) -> Int {
    return input.reduce(0) {
        $1 == count ? $0 + 1 : $0
    }
}

challenge05b(input: "Hello world", count: "o")
challenge05b(input: "HellO world", count: "o")

func challenge05c(input: String, count: Character) -> Int {
    let array = input.map { String($0) }
    let counted = NSCountedSet(array: array)
    return counted.count(for: count)
}

challenge05c(input: "Hello world", count: "o")
challenge05c(input: "HellO world", count: "o")

/*:
 Challenge 6: Remove duplicate letters from a string
 */

func challenge06a(string: String) -> String {
    let array = string.map { String($0) }
    let set = NSOrderedSet(array: array)
    let letters = Array(set) as! Array<String>
    return letters.joined()
}

challenge06a(string: "asdadadsdasasdasdadasg")

func challenge06b(string: String) -> String {
    var used = [Character]()
    for letter in string {
        if !used.contains(letter) {
            used.append(letter)
        }
    }
    return String(used)
}

challenge06b(string: "asdadadsdasasdasdadasg")

// special way, readable by slowly 3x with second way.
func challenge06c(string: String) -> String {
    var used = [Character: Bool]()
    let result = string.filter {
        // only those return nil for updateValue are used
        // in the return array
        used.updateValue(true, forKey: $0) == nil
    }
    return String(result)
}

challenge06c(string: "asdadadsdasasdasdadasg")

/*:
 Challenge 7: Condense whitespace

 ####etc. The string “a[space][space][space]b[space][space][space]c” should return “a[space]b[space]c”.
 ####The string “[space][space][space][space]a” should return “[space]a”.
 */

func challenge07a(input: String) -> String {
    var seenSpace = false
    var returnValue = ""
    
    for letter in input {
        if letter == " " {
            if seenSpace { continue }
            seenSpace = true
        } else {
            seenSpace = false
        }
        returnValue.append(letter)
    }
    
    return returnValue
}

challenge07a(input: "  s  d  ")

func challenge07b(input: String) -> String {
    // “ +” means “match one or more spaces”
    return input.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
}

challenge07b(input: "  s  d  ")

/*:
 Challenge 8: String is rotated
 
 #### "abc" and "a" should return false
 */

func challenge08a(input1: String, input2: String) -> Bool {
    guard input1.count == input2.count else { return false }
    let combined = input1 + input1
    return combined.contains(input2)
}

challenge08a(input1: "catcat", input2: "catcat")
challenge08a(input1: "abcde", input2: "eabcd")
challenge08a(input1: "abc", input2: "a")

/*:
 Challenge 9: Find pangrams
 */

func challenge09(input: String) -> Bool {
    let set = Set(input.lowercased())
    let letters = set.filter { $0 >= "a" && $0 <= "z" }
    return letters.count == 26
}

challenge09(input: "The quick brown fox jumps over the lazy dog")
challenge09(input: "The quick brown fox jumped over the lazy dog")

/*:
 Challenge 10: Vowels and consonants
 */

func challenge10a(input: String) -> (vowels: Int, consonants: Int) {
    let vowels = CharacterSet(charactersIn: "aeiou")
    let consonants = CharacterSet(charactersIn: "bcdfghjklmnpqrstvwxyz")
    var vowelCount = 0
    var consonantCount = 0
    for letter in input.lowercased() {
        let stringLetter = String(letter)
        if stringLetter.rangeOfCharacter(from: vowels) != nil {
            vowelCount += 1
        } else if stringLetter.rangeOfCharacter(from: consonants) != nil {
            consonantCount += 1
        }
    }
    
    return (vowelCount, consonantCount)
}

challenge10a(input: "Masas")

func challenge10b(input: String) -> (vowels: Int, consonants: Int) {
    let vowels = "aeiou"
    let consonants = "bcdfghjklmnpqrstvwxyz"
    var vowelCount = 0
    var consonantCount = 0
    for letter in input.lowercased() {
    let stringLetter = String(letter)
       if vowels.contains(stringLetter) {
           vowelCount += 1
       } else if consonants.contains(stringLetter) {
           consonantCount += 1
       }
     }
    return (vowelCount, consonantCount)
}

challenge10b(input: "Masas")

/*:
 Challenge 11: Three different letters
 */

func challenge11(first: String, second: String) -> Bool {
    guard first.count == second.count else { return false }
    let firstArray = Array(first)
    let secondArray = Array(second)
    var differences = 0
    for (index, letter) in firstArray.enumerated() {
        if secondArray[index] != letter {
            differences += 1
            if differences == 4 {
                return false
            }
        }
    }
    return true
}

challenge11(first: "Clamp", second: "Crams")
challenge11(first: "Clampd", second: "Cransa")

/*:
 Challenge 12: Find longest prefix
 */

func challenge12(input: String) -> String {
    let parts = input.components(separatedBy: " ")
    guard let first = parts.first else { return "" }

    var currentPrefix = ""
    var bestPrefix = ""
    
    for letter in first {
        currentPrefix.append(letter)
        
        for word in parts {
            if !word.hasPrefix(currentPrefix) {
                return bestPrefix
            }
        }
        
        bestPrefix = currentPrefix
    }
    
    return bestPrefix
}

challenge12(input: "dogsf dogsa dogss")

/*:
 Challenge 13: Run-length encoding
 #### Write a function that accepts a string as input, then returns how often each letter is repeated in a single run, taking case into account.
 aaabaaabaaa --> a3b1a3b1a3
 aaAAaa --> a2A2a2
 */

// use a new string with lettercounter in
func challenge13(input: String) -> String {
    var returnValue = ""
    var letterCounter = 0
    let letterArray = Array(input)
    for i in 0 ..< letterArray.count {
        letterCounter += 1
        if i + 1 == letterArray.count || letterArray[i] != letterArray[i + 1] {
            returnValue += "\(letterArray[i])\(letterCounter)"
            letterCounter = 0
        }
    }
    return returnValue
}

challenge13(input: "aaDDCBADD")
challenge13(input: "  aaDDC  AA BADD")

/*:
 Challenge 14: String permutations
 */

func challenge14(string: String, current: String = "") {
    let length = string.count
    let strArray = Array(string)
    if (length == 0) {
        print("******")
    } else {
        print(current)
        for i in 0 ..< length {
            let left = String(strArray[0 ..< i])
            let right = String(strArray[i+1 ..< length])
            challenge14(string: left + right, current: current +
                String(strArray[i]))
        }
    }
}

challenge14(string: "abc", current: "a")

/*:
 Challenge 15: Reverse the words in a string
 */

func challenge15(input: String) -> String {
    let parts = input.components(separatedBy: " ")
    let reversed = parts.map {
        String($0.reversed())
    }
    return reversed.joined(separator: " ")
}

challenge15(input: "The quick brown fox")
