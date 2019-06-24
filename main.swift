//
//  main.swift
//  Crawl
//
//  Created by Mona Shamsolebad on 2019-06-23.
//  Copyright © 2019 Mona Shamsolebad. All rights reserved.
//


import Foundation

var directoryCount = 0
var fileCount = 0
func directoryExistsAtPath(_ path: String) -> Bool {
    var isDirectory = ObjCBool(true)
    let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
    return exists && isDirectory.boolValue
}

func crawl(_ path : String){
    if directoryExistsAtPath(path) {
        crawlRecursive(path, 1, false)
        print("\(directoryCount) directories, \(fileCount) files")
    }
    else {
        print("Directory does not exist!!")
    }
    
}

func crawlRecursive(_ path: String ,_ level : Int , _ isLast : Bool){
    let fileManager = FileManager.default
    for  _ in 1..<level {
        
        print("|\t" , terminator: "")
    }
    if isLast {
        print("└─ ", terminator: "")
    }
    else {
        print("├─ " , terminator: "")
    }
    let parts = path.split(separator: "/")
    
    print(parts[parts.count - 1])
    if directoryExistsAtPath(path) {
        directoryCount += 1
        do {
            let content = try  fileManager.contentsOfDirectory(atPath : path )
            for i in 0..<content.count {
                
                var newPath = path
                if path.last != "/" {
                    newPath =  path + "/"
                }
                let itemPath = newPath + content[i]
                let isLast = i == content.count - 1
                crawlRecursive(itemPath, level + 1, isLast)
            }
            
        }
        catch {
            print("error")
        }
    }
    else {
        fileCount += 1
    }
}



if CommandLine.argc < 2 {
    print("Please specify a path!!")
    exit(0)
}

let path = CommandLine.arguments[1]
print(" Crawling... \(path)")
crawl(path)



