//
//  ViewController.swift
//  Poke-API-IOS
//
//  Created by Pedro Carneiro on 28/08/23.
//

import UIKit

class ViewController: UIViewController {
    private var pokemons: [Pokemon] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28,weight: .black)
        label.textColor = .black
        label.text = "Pokedex"
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = true
        table.register(PokeCell.self, forCellReuseIdentifier: PokeCell.id)
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        fetchPokeAPI()
    }
    
    private func addViewsInHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchPokeAPI() {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                for pokemonInfo in pokemonList.results {
                    self.fetchPokemonDetails(from: pokemonInfo.url)
                }
            } catch {
                print("Error decoding Pokémon data: \(error)")
            }
        }.resume()
    }
    
    private func fetchPokemonDetails(from url: String) {
        guard let pokemonURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: pokemonURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemons.append(pokemon)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding Pokémon details: \(error)")
            }
        }.resume()
    }
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCell.id, for: indexPath) as? PokeCell else {
            fatalError("error")
        }
        let pokemon = pokemons[indexPath.row]
        cell.setup(pokemon: pokemon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        let pokeView = PokeDetailsViewController()
        pokeView.pokemon = pokemon
        present(pokeView, animated: true, completion: nil)
    }
}

