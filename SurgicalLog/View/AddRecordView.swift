//
//  AddRecordView.swift
//  SurgicalLog
//
//  Created by Ichida Kou on 4/24/25.
//

import SwiftUI
import SwiftData

struct AddRecordView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    // 編集用: 既存レコード (nilなら新規)
    var record: SurgicalRecord? = nil

    // 基本項目
    @State private var patientID = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthDate = Date()
    @State private var selectedGender: String = ""
    @State private var gender = ""
    @State private var primaryDoctor = ""
    @State private var date = Date()
    @State private var admissionDate = Date()
    @State private var notes = ""

    // 診断・手術情報
    @State private var preDiagnosis = ""
    @State private var postDiagnosis = ""
    @State private var surgeryName = ""
    @State private var surgeryType = ""

    // スタッフ
    @State private var surgeon = ""
    @State private var assistant = ""
    @State private var anesthesiologist = ""

    // 時間
    @State private var entryTime = Date()
    @State private var anesthesiaStartTime = Date()
    @State private var surgeryStartTime = Date()
    @State private var surgeryEndTime = Date()
    @State private var exitTime = Date()

    // 麻酔・術中
    @State private var anesthesiaMethod = ""
    @State private var vitalChanges = ""
    @State private var infusionVolume = ""
    @State private var bloodLoss = ""
    @State private var urineOutput = ""

    // 新規追加の手術詳細関連
    @State private var procedureDetails: String = ""
    @State private var complications: String = ""
    @State private var responses: String = ""
    @State private var postOpInstructions: String = ""
    @State private var summary: String = ""

    // 既存の術式詳細等は削除
    //@State private var procedureDetails = ""
    //@State private var complications = ""
    //@State private var responses = ""
    //@State private var summary = ""
    //@State private var postOpInstructions = ""
    @State private var nextAppointment = Date()

    // 編集モード初期化
    @State private var didAppear = false

    @State private var showSaveConfirmation = false

    var calculatedAge: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        return ageComponents.year ?? 0
    }

    var body: some View {
        Form {
            // 患者情報
            Section(header: Text("患者情報")) {
                HStack {
                    Text("患者ID")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $patientID)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if patientID.isEmpty {
                                    Text("患者IDを入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    HStack {
                        Text("姓")
                            .frame(width: 100, alignment: .leading)
                        Divider()
                            .frame(height: 20)
                        TextField("", text: $lastName)
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(6)
                            .overlay(
                                HStack {
                                    if lastName.isEmpty {
                                        Text("姓を入力")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 8)
                                    }
                                    Spacer()
                                }
                            )
                    }
                    Divider()
                        .frame(height: 30)
                    HStack {
                        Text("名")
                            .frame(width: 100, alignment: .leading)
                        Divider()
                            .frame(height: 20)
                        TextField("", text: $firstName)
                            .padding(6)
                            .background(Color.white)
                            .cornerRadius(6)
                            .overlay(
                                HStack {
                                    if firstName.isEmpty {
                                        Text("名を入力")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 8)
                                    }
                                    Spacer()
                                }
                            )
                    }
                }
                HStack {
                    Text("生年月日")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    DatePicker("", selection: $birthDate, displayedComponents: .date)
                        .labelsHidden()
                    Spacer()
                    Text("年齢: \(calculatedAge) 歳")
                }
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("性別")
                            .frame(width: 100, alignment: .leading)
                        Divider()
                            .frame(height: 20)
                        Picker("", selection: $selectedGender) {
                            Text("男").tag("男")
                            Text("女").tag("女")
                            Text("未選択").tag("")
                        }
                        .pickerStyle(.segmented)
                    }
                }
                HStack {
                    Text("主治医")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $primaryDoctor)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if primaryDoctor.isEmpty {
                                    Text("主治医を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("手術日")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                }
                HStack {
                    Text("入院日")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    DatePicker("", selection: $admissionDate, displayedComponents: .date)
                        .labelsHidden()
                }
            }
            // スタッフ
            Section(header: Text("スタッフ")) {
                HStack {
                    Text("執刀医")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $surgeon)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if surgeon.isEmpty {
                                    Text("執刀医を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("助手")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $assistant)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if assistant.isEmpty {
                                    Text("助手を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("麻酔医")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $anesthesiologist)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if anesthesiologist.isEmpty {
                                    Text("麻酔医を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
            }
            // 診断・術式
            Section(header: Text("診断・術式")) {
                HStack {
                    Text("術前診断")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $preDiagnosis)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if preDiagnosis.isEmpty {
                                    Text("術前診断を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("術後診断")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $postDiagnosis)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if postDiagnosis.isEmpty {
                                    Text("術後診断を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("術式名")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $surgeryName)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if surgeryName.isEmpty {
                                    Text("術式名を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("手術種別")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $surgeryType)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if surgeryType.isEmpty {
                                    Text("手術種別を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
            }
            // 手術タイムライン
            Section(header: Text("手術タイムライン")) {
                DatePicker("入室時間", selection: $entryTime, displayedComponents: [.hourAndMinute, .date])
                DatePicker("麻酔開始", selection: $anesthesiaStartTime, displayedComponents: [.hourAndMinute, .date])
                DatePicker("手術開始", selection: $surgeryStartTime, displayedComponents: [.hourAndMinute, .date])
                DatePicker("手術終了", selection: $surgeryEndTime, displayedComponents: [.hourAndMinute, .date])
                DatePicker("退室時間", selection: $exitTime, displayedComponents: [.hourAndMinute, .date])
            }
            // 麻酔とバイタル
            Section(header: Text("麻酔とバイタル")) {
                HStack {
                    Text("麻酔法")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $anesthesiaMethod)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if anesthesiaMethod.isEmpty {
                                    Text("麻酔法を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("バイタル変化")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $vitalChanges)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if vitalChanges.isEmpty {
                                    Text("バイタル変化を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("輸液量")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $infusionVolume)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if infusionVolume.isEmpty {
                                    Text("輸液量を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
                HStack {
                    Text("出血量")
                        .frame(width: 100, alignment: .leading)
                    Divider()
                        .frame(height: 20)
                    TextField("", text: $bloodLoss)
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(6)
                        .overlay(
                            HStack {
                                if bloodLoss.isEmpty {
                                    Text("出血量を入力")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                }
                                Spacer()
                            }
                        )
                }
            }

            Section(header: Text("手術の詳細")) {
                ZStack(alignment: .topLeading) {
                    if procedureDetails.isEmpty {
                        Text("手術の詳細を入力")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $procedureDetails)
                        .frame(height: 100)
                }
            }

            Section(header: Text("合併症")) {
                ZStack(alignment: .topLeading) {
                    if complications.isEmpty {
                        Text("合併症を入力")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $complications)
                        .frame(height: 80)
                }
            }

            Section(header: Text("術中対応")) {
                ZStack(alignment: .topLeading) {
                    if responses.isEmpty {
                        Text("術中対応を入力")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $responses)
                        .frame(height: 80)
                }
            }

            Section(header: Text("術後指示")) {
                ZStack(alignment: .topLeading) {
                    if postOpInstructions.isEmpty {
                        Text("術後指示を入力")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $postOpInstructions)
                        .frame(height: 80)
                }
            }

            Section(header: Text("手術まとめ")) {
                ZStack(alignment: .topLeading) {
                    if summary.isEmpty {
                        Text("手術まとめを入力")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $summary)
                        .frame(height: 100)
                }
            }

            DatePicker("次回診察予定", selection: $nextAppointment, displayedComponents: .date)
            ZStack(alignment: .topLeading) {
                if notes.isEmpty {
                    Text("自由記述を入力")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.leading, 4)
                }
                TextEditor(text: $notes)
                    .frame(height: 80)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.3)))
                    .padding(.vertical, 4)
                    .accessibilityLabel("自由記述")
            }

            // 保存ボタン
            Button(action: saveRecord) {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("記録内容を保存")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.vertical)
            }
        }
        .navigationTitle(record == nil ? "新規記録を追加" : "記録編集")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 編集モード: recordがあり、初回のみ初期化
            if !didAppear, let r = record {
                // 氏名を姓名分割
                let name = r.patientName
                if name.count > 0 {
                    // 2文字以上なら先頭を姓、残りを名と仮定
                    if name.count >= 2 {
                        let firstChar = String(name.prefix(1))
                        let rest = String(name.dropFirst(1))
                        lastName = firstChar
                        firstName = rest
                    } else {
                        lastName = name
                        firstName = ""
                    }
                }
                patientID = r.patientID
                birthDate = Calendar.current.date(byAdding: .year, value: -r.age, to: Date()) ?? Date()
                selectedGender = r.gender
                // department = r.department
                primaryDoctor = r.primaryDoctor
                date = r.date
                admissionDate = r.admissionDate
                notes = r.notes
                preDiagnosis = r.preDiagnosis
                postDiagnosis = r.postDiagnosis
                surgeryName = r.surgeryName
                surgeryType = r.surgeryType
                surgeon = r.surgeon
                assistant = r.assistant
                anesthesiologist = r.anesthesiologist
                entryTime = r.entryTime
                anesthesiaStartTime = r.anesthesiaStartTime
                surgeryStartTime = r.surgeryStartTime
                surgeryEndTime = r.surgeryEndTime
                exitTime = r.exitTime
                anesthesiaMethod = r.anesthesiaMethod
                vitalChanges = r.vitalChanges
                infusionVolume = r.infusionVolume
                bloodLoss = r.bloodLoss
                urineOutput = r.urineOutput
                procedureDetails = r.procedureDetails
                complications = r.complications
                responses = r.responses
                postOpInstructions = r.postOpInstructions
                summary = r.summary
                nextAppointment = r.nextAppointment
                didAppear = true
            }
        }
        .alert("保存しました", isPresented: $showSaveConfirmation) {
            Button("OK") { dismiss() }
        }
    }


    func saveRecord() {
        if let record = record {
            // 編集: 既存レコードの値を更新
            record.patientName = lastName + firstName
            record.surgeryType = surgeryType
            record.date = date
            record.notes = notes
            record.patientID = patientID
            record.age = calculatedAge
            record.gender = selectedGender
            // record.department = department
            record.primaryDoctor = primaryDoctor
            record.admissionDate = admissionDate
            record.preDiagnosis = preDiagnosis
            record.postDiagnosis = postDiagnosis
            record.surgeryName = surgeryName
            record.surgeon = surgeon
            record.assistant = assistant
            record.anesthesiologist = anesthesiologist
            // nurses, otherStaff, anesthesiaDrugs, instrumentsUsed, specimens, images, videos, illustrationsは編集画面未対応
            record.entryTime = entryTime
            record.anesthesiaStartTime = anesthesiaStartTime
            record.surgeryStartTime = surgeryStartTime
            record.surgeryEndTime = surgeryEndTime
            record.exitTime = exitTime
            record.anesthesiaMethod = anesthesiaMethod
            record.vitalChanges = vitalChanges
            record.infusionVolume = infusionVolume
            record.bloodLoss = bloodLoss
            record.urineOutput = urineOutput
            record.procedureDetails = procedureDetails
            record.complications = complications
            record.responses = responses
            record.postOpInstructions = postOpInstructions
            record.summary = summary
            record.nextAppointment = nextAppointment
            // context.save()は不要(SwiftData自動)
        } else {
            // 新規作成
            let newRecord = SurgicalRecord(
                id: UUID(),
                patientName: lastName + firstName,
                surgeryType: surgeryType,
                date: date,
                notes: notes,
                patientID: patientID,
                age: calculatedAge,
                gender: selectedGender,
                department: "",
                primaryDoctor: primaryDoctor,
                admissionDate: admissionDate,
                preDiagnosis: preDiagnosis,
                postDiagnosis: postDiagnosis,
                surgeryName: surgeryName,
                surgeon: surgeon,
                assistant: assistant,
                anesthesiologist: anesthesiologist,
                nurses: [],
                otherStaff: [],
                entryTime: entryTime,
                anesthesiaStartTime: anesthesiaStartTime,
                surgeryStartTime: surgeryStartTime,
                surgeryEndTime: surgeryEndTime,
                exitTime: exitTime,
                anesthesiaMethod: anesthesiaMethod,
                anesthesiaDrugs: [],
                vitalChanges: vitalChanges,
                infusionVolume: infusionVolume,
                bloodLoss: bloodLoss,
                urineOutput: urineOutput,
                procedureDetails: procedureDetails,
                instrumentsUsed: [],
                complications: complications,
                responses: responses,
                specimens: [],
                images: [],
                videos: [],
                illustrations: [],
                summary: summary,
                postOpInstructions: postOpInstructions,
                nextAppointment: nextAppointment
            )
            context.insert(newRecord)
        }
        try? context.save()
        showSaveConfirmation = true
    }
}


#Preview {
    HomeView()
        .modelContainer(for: SurgicalRecord.self)
}


#Preview {
    AddRecordView()
}
