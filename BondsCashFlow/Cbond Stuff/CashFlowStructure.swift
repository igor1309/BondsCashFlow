//
//  CashFlowStructure.swift
//  BondsCashFlow
//
//  Created by Igor Malyarov on 25.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

struct CashFlowStructure: Hashable {
    /// Основные поля: Денежный поток - get_flow
    let id: Int // Уникальный идентификатор long
    let emissionID: Int // Эмиссия (id) long
    let emissionIsinCode: String // Код ISIN эмиссии Varchar
    let emissionEmitentID: Int //Эмитент (id) long
    let date: Date // Дата выплаты Date
    let startDate: Date // Дата начала купонного периода Date
    let couponNum: Int // Номер купона по порядку Int
    let cuponRate: Double // Ставка купона, % годовых Double
    let cuponRateDate: Date //Дата, когда стал известен купон Date
    let cuponSum: Double // Сумма купона Double
    let daysBeetwenCoupons: Int // Дней между купонами Int
    let redemtion: Double // Погашение номинала Double
    let updatingDate: Date // Дата создания или последнего обновления записи Date
    //    let actualPaymentDate: String // Фактическая дата выплаты Date
    //    let cuponSumEurobondsNominal: Double // Сумма купона (от номинала для еврооблигаций) Double
    //    let cuponSumIntegralMultiple: Double // Сумма купона (от лота кратности) Double
    //    let nontradingStartDate: String // Date // Начало периода приостановки торгов Date
    //    let nontradingStopDate: String // Date // Конец периода приостановки торгов Date
    //    let redemptionEurobondsNominal: Double // Погашение (от номинала для еврооблигаций) Double
    //    let redemptionIntegralMultiple: Double // Погашение (от лота кратности) Double
    
    init(from: CBondFlow) {
        self.id = Int(from.id) ?? -1
        self.emissionID = Int(from.emissionID) ?? -1
        self.emissionIsinCode = from.emissionIsinCode
        self.emissionEmitentID = Int(from.emissionEmitentID) ?? -1
        
        //  date @ get_flow is string like 2011-03-28
        let dateComponents = DateComponents(year: Int(from.date.prefix(4)),
                                            month: Int(from.date.suffix(5).prefix(2)),
                                            day: Int(from.date.suffix(2)))
        self.date = Calendar.current.date(from: dateComponents) ?? .distantPast
        
        self.startDate = from.startDate
        self.couponNum = Int(from.couponNum) ?? -1
        self.cuponRate = Double(from.cuponRate) ?? -1
        self.cuponRateDate = from.cuponRateDate
        self.cuponSum = Double(from.cuponSum) ?? -1
        self.daysBeetwenCoupons = Int(from.daysBeetwenCoupons ?? "") ?? -1
        self.redemtion = Double(from.redemtion ?? "") ?? -1
        self.updatingDate = from.updatingDate
        //        self.actualPaymentDate = from.actualPaymentDate ?? ""
        //        self.cuponSumEurobondsNominal = Double(from.cuponSumEurobondsNominal) ?? -1
        //        self.cuponSumIntegralMultiple = Double(from.cuponSumIntegralMultiple) ?? -1
        //        self.nontradingStartDate = from.nontradingStartDate ?? ""
        //        self.nontradingStopDate = from.nontradingStopDate ?? ""
        //        self.redemptionEurobondsNominal = Double(from.redemptionEurobondsNominal ?? "") ?? -1
        //        self.redemptionIntegralMultiple = Double(from.redemptionIntegralMultiple ?? "") ?? -1
    }
}

