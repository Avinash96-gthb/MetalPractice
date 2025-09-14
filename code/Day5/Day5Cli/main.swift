//
//  main.swift
//  Day5Cli
//
//  Created by A Avinash Chidambaram on 14/09/25.
//
import Metal

let device = MTLCreateSystemDefaultDevice()!

guard let library = device.makeDefaultLibrary() else {
    fatalError("Unable to create default shader library")
}

for name in library.functionNames {
    let function = library.makeFunction(name: name)!
    print("\(function)")
}
