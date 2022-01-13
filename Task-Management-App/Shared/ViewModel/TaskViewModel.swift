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
        Task(title: "Meeting", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641645497)),
        Task(title: "Icon set", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641649097)),
        Task(title: "Prototype", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641652697)),
        Task(title: "Check asset", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641656297)),
        Task(title: "Team party", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641661807)),
        Task(title: "Client Meeting", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641641897)),
        Task(title: "Next Project", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641677897)),
        Task(title: "App Proposal", description: "Discuss team for the day", date: .init(timeIntervalSince1970: 1641681497))
    ]

    // MARK: Current Week Days
    @Published var currentWeekDays: [Date] = []

    // MARK: Initializing
    init() {
        getCurrentWeekDays()
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
}
