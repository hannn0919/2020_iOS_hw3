//
//  MovieView.swift
//  2020_iOS_hw3
//
//  Created by Hannn on 2020/5/3.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI

struct MovieView: View {
    @Binding var name: String
    @Binding var type: Int
    @Binding var score: Double
    var year: Int
    
    var body: some View {
        
        ScrollView{
            VStack{
                Spacer()
                Spacer()
                Text("早安午安晚安，\(name)😊\n推薦您這部片🍿️")
                    .font(.system(size: 23))
                detailView(type: self.type, year: self.year, score: self.score)
            }
        }
    }
}

struct detailView: View {
    var type: Int
    var year: Int
    var score: Double
    
    var body: some View {
        
        let pick = self.choose(type: type, year: year, score: score)
        
        return VStack{
            if type == 0 {
                
                information(pick: pick, type: 0)
                
            }
            else if type == 1 {
                
                information(pick: pick, type: 1)
                
            }
            else if type == 2 {
                
                information(pick: pick, type: 2)
                
            }
            else if type == 3 {
                
                information(pick: pick, type: 3)
                
            }
            else if type == 4 {
                
                information(pick: pick, type: 4)
                
            }
            
            
        }
        .background(Color(red:91/255, green:179/255, blue:199/255))
    }
    
    func choose(type: Int, year: Int, score: Double) -> Int{
        var randNum: Range<Int> = 0 ..< 1
        var pickindex = 0
        
        if type == 0{
            for i in 0 ..< romanticMovies.count {
                if romanticMovies[i].year >= year && romanticMovies[i].score >= score {
                    return i
                }
                randNum = 0 ..< romanticMovies.count
            }
        }
        else if type == 1{
            for i in 0 ..< horrorMovies.count {
                if horrorMovies[i].year >= year && horrorMovies[i].score >= score {
                    return i
                }
                randNum = 0 ..< horrorMovies.count
            }
        }
        else if type == 2{
            for i in 0 ..< actionMovies.count {
                if actionMovies[i].year >= year && actionMovies[i].score >= score {
                    return i
                }
                randNum = 0 ..< actionMovies.count
            }
        }
        else if type == 3{
            for i in 0 ..< comedyMovies.count {
                if comedyMovies[i].year >= year && comedyMovies[i].score >= score {
                    return i
                }
                randNum = 0 ..< comedyMovies.count
            }
        }
        else if type == 4{
            for i in 0 ..< animationMovies.count {
                if animationMovies[i].year >= year && animationMovies[i].score >= score {
                    return i
                }
                randNum = 0 ..< animationMovies.count
            }
        }
        pickindex = randNum.randomElement()!
        return pickindex
    }
}

struct information: View{
    let pick: Int
    let type: Int
    let classfication = [romanticMovies, horrorMovies, actionMovies, comedyMovies, animationMovies]
    @State private var showImg = true
    
    var body: some View {
        VStack{
            
            if(showImg) {
                Image(classfication[type][pick].img)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width:300, height:400)
                    .transition(.opacity)
                    .contextMenu {
                        Button(action: {
                            self.showImg = false
                        }) {
                            Text("我不想看到圖片")
                            Image(systemName: "eye.slash")
                        }
                        Button(action: {}) {
                            Text("沒事按好玩的")
                            Image(systemName: "flame")
                        }
                }
                .onAppear {
                    self.showImg = true
                    
                }
                .onDisappear {
                    self.showImg = false
                }
            }
            
            
            Text(classfication[type][pick].name)
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(40)
            
            
            Spacer()
            
            Text("上映年份：\(classfication[type][pick].year)")
                .font(.system(size: 15))
            
            
            Spacer()
            
            Text("IMDb得分：" + String(format: "%.1f", classfication[type][pick].score))
                .font(.system(size: 20))
                .foregroundColor(.red)
            
            
            Spacer()
            
            Text(classfication[type][pick].description)
            
            Spacer()
            
            Button("Netflix看片去🏃"){
                if let url = URL(string: self.classfication[self.type][self.pick].link) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
            }
            .frame(width:180,height:20)
            .padding()
            .font(.system(size: 20))
            .background(Color(red:61/255, green:61/255, blue:61/255))
            .cornerRadius(15)
            .foregroundColor(.red)
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(red:61/255, green:61/255, blue:61/255), lineWidth: 3))
        }
        .animation(.easeInOut(duration:1.5))
    }
}
