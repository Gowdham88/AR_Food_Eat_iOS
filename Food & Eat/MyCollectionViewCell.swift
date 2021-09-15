//
//  MyCollectionViewCell.swift
//  Food & Eat
//
//  Created by Paramesh V on 24/09/18.
//  Copyright © 2018 Paramesh V. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupView()
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.backgroundColor = UIColor.gray
        return image
    }()


    var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = UIFont(name: "Avenir-Light", size: 25.0)
        label.contentMode = .scaleAspectFill
//        label.center = CGPoint(x: 160, y: 284)

        
        label.backgroundColor = UIColor(patternImage: UIImage(named: "FALTBREADS")!)
//        label.text = "New Person"
        


        return label
    }()
    
    var textName :UITextView = {
        
       let text = UITextView()
        text.textColor = .black
        text.frame = CGRect(x: 0, y: 400, width: 100, height: 125)
        text.font = UIFont(name: "Avenir-Light", size: 25.0)
        text.text = "my new prouct"
        text.contentMode = .scaleAspectFit
        return text
        
    }()
    
    
    
//
    func  setupView(){
        addSubview(imageView)
//        addSubview(textLabel)
//        addSubview(textName)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 400)
//
//        print("imageview\(imageView.frame)")
//        textLabel.frame =  CGRect(x: 0, y: 410, width: 100, height: 40)
//
        

//        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
//        textLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        textLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }
//
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
