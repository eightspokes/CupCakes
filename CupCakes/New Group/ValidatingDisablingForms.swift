//
//  ValidatingDisablingForms.swift
//  CupCakes
//
//  Created by Roman on 12/24/22.
//

import SwiftUI

struct ValidatingDisablingForms: View {
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form{
            Section{
                TextField("Username", text: $username)
                TextField("Email",text: $email )
            }
            Section{
                Button("Create account"){
                    print("Creating account")
                }
            }
            .disabled(disabledForm)
            
        }
    }
    var disabledForm: Bool{
        username.count < 5 || email.count < 5
    }
}

struct ValidatingDisablingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingDisablingForms()
    }
}
