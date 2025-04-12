import UIKit

// Если структура находится в TestModel.swift, здесь она уже доступна.

// MARK: - Тестовые данные
var testArray: [TestModel] = [
    TestModel(testPic: "image1", testTitle: "Фильм 1", testYeah: "2001", testRating: "4.6"),
    TestModel(testPic: "image2", testTitle: "Фильм 2", testYeah: "2002", testRating: "4.2"),
    TestModel(testPic: "image3", testTitle: "Фильм 3", testYeah: "2003", testRating: "3.7"),
    TestModel(testPic: "image4", testTitle: "Фильм 4", testYeah: "2004", testRating: "4.7"),
    TestModel(testPic: "image5", testTitle: "Фильм 5", testYeah: "2005", testRating: "2.8"),
    TestModel(testPic: "image6", testTitle: "Фильм 6", testYeah: "2006", testRating: "1.2"),
    TestModel(testPic: "image7", testTitle: "Фильм 7", testYeah: "2007", testRating: "2.7"),
    TestModel(testPic: "image8", testTitle: "Фильм 8", testYeah: "2008", testRating: "4.7"),
    TestModel(testPic: "image9", testTitle: "Фильм 9", testYeah: "2009", testRating: "2.4"),
    TestModel(testPic: "image10", testTitle: "Фильм 10", testYeah: "2010", testRating: "3.7"),
    TestModel(testPic: "image11", testTitle: "Фильм 11", testYeah: "2011", testRating: "4.9"),
    TestModel(testPic: "image12", testTitle: "Фильм 12", testYeah: "2012", testRating: "3.7"),
    TestModel(testPic: "image13", testTitle: "Фильм 13", testYeah: "2013", testRating: "2.7"),
    TestModel(testPic: "image14", testTitle: "Фильм 14", testYeah: "2014", testRating: "1.7"),
    TestModel(testPic: "image15", testTitle: "Фильм 15", testYeah: "2015", testRating: "4.7")
]

// MARK: - Основной контроллер
class MainViewController: UIViewController {
    private var collectionView: UICollectionView!

    // Поисковая строка
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Поиск"
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()

    // Изображение для предпросмотра
    private let posterPreview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray // Для визуализации
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

    // Стек для размещения меток
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // Переменная для хранения выбранной модели
    private var model: TestModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
        setupCollectionView()


        // Загрузка данных: используем первый элемент из массива testArray
        loadModelData()
    }

    // MARK: - Настройка интерфейса
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // или .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: view.frame.width - 16, height: 120)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyCustomCell.self, forCellWithReuseIdentifier: "MyCustomCell")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


    private func setupViews() {
        // Добавляем стек с метками
        textStack.addArrangedSubview(filmTitleLabel)
        textStack.addArrangedSubview(releaseYeahLabel)
        textStack.addArrangedSubview(ratingLabel)

        // Добавляем элементы на главный view
        view.addSubview(searchBar)
        view.addSubview(posterPreview)
        view.addSubview(textStack)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Поисковая строка сверху
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // Изображение ниже поисковой строки
            posterPreview.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            posterPreview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            posterPreview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            posterPreview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

            // Стек с метками справа от изображения
            textStack.leadingAnchor.constraint(equalTo: posterPreview.trailingAnchor, constant: 8),
            textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textStack.topAnchor.constraint(equalTo: posterPreview.topAnchor),
            textStack.bottomAnchor.constraint(equalTo: posterPreview.bottomAnchor)
        ])
    }

    // MARK: - Загрузка и настройка данных

    /// Загрузка данных: берем первый элемент из массива testArray
    private func loadModelData() {
        guard let exampleModel = testArray.first else { return }
        configure(with: exampleModel)
    }

    /// Метод настройки интерфейса по данным модели TestModel
    func configure(with model: TestModel) {
        self.model = model

        filmTitleLabel.text = model.testTitle
        releaseYeahLabel.text = model.testYeah
        ratingLabel.text = model.testRating

        // Устанавливаем изображение.
        // Если вы используете реальные изображения из Assets, замените UIImage(systemName:) на UIImage(named:)
        
        posterPreview.image = UIImage(named: model.testPic ?? "")



    }
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCustomCell", for: indexPath) as? MyCustomCell else {
            return UICollectionViewCell()
        }

        let testItem = testArray[indexPath.item]
        let model = MyModel(
            filmTitle: testItem.testTitle ?? "",
            releaseYeah: testItem.testYeah,
            rating: testItem.testRating,
            posterPreview: testItem.testPic,
            isImageOnly: false
        )
        cell.configure(with: model)
        return cell
    }
}
