//
//  ContentView.swift
//  LineGraphDemo
//
//  Created by Thongchai Subsaidee on 30/8/2564 BE.
//

import SwiftUI

struct Stock {
    let price: Double
}

private func getHistoricalStocks() -> [Stock] {
    var stocks = [Stock]()
    
    for _ in 1...20 {
        let stock = Stock(price: Double.random(in: 100...300))
        stocks.append(stock)
    }
    
    return stocks
}

private func getYearlyLabel() -> [String] {
    return (2015...2021).map({String($0)})
}

struct LineChartView: View {
    
    let values: [Int]
    let labels: [String]
    
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        
        if values.isEmpty {
            return Path()
        }
        
        var offSetX: Int = Int(screenWidth/CGFloat(values.count))
        var path = Path()
        path.move(to: CGPoint(x: offSetX, y: values[0]))
        
        for value in values {
            offSetX += Int(screenWidth / CGFloat(values.count))
            path.addLine(to: CGPoint(x: offSetX, y: value))
        }
        
        return path
    }
    
    var body: some View {
        VStack {
            path.stroke(Color.white, lineWidth: 2.0)
                .rotationEffect(.degrees(180), anchor: .center)
                .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            HStack {
                ForEach(labels, id: \.self) { label in
                    Text(label)
                        .frame(width: screenWidth / CGFloat(labels.count) - 10)
                }
            }
        }
    }
}


struct ContentView: View {
    
    let prices = getHistoricalStocks().map({Int($0.price)})
    let labels = getYearlyLabel()
    
    
    var body: some View {
        VStack {
            Text("Stocks")
                .font(.largeTitle)
            LineChartView(values: prices, labels: labels  )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.2717101276, green: 0.8063796163, blue: 0.4401132464, alpha: 1)))
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
