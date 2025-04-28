//
//  UpcomingRemindersView.swift
//  Wishy
//
//  Created by Karim Amsha on 30.04.2024.
//

import SwiftUI

struct UpcomingRemindersView: View {
    let items = Array(1...5)
    @EnvironmentObject var appRouter: AppRouter

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(items, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("عنوان المناسبة")
                                .customFont(weight: .bold, size: 14)

                            HStack(spacing: 30) {
                                Text("تاريخ التذكير: 25 مارس 2024")
                                Text("الساعة: 10:00 م")
                            }
                            .customFont(weight: .regular, size: 12)
                        }
                        
                        CustomDivider(color: .grayF2F2F2())
                    }
                    .foregroundColor(.primaryBlack())
                    .onTapGesture {
                        appRouter.navigate(to: .orderDetails)
                    }
                }
            }
            
            Spacer()
            
            Button {
                //
            } label: {
                Text(LocalizedStringKey.addNewReminder)
            }
            .buttonStyle(GradientPrimaryButton(fontSize: 16, fontWeight: .bold, background: Color.primaryGradientColor(), foreground: .white, height: 48, radius: 12))
        }
        .padding(16)
        .navigationBarBackButtonHidden()
        .background(Color.background())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Button {
                        appRouter.navigateBack()
                    } label: {
                        Image("ic_back")
                    }

                    Text(LocalizedStringKey.upcomingReminders)
                        .customFont(weight: .bold, size: 20)
                        .foregroundColor(Color.primaryBlack())
                }
            }
        }
    }
}

#Preview {
    UpcomingRemindersView()
}
