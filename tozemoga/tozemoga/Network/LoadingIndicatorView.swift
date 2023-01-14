//
//  LoadingIndicatorView.swift
//  tozemoga
//
//  Created by Applanding Solutions on 2023-01-13.
//

import UIKit

class LoadingIndicatorView: UIActivityIndicatorView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    func configure(for view: UIView?, apiController: ApiController){
        guard let view = view else {return}
        view.addSubview(self)
        self.hidesWhenStopped = true
        self.center = view.center
        apiController.isLoadingObserver = loadingObserver()
    }
    
    private func loadingObserver() -> (Bool) -> Void {
        return { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                DispatchQueue.main.async {
                    self.startAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.stopAnimating()
                }
            }
        }
    }
}
