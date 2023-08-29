//
//  PokeCell.swift
//  Poke-API-IOS
//
//  Created by Pedro Carneiro on 28/08/23.
//
import UIKit

class PokeCell: UITableViewCell {
    
    static let id = "PokeCell"
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemGray3
        stack.layer.cornerRadius = 16
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let coverView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.layer.masksToBounds = true
        return iView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addViewsInHierarchy()
        setupConstraints()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    public func setup(pokemon: Pokemon) {
        titleLabel.text = pokemon.name
        descriptionLabel.text = "Tipos:" + pokemon.types.map({$0.type.name}).joined(separator: ", ")
        coverView.download(from: pokemon.sprites.front_default)
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func addViewsInHierarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(coverView)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            verticalStack.topAnchor.constraint(equalTo: horizontalStack.topAnchor, constant: 8),
            verticalStack.bottomAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            coverView.widthAnchor.constraint(equalToConstant: 60),
            coverView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
