//___FILEHEADER___

import Foundation
import UIKit

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
    typealias CellConfigurator = (Model, UITableViewCell) -> Void

    var models: [Model]

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )

        cellConfigurator(model, cell)
        return cell
    }
}

extension TableViewDataSource where Model == ExampleModel {
    static func make(for models: [ExampleModel],
                     reuseIdentifier: String = "exampleDataCell") -> TableViewDataSource {
        return TableViewDataSource(
            models: models,
            reuseIdentifier: reuseIdentifier
        ) { (model, cell) in
            cell.textLabel?.text = model.title
            cell.detailTextLabel?.text = model.description
        }
    }
}

extension TableViewDataSource where Model == TODOModel {
    static func make(for models: [TODOModel],
                     reuseIdentifier: String = "ToDoCellIdentifier") -> TableViewDataSource {
        return TableViewDataSource(
            models: models,
            reuseIdentifier: reuseIdentifier
        ) { (model, cell) in
            cell.textLabel?.text = model.title
            cell.detailTextLabel?.text = "Completed: \(model.completed!)"
        }
    }
}
