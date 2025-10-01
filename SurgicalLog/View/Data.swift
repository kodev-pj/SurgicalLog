//
//  SurgicalRecord.swift
//  SurgicalLog
//
//  Created by Ichida Kou on 4/24/25.
//

import Foundation
import SwiftData

// 手術記録を保持するモデルクラス
@Model
class SurgicalRecord {
    // ID（自動生成）
    var id: UUID
    // 患者の名前
    var patientName: String
    // 手術の種類
    var surgeryType: String
    // 手術日
    var date: Date
    // メモなど自由記述
    var notes: String

    // 以下、手術記録に関する詳細情報
    var patientID: String // 病院で使われる患者ID
    var age: Int // 年齢
    var gender: String // 性別
    var department: String // 診療科名（例：外科、泌尿器科など）
    var primaryDoctor: String // 主治医の名前
    var admissionDate: Date // 入院日
    var preDiagnosis: String // 術前診断名
    var postDiagnosis: String // 術後診断名
    var surgeryName: String // 手術名（正式な術式名）

    var surgeon: String // 執刀医
    var assistant: String // 助手
    var anesthesiologist: String // 麻酔医
    var nurses: [String] // 看護師のリスト
    var otherStaff: [String] // その他スタッフのリスト

    var entryTime: Date // 手術室への入室時間
    var anesthesiaStartTime: Date // 麻酔開始時間
    var surgeryStartTime: Date // 手術開始時間
    var surgeryEndTime: Date // 手術終了時間
    var exitTime: Date // 手術室退室時間

    var anesthesiaMethod: String // 麻酔法（例：全身麻酔）
    var anesthesiaDrugs: [String] // 使用薬剤のリスト
    var vitalChanges: String // 術中のバイタルの変化など
    var infusionVolume: String // 輸液量（mlなど）
    var bloodLoss: String // 出血量
    var urineOutput: String // 尿量

    var procedureDetails: String // 手術中に何をしたかの詳細記録
    var instrumentsUsed: [String] // 使用した器具
    var complications: String // 合併症の内容
    var responses: String // 合併症にどう対応したか
    var specimens: [String] // 検体の名前リスト

    var images: [Data] // 写真データ
    var videos: [Data] // 動画データ
    var illustrations: [Data] // スケッチなどのイラスト

    var summary: String // 手術全体のまとめ
    var postOpInstructions: String // 術後の指示内容
    var nextAppointment: Date // 次の診察予定

    // 初期化関数（インスタンスを作るときに使う）
    init(
        id: UUID = UUID(), // UUIDは自動で生成
        patientName: String,
        surgeryType: String,
        date: Date,
        notes: String,
        patientID: String,
        age: Int,
        gender: String,
        department: String,
        primaryDoctor: String,
        admissionDate: Date,
        preDiagnosis: String,
        postDiagnosis: String,
        surgeryName: String,
        surgeon: String,
        assistant: String,
        anesthesiologist: String,
        nurses: [String],
        otherStaff: [String],
        entryTime: Date,
        anesthesiaStartTime: Date,
        surgeryStartTime: Date,
        surgeryEndTime: Date,
        exitTime: Date,
        anesthesiaMethod: String,
        anesthesiaDrugs: [String],
        vitalChanges: String,
        infusionVolume: String,
        bloodLoss: String,
        urineOutput: String,
        procedureDetails: String,
        instrumentsUsed: [String],
        complications: String,
        responses: String,
        specimens: [String],
        images: [Data],
        videos: [Data],
        illustrations: [Data],
        summary: String,
        postOpInstructions: String,
        nextAppointment: Date
    ) {
        // クラスのプロパティに、引数で受け取った値を代入する処理
        self.id = id
        self.patientName = patientName
        self.surgeryType = surgeryType
        self.date = date
        self.notes = notes
        self.patientID = patientID
        self.age = age
        self.gender = gender
        self.department = department
        self.primaryDoctor = primaryDoctor
        self.admissionDate = admissionDate
        self.preDiagnosis = preDiagnosis
        self.postDiagnosis = postDiagnosis
        self.surgeryName = surgeryName
        self.surgeon = surgeon
        self.assistant = assistant
        self.anesthesiologist = anesthesiologist
        self.nurses = nurses
        self.otherStaff = otherStaff
        self.entryTime = entryTime
        self.anesthesiaStartTime = anesthesiaStartTime
        self.surgeryStartTime = surgeryStartTime
        self.surgeryEndTime = surgeryEndTime
        self.exitTime = exitTime
        self.anesthesiaMethod = anesthesiaMethod
        self.anesthesiaDrugs = anesthesiaDrugs
        self.vitalChanges = vitalChanges
        self.infusionVolume = infusionVolume
        self.bloodLoss = bloodLoss
        self.urineOutput = urineOutput
        self.procedureDetails = procedureDetails
        self.instrumentsUsed = instrumentsUsed
        self.complications = complications
        self.responses = responses
        self.specimens = specimens
        self.images = images
        self.videos = videos
        self.illustrations = illustrations
        self.summary = summary
        self.postOpInstructions = postOpInstructions
        self.nextAppointment = nextAppointment
    }
}
