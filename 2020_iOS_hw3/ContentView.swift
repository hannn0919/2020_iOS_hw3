//
//  ContentView.swift
//  2020_iOS_hw3
//
//  Created by Hannn on 2020/5/2.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var watchMovie = false
    @State private var showSecondPage = false
    @State private var showAlert = false
    @State private var typePick = 0
    @State private var score = 0.0
    @State private var selectDate = Date()
    
    let today = Date()
    let startDate = Calendar.current.date(byAdding: .year,value: -30, to: Date())!
    
    var year: Int {
        Calendar.current.component(.year, from: selectDate)
    }
    
    var body: some View {
        VStack{
            Image("title")
                .resizable()
                .scaledToFit()
            
            Form{
                Name(name: self.$name)
                
                Toggle("我想看電影！！", isOn : $watchMovie)
                
                if(watchMovie) {
                    TypePicker(type: self.$typePick)
                    
                    DatePicker("年代", selection: self.$selectDate, in: self.startDate...self.today, displayedComponents: .date)
                    
                    
                    ScoreStepper(score: self.$score)
                    ScoreSlider(score: self.$score)
                    
                }
                
            }
            
            Button(action: {
                if(self.watchMovie) {
                    self.showSecondPage = true
                }
                else {
                    self.showAlert = true
                }
            }) {
                Text("選片GOGO")
                    .font(.headline)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(30)
                    .foregroundColor(.black)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.yellow, lineWidth: 5))
            }.alert(isPresented: $showAlert) { () -> Alert in
                return Alert(title: Text("不是啊你來亂的哦！"),message: Text("配合一下嘛看一下拉拜託🥺🥺"))
            }
            .sheet(isPresented: self.$showSecondPage) {
                MovieView(name: self.$name, type: self.$typePick, score: self.$score, year: self.year)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Name: View {
    @Binding var name: String
    
    var body: some View {
        TextField("閣下怎麼稱呼😊?", text: self.$name)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.yellow, lineWidth: 3))
    }
}

struct TypePicker: View {
    @Binding var type: Int
    
    let types=["浪漫", "恐怖", "動作", "喜劇", "動畫"]
    
    var body: some View {
        Picker("電影類別",selection: self.$type){
            ForEach(0 ..< types.count) { (index) in
                Text(self.types[index])
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}

struct ScoreSlider: View {
    @Binding var score: Double
    
    var body: some View {
        Slider(value: $score, in: 0...10,step: 0.5, minimumValueLabel: Text("0分"), maximumValueLabel:Text("10分")){
            Text("IMDb分數")
            
        }.accentColor(.green)
    }
}

struct ScoreStepper: View {
    @Binding var score: Double
    
    var body: some View {
        Stepper("IMDB評分：" + String(format: "%.1f", score), value: $score, in: 0 ... 10)
    }
}
