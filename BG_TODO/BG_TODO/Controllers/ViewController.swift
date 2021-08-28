//
//  ViewController.swift
//  BG_TODO
//
//  Created by bhavesh on 28/08/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var toDoListCollectionView: UICollectionView!
    @IBOutlet var warriorPath: UIView!
    @IBOutlet var warriorCatImageView: UIImageView!
    
    // MARK: - Properties
    var toDos: [ToDoItem] = []
    var completedToDos: [ToDoItem] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListCollectionView.register(UINib(nibName: "ToDoCell", bundle: nil),
                                        forCellWithReuseIdentifier: "cell")
        setWarriorPosition()
    }
}

// MARK: - IBActions
extension ViewController {
    
    @IBAction func addToDo(_ sender: UIBarButtonItem) {
        let controller = UIAlertController(title: "Create Task",
                                           message: "What kind of task would you like to create?",
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Task without Checklist", style: .default) { [weak self] _ in
            self?.createDefaultTask()
        })
        
        present(controller, animated: true)
    }
}

// MARK: - Internal
extension ViewController {
    
    func setWarriorPosition() {
        var percentageComplete = 0.0
        let completed = Double(completedToDos.count)
        let all = Double(toDos.count)
        
        if !completedToDos.isEmpty {
            percentageComplete = completed / all
        }
        
        let x = warriorPath.frame.width * CGFloat(percentageComplete)
        
        warriorCatImageView.frame = CGRect(x: x,
                                           y: warriorPath.frame.midY - 50,
                                           width: 100,
                                           height: 100)
    }
    
    func createDefaultTask() {
        let controller = UIAlertController(title: "Task Name",
                                           message: "",
                                           preferredStyle: .alert)
        
        controller.addTextField { textField in
            textField.placeholder = "Enter Task Title"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] alert in
            if let titleTextField = controller.textFields?.first,
                titleTextField.text != "" {
                let currentToDo = ToDoItem(name: titleTextField.text!)
                self?.toDos.append(currentToDo)
                self?.toDoListCollectionView.reloadData()
                self?.setWarriorPosition()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        controller.addAction(saveAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentToDo = toDos[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ToDoCell
        cell.toDoLabel.text = currentToDo.name
        
        if currentToDo.isComplete {
            cell.checkBoxView.backgroundColor = UIColor(red: 0.24, green: 0.56, blue: 0.30, alpha: 1.0)
        } else {
            cell.checkBoxView.backgroundColor = .white
        }
        
        cell.layoutSubviews()
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentToDo = toDos[indexPath.row]
        
        if currentToDo.isComplete {
            currentToDo.isComplete = false
            completedToDos = completedToDos.filter { $0.name != currentToDo.name }
        } else {
            currentToDo.isComplete = true
            completedToDos.append(currentToDo)
        }
        
        setWarriorPosition()
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height * 0.15
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
