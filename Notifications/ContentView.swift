//
//  ContentView.swift
//  Notifications
//
//  Created by Juan on 11/03/20.
//  Copyright © 2020 usuario. All rights reserved.
//

import SwiftUI
import UserNotifications


struct ContentView: View {
    
    @State var show = false
    var body: some View {
  
        
        NavigationView{
            ZStack{
                  //View Home
                  NavigationLink(destination: Detail(show: self.$show ), isActive: self.$show){
                      Text("")
                  }
                  
                  Button(action:{
                      self.send()
                  }){
                      Text("Enviar Notificacion")
                  }.navigationBarTitle("Home")
              }.onAppear {
                
                  NotificationCenter.default.addObserver(forName:
                         NSNotification.Name("Detail"), object: nil, queue: .main){(_) in
                      
                      self.show = true
                  }
              }
        }
        
    }
    func send(){
        //permisos para Autorizar
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) {(_, _) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Mensaje de alerta de Juan"
        
        let open = UNNotificationAction(identifier: "open", title: "Open", options:
            .foreground)
        
        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
        
        let categories = UNNotificationCategory(identifier: "action", actions: [open,cancel], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        content.categoryIdentifier = "action"
        
        //Configuracion de la notificacion Tiempo para la accion 
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
        
        //se trae la accion trigger y contenido req (tiempo,notificar) y termino de la accion
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
      
struct Detail: View {
    //se trae el valor de otro view
    @Binding var show : Bool
    var body: some View{
      
        Text("Detail View")
            .navigationBarTitle("Detail")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                
            Button(action:{
                self.show = false
                
            }, label: {
                Image(systemName:"arrow.left").font(.title)
            })

        )
    }
}
