import UIKit

// Предполагается, что структура модели определена где-то в проекте, например:
struct MyModel {
    let filmTitle: String          // Название фильма
    let releaseYeah: String?         // Год выпуска или описание
    let rating: String?              // Рейтинг фильма
    let posterPreview: String?       // Имя изображения (системное или из Assets)
    let isImageOnly: Bool            // Флаг: если true – показываем только изображение, без текста
}

class MyCustomCell: UICollectionViewCell {
    
    // ImageView для предпросмотра постера
    private let posterPreviewImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true           // Картинка не выходит за пределы imageView
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray   // Для визуализации
        return iv
    }()
    
    // Метка с названием фильма
    private let filmTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Метка с годом выпуска или описанием
    private let releaseYeahLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Метка с рейтингом фильма
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Стек для размещения лейблов
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // Инициализатор ячейки
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) не реализован")
    }
    
    // Метод добавления subview в contentView
    private func setupViews() {
        contentView.addSubview(posterPreviewImageView)
        contentView.addSubview(textStack)
        
        textStack.addArrangedSubview(filmTitleLabel)
        textStack.addArrangedSubview(releaseYeahLabel)
        textStack.addArrangedSubview(ratingLabel)
    }
    
    // Метод установки Auto Layout ограничений
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Картинка занимает 50% ширины ячейки
            posterPreviewImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterPreviewImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterPreviewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterPreviewImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            // Стек с лейблами располагается справа от картинки
            textStack.leadingAnchor.constraint(equalTo: posterPreviewImageView.trailingAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // Метод для настройки ячейки по данным модели MyModel
    func configure(with model: MyModel) {
        // Настраиваем текстовые лейблы
        filmTitleLabel.text = model.filmTitle
        releaseYeahLabel.text = model.releaseYeah
        ratingLabel.text = model.rating
        
        // Если задано имя картинки, устанавливаем изображение
        if let imageName = model.posterPreview {
            // Если изображения из SF Symbols, то:
            posterPreviewImageView.image = UIImage(systemName: imageName)
            // Если изображения лежат в Assets, используйте:
            // posterPreviewImageView.image = UIImage(named: imageName)
        }
        
        // При условии, что isImageOnly == true, скрываем текстовые лейблы
        filmTitleLabel.isHidden = model.isImageOnly
        releaseYeahLabel.isHidden = model.isImageOnly
        ratingLabel.isHidden = model.isImageOnly
    }
}
