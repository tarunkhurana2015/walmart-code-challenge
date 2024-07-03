//
//  CountrySearchViewController.swift
//  
//
//  Created by Tarun Khurana on 5/21/24.
//

import UIKit
import Combine

enum MessageState {
    case searchNotFound(String)
    case error(Error)
    case loading
    case unknown
}
public class CountryViewController: UIViewController {

    private var viewModel: CountryViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    public let searchController = UISearchController(searchResultsController: nil)
    
    private var countries: [CountryEntity] = []
    private var messageState: MessageState = .unknown
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CountryCellTableViewCell.self, forCellReuseIdentifier: CountryCellTableViewCell.identifier)
        return tv
    }()
    
    // MARK: - Init
    public init(viewModel: CountryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        subscriptions.removeAll()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupUI()
        setupDataBindings()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Task {
            await viewModel.fetchCountries()
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    // MARK: - ViewModel Setup
    private func setupDataBindings() {
        viewModel.$viewState // The viewState changes will receive updates on the main thread as the viewModel is annotated with @Mainactor
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.messageState = .loading
                case let .loaded(countries):
                    self?.countries = countries
                case let .error(error):
                    self?.messageState = .error(error)
                }
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        
        viewModel.subject // The viewState changes will receive updates on the main thread as the viewModel is annotated with @Mainactor
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.messageState = .loading
                case let .loaded(countries):
                    self?.countries = countries
                case let .error(error):
                    self?.messageState = .error(error)
                }
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Search Setup
    private func setupSearchController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
}

// MARK: - UISearchResultsUpdating
extension CountryViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
            
        messageState = .searchNotFound(text)
        Task {
            await viewModel.filterCountries(with: text)
        }
    }
}

// MARK: - TableView Functions
extension CountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellTableViewCell.identifier, for: indexPath) as? CountryCellTableViewCell else {
            fatalError("Unable to dequeue CountryCell in CountryViewController")
        }
        cell.configure(with: countries[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countries.count == 0 {
            // displas the messages [empty or error]
            let (title, message) = getMessagesToDisplay()
            tableView.setEmptyView(title: title, message: message)
        } else {
            tableView.restore()
        }
        return countries.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailViewController(countryEntity: countries[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Messages handling
extension CountryViewController {
    func getMessagesToDisplay() -> (String, String){
        var title = ""
        var message = ""
        switch messageState {
        case .loading:
            title = "Loading..."
            message = ""
        case let .searchNotFound(text):
            title = "No county found with name or capital"
            message = text
        case let.error(error):
            title = "Error!!!"
            message = mapErrortoMessage(error: error)
        case .unknown:
            break
        }
        return (title, message)
    }
}

// MARK: - UITableView extension
extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.systemGray
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.systemRed
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
