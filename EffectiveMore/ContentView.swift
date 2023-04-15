//
//  ContentView.swift
//  EffectiveMore
//
//  Created by id on 4/14/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var timeRemaining = 25
    @State private var timerIsRunning = false
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
                
        VStack {
            
            Spacer()
            
            HStack {
                Image(systemName: "clock")
                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                
                Text(timerIsRunning ? "剩余分钟" : "番茄时钟")
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .foregroundColor(timerIsRunning ? Color.red : Color.primary)
                    .padding()
                
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 50, weight: .bold, design: .monospaced))
            }
            
            Spacer()
            
            Image(systemName: "arrow.down")
                .font(.system(size: 100, weight: .heavy, design: .monospaced))
            
            Spacer()
            
            ZStack {
                Circle()
                    .trim(from: 0.0, to: timerIsRunning ? CGFloat(Float(timeRemaining)) / CGFloat(Float(25)) : CGFloat(Float(25)))
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .foregroundColor(timerIsRunning ? Color.red : Color.primary)
                    .rotationEffect(Angle(degrees: 270))
                
                Text(timerIsRunning ? "\(timeRemaining)" : "25")
                    .font(.system(size: 130, weight: .bold, design: .monospaced))
                    .foregroundColor(timerIsRunning ? Color.red : Color.primary)
            }
            .frame(width: 200, height: 200)
            
            if timerIsRunning {
                
                HStack {
                    Image(systemName: timeRemaining == 0 ? "cup.and.saucer.fill" : "clock.badge")
                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.primary)
                        
                        Text(timeRemaining == 0 ? "休息5分钟！" : "计时中..")
                            .font(.system(size: 50, weight: .heavy, design: .rounded))
                            .foregroundColor(Color.primary)
                    }
                }
            
            Spacer()
            
            
            if timeRemaining == 0 {
                HStack {
                    Spacer(minLength: 187)
                    Text("重新计时")
                        .foregroundColor(.blue)
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                    Spacer()
                }
            }
                
                
            HStack {
                Button(action: {
                    timerIsRunning.toggle()
                }) {
                    Image(systemName: timerIsRunning ? "pause.circle" : "play.circle" )
                        .foregroundColor(timerIsRunning ? Color.red : Color.primary)
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                }
                
                Spacer()
             

                    
                Button(action: {
                    timerIsRunning = false
                    timeRemaining = 25
                }) {
                    Image(systemName: "stop.circle")
                        .foregroundColor(Color(.red))
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                }
            }
            .padding(.horizontal, 70)
        }
        .onReceive(timer, perform: { _ in
            if timerIsRunning && timeRemaining > 0 {
                timeRemaining -= 1
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            timerIsRunning = false
        }
        .background(Color("Bg"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

