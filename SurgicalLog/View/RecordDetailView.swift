//
//  RecordDetailView.swift
//  SurgicalLog
//
//  Created by Ichida Kou on 4/24/25.
//

import SwiftUI

struct RecordDetailView: View {
    let record: SurgicalRecord

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("氏名: \(record.patientName)")
                        .font(.title2)
                        .bold()
                    Text("手術名: \(record.surgeryName)")
                    Text("診療科: \(record.department)")
                    Text("主治医: \(record.primaryDoctor)")
                    Text("入院日: \(record.admissionDate, style: .date)")
                }

                Divider()

                Group {
                    Text("術前診断: \(record.preDiagnosis)")
                    Text("術後診断: \(record.postDiagnosis)")
                    Text("術式: \(record.surgeryType)")
                    Text("執刀医: \(record.surgeon)")
                    Text("助手: \(record.assistant)")
                    Text("麻酔法: \(record.anesthesiaMethod)")
                    Text("バイタル変化: \(record.vitalChanges)")
                }

                Divider()

                Text("手術詳細")
                    .font(.headline)
                Text(record.procedureDetails)

                Text("合併症と対応: \(record.complications) / \(record.responses)")

                Divider()

                Text("メモ")
                    .font(.headline)
                Text(record.notes)

                Text("術後指示: \(record.postOpInstructions)")
                Text("次回診察予定: \(record.nextAppointment, style: .date)")
            }
            .padding()
        }
        .navigationTitle("記録詳細")
    }
}

#Preview {
    HomeView()
}
