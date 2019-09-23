//
//  KHTabBar.swift
//  KHTabBar
//
//  Created by kaho on 19/09/2019.
//  Copyright © 2019 kaho. All rights reserved.
//

import UIKit

public protocol KHTabBarDelegate: AnyObject {
    func tabBar(didSelectItemAt index: Int)
}

public struct KHTabBarItem {
    public let images: [UIImage]
    public let title: String
    public let selectedIconSize: CGSize
    public let normalIconSize: CGSize
    public let selectedElevation: CGFloat
    
    public init(
        images: [UIImage],
        title: String,
        selectedIconSize: CGSize = CGSize(width: 60, height: 54),
        normalIconSize: CGSize = CGSize(width: 45, height: 42),
        selectedElevation: CGFloat = 2
        )
    {
        self.images = images
        self.title = title
        self.selectedIconSize = selectedIconSize
        self.normalIconSize = normalIconSize
        self.selectedElevation = selectedElevation
    }
}

public class KHTabBar: UIView {

    public weak var delegate: KHTabBarDelegate? {
        didSet {
            notifyDelegate()
        }
    }
    
    public private(set) var selectedIndex: Int = 0 {
        didSet {
            for index in tabs.indices {
                let tab = tabs[index]
                tab.selected = index == selectedIndex
            }
        }
    }
    
    public var items = [KHTabBarItem]() {
        didSet {
            refreshTabs()
        }
    }
    
    public var font: UIFont? {
        didSet {
            for tab in tabs {
                tab.label.font = font
            }
        }
    }
    
    public var normalTextCorlor: UIColor? {
        didSet {
            for tab in tabs {
                tab.defaultTextColor = normalTextCorlor
            }
        }
    }
    public var selectedTextColor: UIColor? {
        didSet {
            for tab in tabs {
                tab.selectedTextColor = selectedTextColor
            }
        }
    }
    
    public var iconBaseColor: UIColor? = .white {
        didSet {
            for tab in tabs {
                tab.iconBaseColor = iconBaseColor
            }
        }
    }
    
    public var frameRate: Double = 30 {
        didSet {
            for tab in tabs {
                tab.frameRate = frameRate
            }
        }
    }
    
    public func selectTab(at index:Int, notifyingDelegate: Bool = true) -> Bool {
        if tabs.indices.contains(index) {
            selectedIndex = index
            if notifyingDelegate {
                notifyDelegate()
            }
            return true
        }
        return false
    }
    
    private var tabs = [KHTabView]()
    
    private func refreshTabs() {
        //clear old tabs
        for tab in tabs {
            tab.removeFromSuperview()
        }
        tabs.removeAll()
        
        for index in items.indices {
            let item = items[index]
            let newTabView = KHTabView()
            newTabView.selected = index == selectedIndex
            newTabView.item = item
            newTabView.defaultTextColor = normalTextCorlor
            newTabView.selectedTextColor = selectedTextColor
            newTabView.delegate = self
            newTabView.iconBaseColor = iconBaseColor
            newTabView.index = index
            addSubview(newTabView)
            tabs.append(newTabView)
        }
        
    }
    
    private func notifyDelegate() {
        delegate?.tabBar(didSelectItemAt: selectedIndex)
    }
    
    public override func layoutSubviews() {
        if tabs.count > 0 {
            let size = bounds.size
            let eachTabWidth = size.width / CGFloat(tabs.count)
            let height = size.height
            for i in tabs.indices {
                let tab = tabs[i]
                let x = eachTabWidth * CGFloat(i)
                tab.frame = CGRect(x: x, y: 0, width: eachTabWidth, height: height)
            }
        }
    }
}

extension KHTabBar: KHTabViewDelegate {
    fileprivate func tabViewTapped(_ view:KHTabView) {
        selectedIndex = view.index
        notifyDelegate()
    }
}


fileprivate protocol KHTabViewDelegate: AnyObject {
    func tabViewTapped(_ view:KHTabView)
}

public class KHTabView: UIView {
    
    var item: KHTabBarItem? {
        didSet {
            if let item = item {
                imageView.images = item.images
                label.text = item.title
            }
        }
    }
    
    var selectedTextColor: UIColor? {
        didSet {
            refreshLabelColor()
        }
    }
    var defaultTextColor: UIColor? {
        didSet {
            refreshLabelColor()
        }
    }
    
    var selected = false {
        didSet {
            if selected != oldValue {
                imageView.selected = selected
                animateToNewStatus()
            }
        }
    }
    
    var iconBaseColor: UIColor? = .white {
        didSet {
            iconBaseView.backgroundColor = iconBaseColor
        }
    }
    
    fileprivate weak var delegate: KHTabViewDelegate?
    
    var index: Int = 0
    
    var animationEnabled = false
    
    let label: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    var frameRate: Double = 30 {
        didSet {
            imageView.frameRate = frameRate
        }
    }
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        return view
    }()
    
    private let imageView = KHTabIconImageSequenceView()
    
    private let iconBaseView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 22))
        view.layer.cornerRadius = 11
        return view
    }()
    
    private let touchView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconBaseView)
        addSubview(iconContainer)
        iconContainer.addSubview(imageView)
        addSubview(label)
        addSubview(touchView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        touchView.addGestureRecognizer(tap)
    }
    
    func refreshLabelColor() {
        var color: UIColor?
        if selected {
            color = selectedTextColor ?? tintColor
        } else {
            color = defaultTextColor ?? .lightGray
        }
        label.textColor = color
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        let size = bounds.size
        let labelHeight: CGFloat = 12
        let labelBottomPadding: CGFloat = 8
        label.frame = CGRect(x: 0, y: size.height - labelHeight - labelBottomPadding, width: size.width, height: labelHeight)
        
        iconBaseView.frame = CGRect(x: (size.width - iconBaseView.frame.size.width)/2,
                                    y: label.frame.origin.y - iconBaseView.frame.size.height,
                                    width: iconBaseView.frame.size.width,
                                    height: iconBaseView.frame.size.height)
        layoutIcon()
        touchView.frame = bounds
    }
    
    private func layoutIcon() {
        let size = bounds.size
        if let item = item {
            let labelTop = label.frame.origin.y
            let iconWidth = selected ? item.selectedIconSize.width : item.normalIconSize.width
            let iconHeight = selected ? item.selectedIconSize.height : item.normalIconSize.height
            let x = (size.width - iconWidth) / 2
            let elevation: CGFloat = selected ? item.selectedElevation : 0
            let y = labelTop - iconHeight - elevation
            let iconFrame = CGRect(x: x, y: y, width: iconWidth, height: iconHeight)
            iconContainer.frame = iconFrame
            imageView.frame = iconContainer.bounds
        }
    }
    
    private func animateToNewStatus() {
        
        refreshLabelColor()
        
        guard item != nil else {
            return
        }
        

        UIView.animate(withDuration: imageView.duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [], animations: {
            self.layoutIcon()
        }, completion: nil)
//        UIView.animate(withDuration: imageView.duration, delay: 0, options: ., animations: {
//            self.layoutIcon()
//        }, completion: nil)
    }
    
    @objc private func tapped() {
        delegate?.tabViewTapped(self)
    }
    
}
