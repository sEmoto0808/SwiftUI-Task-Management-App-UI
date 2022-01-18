//
//  TaskViewModel.swift
//  Task-Management-App (iOS)
//
//  Created by Sho Emoto on 2022/01/12.
//

import Foundation

class TaskViewModel: ObservableObject {

    // Sample Tasks
    @Published var storedTasks: [Task] = [
        Task(title: "Meeting", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642302000)),
        Task(title: "Icon set", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642316400)),
        Task(title: "Prototype", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642388400)),
        Task(title: "Check asset", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642467600)),
        Task(title: "Team party", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642482000)),
        Task(title: "Client Meeting", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642496400)),
        Task(title: "Next Project", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642647600)),
        Task(title: "App Proposal", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1642719600))
    ]

    // MARK: Current Week Days
    @Published var currentWeekDays: [Date] = []

    @Published var currentDay = Date()

    // MARK: Flitering Today Tasks
    @Published var filteredTasks: [Task]?

    // MARK: Initializing
    init() {
        getCurrentWeekDays()
        filterTodayTasks()
    }

    func getCurrentWeekDays() {

        let today = Date()
        let calendar = Calendar.current

        let week = calendar.dateInterval(of: .weekOfMonth, for: today)

        guard let firstWeekDay = week?.start else {
            return
        }

        (1...7).forEach { day in

            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeekDays.append(weekDay)
            }
        }
    }

    // MARK: Extracting Date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    // MARK: Checking if current Date is Today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }

    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filteredTask = self.storedTasks.filter {
                return calendar.isDate($0.date, inSameDayAs: self.currentDay)
            }

            DispatchQueue.main.async {
                self.filteredTasks = filteredTask
            }
        }
    }
}
