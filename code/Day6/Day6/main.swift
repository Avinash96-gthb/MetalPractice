//
//  main.swift
//  Day6
//
//  Created by A Avinash Chidambaram on 14/09/25.
//

import Metal

let device = MTLCreateSystemDefaultDevice()!

guard let library = device.makeDefaultLibrary() else {
    fatalError("unable to create device")
}

let kernalFunction = library.makeFunction(name: "add_two_values")

let computePipelineState = try device.makeComputePipelineState(function: kernalFunction!)

let elementCount = 256

let inputBufferA = device.makeBuffer(length: MemoryLayout<Float>.stride * elementCount, options: .storageModeShared)!
let inputBufferB = device.makeBuffer(length: MemoryLayout<Float>.stride * elementCount, options: .storageModeShared)!
let outputBuffer = device.makeBuffer(length: MemoryLayout<Float>.stride * elementCount, options: .storageModeShared)!

let inputsA = inputBufferA.contents().assumingMemoryBound(to: Float.self)
let inputsB = inputBufferB.contents().assumingMemoryBound(to: Float.self)

for i in 0...elementCount{
    inputsA[i] = Float(i)
    inputsB[i] = Float(elementCount-i)
}

let commandQueue = device.makeCommandQueue()!
let commandBuffer = commandQueue.makeCommandBuffer()!
let commandEncoder = commandBuffer.makeComputeCommandEncoder()!
commandEncoder.setComputePipelineState(computePipelineState)

commandEncoder.setBuffer(inputBufferA, offset: 0, index: 0)
commandEncoder.setBuffer(inputBufferB, offset: 0, index: 1)
commandEncoder.setBuffer(outputBuffer, offset: 0, index: 2)

let threadsPerThreadGroup = MTLSize(width: 32, height: 1, depth: 1)
let threadGroupCount = MTLSize(width: 8, height: 1, depth: 1)

commandEncoder.dispatchThreadgroups(threadGroupCount, threadsPerThreadgroup: threadsPerThreadGroup)

commandEncoder.endEncoding()

commandBuffer.addCompletedHandler { _ in
    let outputs = outputBuffer.contents().assumingMemoryBound(to: Float.self)
    
    for i in 0...elementCount{
        print("the sum of the \(i) elements is: \(outputs[i])")
    }
}

commandBuffer.commit()
commandBuffer.waitUntilCompleted()


