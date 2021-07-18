//
//  UIImageViewExtension.swift
//  CodeHeroAPI
//
//  Created by Rafael Escaleira on 17/07/21.
//

import UIKit

public extension UIImageView {
    private func downloaded(from url: URL,
                            contentMode mode: UIView.ContentMode = .scaleAspectFill,
                            activityIndicator: UIActivityIndicatorView? = nil) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async() { [weak self] in
                    self?.image = UIImage(systemName: "")
                    activityIndicator?.stopAnimating()
                }
            }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                activityIndicator?.stopAnimating()
            }
        }.resume()
    }
    
    func downloaded(from url: String,
                    contentMode mode: UIView.ContentMode = .scaleAspectFill,
                    activityIndicator: UIActivityIndicatorView? = nil) {
        guard let url = URL(string: url) else { return }
        downloaded(from: url, contentMode: mode, activityIndicator: activityIndicator)
    }
}
