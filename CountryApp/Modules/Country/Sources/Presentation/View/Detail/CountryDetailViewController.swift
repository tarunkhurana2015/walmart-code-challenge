//
//  CountryDetailViewController.swift
//  
//
//  Created by Tarun Khurana on 6/11/24.
//

import UIKit

class CountryDetailViewController: UIViewController {

    let countryEntity: CountryEntity
    
    init(countryEntity: CountryEntity) {
        self.countryEntity = countryEntity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView()  {
        view.backgroundColor = .systemBackground
        
        // Image
        let imageView = UIImageView()
        self.view.addSubview(imageView)
        Task {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://static.magflags.net/media/catalog/product/cache/75170699113cf9b1963820a3ea1bab40/T/H/TH-94.png")!)
            await MainActor.run {
                imageView.image = UIImage(data: data)
            }
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // contraints
        NSLayoutConstraint.activate([            
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0)
        ])
        
        /*
         {
           "capital": "Kabul",
           "code": "AF",
           "currency": {
             "code": "AFN",
             "name": "Afghan afghani",
             "symbol": "؋"
           },
           "flag": "https://restcountries.eu/data/afg.svg",
           "language": {
             "code": "ps",
             "name": "Pashto"
           },
           "name": "Afghanistan",
           "region": "AS"
         }
         */
        // Data
        let label = UILabel()
        label.text = countryEntity.name
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textColor = .systemPurple
        label.adjustsFontForContentSizeCategory = true
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            label.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
