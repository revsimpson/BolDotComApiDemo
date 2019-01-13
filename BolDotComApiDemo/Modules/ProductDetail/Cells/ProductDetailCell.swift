//
//  ProductDetailCell.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit


protocol ButtonFromCellProtocol {
    func ButtonFromCellClickForText(text:String)
}

class ProductDetailCell: UITableViewCell {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pager: UIPageControl!
    @IBOutlet var decscriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var extraInfoLabel: UILabel!
    @IBOutlet var prijsLabel: UILabel!
    @IBOutlet var beschikbaarHeidLabel: UILabel!
    @IBOutlet var wishlistImage: UIImageView!
    
    @IBOutlet var ratingImage: UIImageView!
    
    private var productTitel = ""
    private var _frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    private var leesmeerButtonText = ""
    
    var delegate: ButtonFromCellProtocol!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        _addWishlistTapGesture()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc private func _wishlistTapped() {
        
        let alert = UIAlertController(title: "Wishlist", message: "\(productTitel) is aan je wishlist toegevoegd.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion:nil)
        
    }
    
    private func _addWishlistTapGesture() {
        
        let wishlistTabGesture =  UITapGestureRecognizer(target: self, action: #selector(_wishlistTapped))
        wishlistImage.addGestureRecognizer(wishlistTabGesture)
        
    }
    
    private func _initPagerWith(images:[String]) {
        
        let subViews = self.scrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
        pager.backgroundColor = UIColor.white
        pager.layoutIfNeeded()
        pager.numberOfPages = images.count
        for index in 0..<images.count {
            _frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            _frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame:_frame)
            imgView.loadImageFrom(urlString: images[index])
            self.scrollView.addSubview(imgView)
        }
        pager.currentPage = 0 
        scrollView.clearsContextBeforeDrawing = true
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
        
    }

    
    @IBAction func winkelwagenButtonPressed(_ sender: UIButton) {
        
        ShoppingBasket.shared.addItem()
        let alert = UIAlertController(title: "Winkelwagen", message: "\(productTitel) in aan je winkelwagen toegevoegd.\n\nAantal artikelen in winkelwagen : \(ShoppingBasket.shared.getNumberOfItems())", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion:nil)
        
    }
    
    @IBAction func leesButtonPressed(_ sender: UIButton) {
        
        NavigationRetainer.shared.loadReadTextViewController()
        let readTextViewController = NavigationRetainer.shared.getReadTextViewController()
        readTextViewController.textForTextView = self.leesmeerButtonText
        NavigationRetainer.shared.getNavigationController().pushViewController(readTextViewController, animated: true)
        
    }

}


// MARK:  UIScrollViewDelegate
extension ProductDetailCell : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pager.currentPage = Int(pageNumber)
        
    }
    
}

// MARK: ProductDetailBaseCell
extension ProductDetailCell : ProductDetailBaseCellProtocol {
    
    func setData(data: Any) {
   
        let detailData = data as! ProductDetailModel
        productTitel = detailData.titel
        titleLabel.text = detailData.titel
        prijsLabel.text = detailData.price
        beschikbaarHeidLabel.text = detailData.availability
        extraInfoLabel.text = detailData.attributes?.compactMap({"\($0.label) : \($0.value)" }).joined(separator: " | ") ?? ""
        
        // Extension wordt aangeroepen om de rating van een product te zetten.
        ratingImage.setRatingImageWith(score: detailData.rating ?? 0)
        
        // COMMENT: Het kan voorkomen dat er geen afbeeldingen bij een artikel zitten
        if let images = detailData.images {
            _initPagerWith(images:images)
        }
        
        leesmeerButtonText = detailData.description
        decscriptionLabel.text = detailData.description
        
    }
}
