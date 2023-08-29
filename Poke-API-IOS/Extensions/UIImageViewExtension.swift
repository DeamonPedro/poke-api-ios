//
//  UIImageViewExtension.swift
//  Poke-API-IOS
//
//  Created by Pedro Carneiro on 28/08/23.
//

import UIKit

extension UIImageView {
    func download(from imagePath: String) {
        var url = URL(string: imagePath)!
        URLSession.shared.dataTask(with: .init(url: url)) { data, _, error in
            if error != nil { return }

            if let data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else { return }
        }.resume()
    }
}
