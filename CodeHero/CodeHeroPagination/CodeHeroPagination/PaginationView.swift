//
//  PaginationView.swift
//  CodeHeroCharacters
//
//  Created by Rafael Escaleira on 17/07/21.
//

import UIKit

public class PaginationView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    
    private (set) var currentOffset: Int = 1
    public var maxOffset: Int = 4
    public var delegate: PaginationDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle(for: PaginationView.self).loadNibNamed("PaginationView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0)
        ])
        self.leftButton.addTarget(self, action: #selector(self.prevButtonHandler(_:)), for: .touchUpInside)
        self.rightButton.addTarget(self, action: #selector(self.nextButtonHandler(_:)), for: .touchUpInside)
    }
    
    public func setCurrentOffset(_ offset: Int) {
        self.currentOffset = offset
        self.pageTitle.text = "\(offset)"
    }
    
    @objc public func nextButtonHandler(_ sender: UIButton) {
        if currentOffset < maxOffset {
            currentOffset += 1
        } else {
            currentOffset = 1
        }
        self.pageTitle.text = "\(currentOffset)"
        self.delegate?.pagination(didSelected: currentOffset)
    }
    
    @objc public func prevButtonHandler(_ sender: UIButton) {
        if currentOffset > 1 {
            currentOffset -= 1
        } else {
            currentOffset = maxOffset
        }
        self.pageTitle.text = "\(currentOffset)"
        self.delegate?.pagination(didSelected: currentOffset)
    }
}
