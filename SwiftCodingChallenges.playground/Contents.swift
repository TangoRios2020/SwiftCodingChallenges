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
