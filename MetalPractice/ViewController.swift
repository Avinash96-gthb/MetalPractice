//
//  ViewController.swift
//  MetalPractice
//
//  Created by A Avinash Chidambaram on 13/08/25.
//

import Cocoa
import Metal
import MetalKit

class ViewController: NSViewController, MTKViewDelegate {
    
    
    @IBOutlet weak var metalView: MTKView!
    var device: MTLDevice!
    var commandQueu: MTLCommandQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        device = MTLCreateSystemDefaultDevice()
        metalView.device = device
        metalView.clearColor = MTLClearColor(red: 0, green: 0.1, blue: 1, alpha: 1)
        metalView.delegate = self
        commandQueu = device.makeCommandQueue()

        // Do any additional setup after loading the view.
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        let commandBuffer = commandQueu.makeCommandBuffer()
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            print("error lol dropping frames")
            return
        }
        let renderPassEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderPassEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

