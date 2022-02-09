//
//  WaveForm.swift
//  WavesAnimation
//
//  Created by Майлс on 09.02.2022.
//

import SwiftUI

struct WaveForm: View {
    
    let color: Color
    let amplify: CGFloat
    var isReversed: Bool
    
    var body: some View {
        //Использование timeline view для периодичного обновления
        TimelineView(.animation) { timeLine in
            
            //Canvas view для рисования волн
            Canvas { context, size in
                
                //Текущее время
                let timeNow = timeLine.date.timeIntervalSinceReferenceDate
                
                //Анимирование волны используя текущее время
                let angle = timeNow.remainder(dividingBy: 2)
                let offset = angle * size.width
                
                //Двигаем все View
                context.translateBy(x: isReversed ? -offset : offset, y: 0)
                
                //Использование SwiftUI Path для рисования волн
                context.fill(getPath(size: size), with: .color(color))
                
                //Рисуем кривую на переднем и заднем планах
                //Что будет выглядеть как анимация волны
                context.translateBy(x: -size.width, y: 0)
                context.fill(getPath(size: size), with: .color(color))
                
                context.translateBy(x: size.width * 2, y: 0)
                context.fill(getPath(size: size), with: .color(color))
            }
        }
        .ignoresSafeArea()
    }
}

extension WaveForm {
    private func getPath(size: CGSize) -> Path {
         return Path { path in
             
             let midHeight = size.height / 2
             path.move(to: CGPoint(x: 0, y: midHeight))
             
             let width = size.width
             path.addCurve(
                 to: CGPoint(x: width, y: midHeight),
                 control1: CGPoint(x: width * 0.4, y: midHeight + amplify),
                 control2: CGPoint(x: width * 0.65, y: midHeight - amplify))
             
             //Заполнение низины
             path.addLine(to: CGPoint(x: width, y: size.height))
             path.addLine(to: CGPoint(x: 0, y: size.height))
         }
    }
}

//MARK: - PREVIEW
struct WaveForm_Previews: PreviewProvider {
    static var previews: some View {
        WaveForm(color: .red, amplify: 150, isReversed: true)
    }
}
