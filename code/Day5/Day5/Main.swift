//
//  Main.swift
//  Day5
//
//  Created by A Avinash Chidambaram on 14/09/25.
//
import Metal

@main
struct Day5 {
    static func main() {
        let device = MTLCreateSystemDefaultDevice()!

        guard let library = device.makeDefaultLibrary() else {
            fatalError("Unable to create default shader library")
        }

        print("success")

        for name in library.functionNames {
            let function = library.makeFunction(name: name)!
            print("\(function)")
        }
    }
}
  // call entry point

