//
//  HomePage.swift
//  Task-Management-App (iOS)
//
//  Created by Sho Emoto on 2022/01/12.
//

import SwiftUI

struct HomePage: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    @Namespace var animation

    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {

            // MARK: Lazy Stack With Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {

                Section {

                    // MARK: Current Week View
                    ScrollView(.horizontal, showsIndicators: false) {

                        HStack(spacing: 10) {

                            ForEach(taskViewModel.currentWeekDays, id: \.self) { day in

                                VStack(spacing: 10) {

                                    Text(taskViewModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)

                                    // EEE will return day as MON, TUE,...etc
                                    Text(taskViewModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))

                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskViewModel.isToday(date: day) ? 1 : 0)
                                }
                                .foregroundStyle(taskViewModel.isToday(date: day) ? .primary : .tertiary)
                                .foregroundColor(taskViewModel.isToday(date: day) ? .white : .black)
                                // MARK: Capsule Shape
                                .frame(width: 45, height: 90)
                                .background(

                                    ZStack {

                                        // MARK: Matched Geometry Effect
                                        if taskViewModel.isToday(date: day) {

                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    // Updating Current Day
                                    withAnimation {
                                        taskViewModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    TasksView()

                } header: {
                    HeaderView()
                }
            }
        }
    }

    // MARK: Header
    func HeaderView() -> some View {

        HStack(spacing: 10) {

            VStack(alignment: .leading, spacing: 10) {

                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)

                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()

            Button {} label: {

                Image(systemName: "book")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
    }

    // MARK: TasksView
    func TasksView() -> some View {

        LazyVStack(spacing: 18) {

            if let tasks = taskViewModel.filteredTasks {

                if tasks.isEmpty {

                    Text("No tasks found!!!")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {

                    ForEach(tasks) {task in
                        TaskCardView(task: task)
                    }
                }
            } else {

                ProgressView()
                    .offset(y: 100)
            }
        }
        .onChange(of: taskViewModel.currentDay) { newValue in
            taskViewModel.filterTodayTasks()
        }
    }

    // MARK: Task Card View
    func TaskCardView(task: Task) -> some View {

        HStack {

            VStack(spacing: 10) {

                Circle()
                    .fill(.black)
                    .frame(width: 15, height: 15)
                    .background(

                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

// MARK: UI Design Helper functions
extension View {

    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }

    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
