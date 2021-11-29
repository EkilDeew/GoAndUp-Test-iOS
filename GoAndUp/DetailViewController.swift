//
//  DetailViewController.swift
//  GoAndUp
//
//  Created by Guillaume Fourrier on 26/02/2021.
//

import UIKit

class DetailViewController: UIViewController {
    var episode: Episode!
    //@IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var episodeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageHeightCst: NSLayoutConstraint!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageVw.sd_imageTransition = .fade
        imageVw.sd_setImage(with: episode.image.originalUrl, completed: nil)
        
        episodeLbl.text = episode.name
        descriptionLbl.text = episode.summary.htmlToString
        
        scrollView.delegate = self
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset

        print(offset)
        if offset.y < 0.0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset.y, 0)
            let scaleFactor = 1 + (-1 * offset.y / (imageVw.bounds.height / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            imageVw.layer.transform = transform
        } else {
            imageVw.layer.transform = CATransform3DIdentity
        }
    }
}
