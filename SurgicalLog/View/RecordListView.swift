//
//  RecordListView.swift
//  SurgicalLog
//
//  Created by Ichida Kou on 4/24/25.
//

import SwiftUI
import SwiftData

struct RecordListView: View {
    @Query private var records: [SurgicalRecord]
    @Environment(\.modelContext) private var modelContext
    @State private var selectedRecord: SurgicalRecord? = nil

    var body: some View {
        List(records) { record in
            NavigationLink(destination: RecordDetailView(record: record)) {
                VStack(alignment: .leading) {
                    Text(record.patientName)
                        .font(.headline)
                    Text(record.surgeryType)
                        .font(.subheadline)
                    Text(record.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .swipeActions {
                Button(role: .destructive) {
                    modelContext.delete(record)
                } label: {
                    Label("削除", systemImage: "trash")
                }
                Button {
                    selectedRecord = record
                } label: {
                    Label("編集", systemImage: "pencil")
                }
                .tint(.blue)
            }
        }
        .navigationTitle("手術記録一覧")
        .sheet(item: $selectedRecord) { record in
            AddRecordView(record: record)
        }
    }
}

#Preview {
    RecordListView()
        .modelContainer(for: SurgicalRecord.self)
}

#Preview {
    HomeView()
        .modelContainer(for: SurgicalRecord.self)
}
