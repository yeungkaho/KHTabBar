//
//  ImageSequencePlayerView.swift
//  KHTabBar
//
//  Created by kaho on 20/09/2019.
//  Copyright © 2019 kaho. All rights reserved.
//

import UIKit

class KHTabIconImageSequenceView: UIView {
    let imageView = UIImageView()
    
    var images = [UIImage]() {
        didSet {
            imageView.image = selected ? images.last : images.first
            currentIndex = selected ? images.count - 1 : 0
        }
    }
    
    var selected = false
    
    var currentIndex: Int = 0
    
    var timer: Timer?
    
    var frameRate: Double = 30 {
        didSet {
            if frameRate != oldValue {
                setUpTimer()
            }
        }
    }
    
    var duration: TimeInterval {
        return Double(images.count) / frameRate
    }
    
    override var frame: CGRect {
        didSet {
            imageView.frame = bounds
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setUpTimer()
    }
    
    func setUpTimer() {
        timer?.invalidate()
        timer = Timer(timeInterval: 1 / frameRate, repeats: true, block: {
            [weak self] (_) in
            self?.update()
        })
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        if selected {
            if images.count - 1 <= currentIndex {
                //already at end
                return
            }
            currentIndex += 1
        } else {
            if currentIndex <= 0 {
                return
            } else {
                currentIndex -= 1
            }
        }
        
        updateImage()
    }
    
    private func updateImage() {
        imageView.image = images[currentIndex]
    }
    
    deinit {
        timer?.invalidate()
    }
}
