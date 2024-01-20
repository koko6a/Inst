//
//  UserCell.swift
//  Inst
//
//  Created by Кащенко on 19.01.24.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            Image("koko6a")
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Koko6a")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("Ruslan Kashchenko")
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
    }
}

#Preview {
    UserCell()
}
