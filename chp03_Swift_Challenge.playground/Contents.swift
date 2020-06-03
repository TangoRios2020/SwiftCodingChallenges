import UIKit

// files

/// challenge 27 Print last Lines
/*
 Antony And Cleopatra
 Coriolanus
 Cymbeline
 Hamlet
 Julius Caesar
 King Lear
 Macbeth
 Othello
 Twelfth Night
 • If asked to print the last 3 lines, your code should output “Twelfth Night, Othello, Macbeth”.
 • If asked to print the last 100 lines, your code should output “Twelfth Night, Othello, Macbeth, King Lear, Julius Caesar, Hamlet, Cymbeline, Coriolanus, Antony and Cleopatra”.
 • If asked to print the last 0 lines, your could should print nothing.
 * 接收行数参数
 */

func challenge27(fileName: String, lineCount: Int) {
    guard let input = try? String(contentsOfFile: fileName) else { return }
    var lines = input.components(separatedBy: "\n")
    guard lines.count > 0 else { return }
    // 翻转
    lines.reverse()
    for i in 0 ..< min(lines.count, lineCount) {
        print(lines[i])
    }
}

/* Challenge 28 Log a message
 * Write a logging function that accepts accepts a path to a log file on disk as well as a new log message.
 Your function should open the log file (or create it if it does not already exist), then append the new
 message to the log along with the current time and date.
 Tip: It’s important that you add line breaks along with each message, otherwise the log will just become jumbled.
 */

func challenge28(log message: String, to logFile: String) {
    // 从本地路径中读取对应的值, 并设置一个 默认值
    var existingLog = (try? String(contentsOfFile: logFile)) ?? ""
    
    // 追加记录
    existingLog.append("\(Date()): \(message)\n")
    
    // 写入文件
    do {
        try existingLog.write(toFile: logFile, atomically: true, encoding: .utf8)
    } catch {
        print("failed to write to log: \(error.localizedDescription)")
    }
}

/**
 Challenge 29: Documents directory
 Write a function that returns a URL to the user’s documents directory.
 Sample input and output
 • Your function should need no input, and return a URL pointing to /Users/ yourUserName/Documents on macOS, and /path/to/container/Documents on iOS.
 */

func challenge29() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

/*
 * Challenge 30 New JPEGs
 Write a function that accepts a path to a directory and returns an array of all JPEGs that have
 been created in the last 48 hours.
 Tip #1: For the purpose of this task, just looking for “.jpg” and “.jpeg” file extensions is sufficient.
 Tip #2: For this challenge, assume time is regular and constant, i.e. the user has not changed their timezone or moved into or out from daylight savings.
 Tip #3: Use the terminal command touch -t YYYYMMDDHHMM somefile.jpg to adjust the creation time of a file, e.g. touch -t 201612250101.
 Sample input and output
 • If your directory contains three JPEGs older than 48 hours and three newer, your function should return the names of the three newer.
 先将 JPEG 按照时间存储, 然后查找
 */

func challenge30(in directory: String) -> [String] {
    let fm = FileManager.default
    let directoryURL = URL(fileURLWithPath: directory)
    guard let files = try? fm.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil) else { return [] }
    
    var jpegs = [String]()
    for file in files {
        if file.pathExtension == "jpg" || file.pathExtension == "jpeg" {
            guard let attributes = try? fm.attributesOfItem(atPath: file.path) else { continue }
            guard let creationDate = attributes[.creationDate] as? Date else { continue }
            if creationDate > Date(timeIntervalSinceNow: -60 * 60 * 48) {
                jpegs.append(file.lastPathComponent)
            }
        }
    }
    return jpegs
}
