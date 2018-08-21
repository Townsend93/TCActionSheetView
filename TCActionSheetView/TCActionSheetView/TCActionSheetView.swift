//
//  TCActionSheetView.swift
//  TCActionSheetView
//
//  Created by tancheng on 2018/7/17.
//  Copyright © 2018年 tancheng. All rights reserved.
//

import Foundation
import UIKit



protocol TCActionSheetViewDelegate: class {
    func actionSelected(index: Int)
}

class TCActionSheetView: UIView, UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate  {
    
    private var tableView: UITableView!
    
    private var actions: [(String)]
    
    weak var delegate: TCActionSheetViewDelegate?
    
    private var bgView: UIView!
    
    private let animDuration = 0.25
    
    init(actions:[(String)], delegate: TCActionSheetViewDelegate?) {
        self.actions = actions
        self.delegate = delegate
        super.init(frame: UIScreen.main.bounds)
    
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        bgView = UIView(frame: bounds)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        addSubview(bgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        bgView.addGestureRecognizer(tap)
        
        let height = actions.count * 50 + 10 + 50
        
        tableView = UITableView(frame: CGRect(x: 0, y: bounds.height - CGFloat(height), width: UIScreen.main.bounds.size.width, height: CGFloat(height)), style: .plain)
        
        tableView.backgroundColor = UIColor.clear
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorInset = UIEdgeInsetsMake(0, -15, 0, 0)
    
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(TCActionSheetCell.self, forCellReuseIdentifier: "TCActionSheetCell")
        
        tableView.isScrollEnabled = false
        
        tableView.showsVerticalScrollIndicator = false
        
        addSubview(tableView)
        
    }
    
    //MARK: ACTION

    func show() {
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(self)
        
        let toFrame = tableView.frame
        var fromFrame = tableView.frame
        fromFrame.origin.y = bounds.size.height
        tableView.frame = fromFrame
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            
            self?.tableView.frame = toFrame
            self?.bgView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            
        }) { (finished) in
            
        }
        
    }
    
   @objc private func dismiss() {
    
    var toFrame = tableView.frame
    toFrame.origin.y = bounds.size.height
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
        
        self?.tableView.frame = toFrame
        self?.bgView.backgroundColor = UIColor.black.withAlphaComponent(0)
        
    }) { [weak self] (finished) in
        self?.tableView.removeFromSuperview()
        self?.bgView.removeFromSuperview()
        self?.removeFromSuperview()
        self?.tableView = nil
        self?.bgView = nil
    }
        
    }
    
    //CAAnimationDelaget
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            tableView.layer.removeAllAnimations()
            bgView.layer.removeAllAnimations()
            tableView.removeFromSuperview()
            bgView.removeFromSuperview()
            removeFromSuperview()
            tableView = nil
            bgView = nil
        }
    }
    
    deinit {
        //print("\(TCActionSheetView.self) --- deinit")
    }
    
    //MARK: tableviewDatesource & delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? actions.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return section == 0 ? footer : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCActionSheetCell", for: indexPath) as! TCActionSheetCell
        
        cell.titleLab.text = indexPath.section == 0 ? actions[indexPath.row] : "取消"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else {
            dismiss()
            return
        }
        delegate?.actionSelected(index: indexPath.row)
        dismiss()
    }
    
    
}

class TCActionSheetCell: UITableViewCell {
    
    lazy var titleLab: UILabel = {
       
        let lab = UILabel()
        lab.textColor = UIColor(red: 45/255.0, green: 50/255.0, blue: 49/255.0, alpha: 1)
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textAlignment = .center
        
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLab)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLab.frame = bounds
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


