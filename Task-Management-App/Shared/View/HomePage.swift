//
//  HomePage.swift
//  Task-Management-App (iOS)
//
//  Created by Sho Emoto on 2022/01/12.
//

import SwiftUI

struct HomePage: View {
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {

            // MARK: Lazy Stack With Pinned Header
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {

                Section {} header: {
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
