import UIKit

class PokeDetailsViewController: UIViewController {
    var pokemon: Pokemon!
    
    private let coverView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.layer.masksToBounds = true
        iView.contentMode = .scaleAspectFill
        return iView
    }()
    
    private let bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .systemGray3
        stack.layer.cornerRadius = 32
        
        return stack
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 4
        return stack
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attrString = NSMutableAttributedString(string: "description")
        attrString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.sizeToFit()
        
        return label
    }()
    
    private let boldAttribute: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 14),
        .foregroundColor: UIColor.black
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleLabel.text = pokemon.name
        descriptionLabel.text = pokemon.types.map({$0.type.name}).joined(separator: ", ")
        coverView.download(from: pokemon.sprites.front_default)
        view.addSubview(coverView)
        view.addSubview(bottomStack)
        bottomStack.addArrangedSubview(infoStack)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(descriptionLabel)
        for stat in pokemon.stats {
            let field = NSMutableAttributedString(string: stat.stat.name+": ",
                                                  attributes: boldAttribute)
            field.append(NSAttributedString(string: String(stat.base_stat)))
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.textColor = .black
            label.attributedText = field
            infoStack.addArrangedSubview(label)
        }
        infoStack.addArrangedSubview(UIView())
        
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: view.topAnchor),
            coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: coverView.bottomAnchor),
            bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoStack.topAnchor.constraint(equalTo: bottomStack.topAnchor, constant:  24),
            infoStack.leadingAnchor.constraint(equalTo: bottomStack.leadingAnchor, constant:  24),
        ])
        
    }
}
