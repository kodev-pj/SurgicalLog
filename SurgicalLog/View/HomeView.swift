//
//  ContentView.swift
//  SurgicalLog
//
//  Created by Ichida Ko on 2025/07/16.
//

import SwiftUI
import SwiftData

struct TabItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let imageName: String
    let destination: AnyView

    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.id == rhs.id
    }
}

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SurgicalRecord.date, order: .reverse) private var items: [SurgicalRecord]

    @State private var tabs: [TabItem] = [
        TabItem(title: "新規記録を追加", imageName: "square.and.pencil", destination: AnyView(AddRecordView())),
        TabItem(title: "記録一覧を見る", imageName: "list.bullet.rectangle", destination: AnyView(RecordListView()))
    ]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(tabs) { tab in
                    NavigationLink(destination: tab.destination) {
                        Label(tab.title, systemImage: tab.imageName)
                    }
                }
                .onMove { indices, newOffset in
                    tabs.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = SurgicalRecord(
                patientName: "",
                surgeryType: "",
                date: Date(),
                notes: "",
                patientID: "",
                age: 0,
                gender: "",
                department: "",
                primaryDoctor: "",
                admissionDate: Date(),
                preDiagnosis: "",
                postDiagnosis: "",
                surgeryName: "",
                surgeon: "",
                assistant: "",
                anesthesiologist: "",
                nurses: [],
                otherStaff: [],
                entryTime: Date(),
                anesthesiaStartTime: Date(),
                surgeryStartTime: Date(),
                surgeryEndTime: Date(),
                exitTime: Date(),
                anesthesiaMethod: "",
                anesthesiaDrugs: [],
                vitalChanges: "",
                infusionVolume: "",
                bloodLoss: "",
                urineOutput: "",
                procedureDetails: "",
                instrumentsUsed: [],
                complications: "",
                responses: "",
                specimens: [],
                images: [],
                videos: [],
                illustrations: [],
                summary: "",
                postOpInstructions: "",
                nextAppointment: Date()
            )
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: SurgicalRecord.self, inMemory: true)
}
