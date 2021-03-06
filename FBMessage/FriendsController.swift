//
//  ViewController.swift
//  FBMessage
//
//  Created by Mateus Marques on 27/12/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
}

class FriendCell: BaseCell {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friends message and something else..."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override func setupViews() {
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "mark-zuckerberg")
        hasReadImageView.image = UIImage(named: "mark-zuckerberg")
        
        addConstraints(withFormat: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraints(withFormat: "V:[v0(68)]", views: profileImageView)
        
        addConstraints([NSLayoutConstraint(item: profileImageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        
        addConstraints(withFormat: "H:|-82-[v0]|", views: dividerLineView)
        addConstraints(withFormat: "V:[v0(1)]|", views: dividerLineView)
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraints(withFormat: "H:|-90-[v0]|", views: containerView)
        addConstraints(withFormat: "V:[v0(50)]", views: containerView)
        
        addConstraints([NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraints(withFormat: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstraints(withFormat: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraints(withFormat: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
        containerView.addConstraints(withFormat: "V:|[v0(24)]", views: timeLabel)
        containerView.addConstraints(withFormat: "V:[v0(20)]|", views: hasReadImageView)
    }
}

extension UIView {
    func addConstraints(withFormat format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
    }
}
