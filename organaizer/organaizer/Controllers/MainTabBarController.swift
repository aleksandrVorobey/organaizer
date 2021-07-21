//
//  ViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 21.07.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad() 
        
        setupTabBarController()
    }
    
    func setupTabBarController() {
        let scheduleViewController = createNavController(viewController: ScheduleViewController(), itemName: "Schedule", itemImage: "calendar.badge.clock")
        let tasksViewController = createNavController(viewController: TasksViewController(), itemName: "Task", itemImage: "text.badge.checkmark")
        let contactsViewController = createNavController(viewController: ContactsViewController(), itemName: "Contacts", itemImage: "rectangle.stack.person.crop")
        viewControllers = [scheduleViewController, tasksViewController, contactsViewController]
    }

    func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        return navController
    }

}

