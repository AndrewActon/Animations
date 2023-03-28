//
//  CardViewController.swift
//  Animations
//
//  Created by Andrew Acton on 3/27/23.
//

import UIKit

class CardViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var redCard: UIView!
    @IBOutlet weak var blueCard: UIView!
    @IBOutlet weak var greenCard: UIView!
    @IBOutlet weak var yellowCard: UIView!
    
    //MARK: - Properties
    let colors: [UIColor] = [#colorLiteral(red: 0.2748163255, green: 0.32274226, blue: 0.6258859536, alpha: 1), #colorLiteral(red: 0.5132867461, green: 0.397184957, blue: 0.6318057345, alpha: 1), #colorLiteral(red: 0.1043053627, green: 0.3372462951, blue: 0.2134244648, alpha: 1), #colorLiteral(red: 1, green: 0.7218256905, blue: 0.7202475223, alpha: 1), #colorLiteral(red: 0.5756922104, green: 1, blue: 0.950331072, alpha: 1)]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Actions
    
    @IBAction func redCardButtonTapped(_ sender: Any) {
        rotateRed()
    }
    
    @IBAction func blueCardButtonTapped(_ sender: Any) {
        flipBlue()
    }
    
    @IBAction func greenCardButtonTapped(_ sender: Any) {
        changeGreen()
    }
    
    @IBAction func yellowButtonTapped(_ sender: UIButton, forEvent event: UIEvent) {
        let touches = event.touches(for: sender)
        guard let touchPoint = touches?.first?.location(in: self.view) else { return }
        likeYellow(touchPoint: touchPoint)
    }
    
    //MARK: - Helper Methods
    
    func setupViews() {
        redCard.layer.cornerRadius = 8.0
        blueCard.layer.cornerRadius = 8.0
        greenCard.layer.cornerRadius = 8.0
        yellowCard.layer.cornerRadius = 8.0
    }
    
    func rotateRed() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.redCard.transform = self.redCard.transform.rotated(by: .pi/2)
        }
    }
    
    func flipBlue() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.blueCard.transform = self.blueCard.transform.scaledBy(x: -1, y: 1)
        }
    }
    
    func changeGreen() {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.view.backgroundColor = self.colors.randomElement()
        }
    }
    
    func likeYellow(touchPoint: CGPoint) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customVerticalPath(touchPoint: touchPoint).cgPath
        animation.duration = 2
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = #colorLiteral(red: 1, green: 0.6276533846, blue: 0.6913591501, alpha: 1)
        imageView.frame = CGRect(x: -40, y: 0, width: 40, height: 40)
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn) {
            imageView.alpha = 0
        } completion: { _ in
            imageView.removeFromSuperview()
        }
    }
    
    func customVerticalPath(touchPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        
        let pathLength = 400
        let curveLength = pathLength/4
        
        path.move(to: touchPoint)
        
        let endpoint = CGPoint(x: touchPoint.x, y: touchPoint.y - CGFloat(pathLength))
        
        let curve1 = CGPoint(x: touchPoint.x - 50, y: touchPoint.y - CGFloat(curveLength))
        
        let curve2 = CGPoint(x: touchPoint.x + 50, y: touchPoint.y - CGFloat(3 * curveLength))
        
        path.addCurve(to: endpoint, controlPoint1: curve1, controlPoint2: curve2)
        
        return path
    }
    
}//End Of Class
