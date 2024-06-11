//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Walter Bernal Montero on 6/11/24.
//

import SwiftUI

struct Onboarding: View {
    private static let INVALID_FIRST_NAME: String = "\nFirst name can only contain letters and must be at least 4 characters.\n"
    private static let INVALID_LAST_NAME: String = "\nLast name can only contain letters and must be at least 4 characters.\n"
    private static let INVALID_EMAIL = "\nThe e-mail is invalid.\n"
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var showFormInvalidField: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("First name: ")
                    TextField("John", text: $firstName)
                }
                HStack {
                    Text("Last name: ")
                    TextField("Doe", text: $lastName)
                }
                HStack {
                    Text("E-mail: ")
                    TextField("john.doe@mail.com", text: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                Button(
                    action: { validateForm()},
                    label: { Text("Submit") }
                )
                .padding(.init(top:10, leading: 30, bottom: 10, trailing: 30))
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 10)
            }
            .alert(isPresented: $showFormInvalidField) {
                Alert(
                    title: Text("Form Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func validateForm() {
        let firstNameValid = isValid(firstName)
        let lastNameValid = isValid(lastName)
        let emailValid = isValid(email: email)
        
        guard firstNameValid, lastNameValid, emailValid
        else {
            self.errorMessage = ""
            if (firstName.isEmpty || !firstNameValid) {
                self.errorMessage += Onboarding.INVALID_FIRST_NAME
            }
            if (lastName.isEmpty || !lastNameValid) {
                self.errorMessage += Onboarding.INVALID_LAST_NAME
            }
            if (email.isEmpty || !emailValid) {
                self.errorMessage += Onboarding.INVALID_EMAIL
            }

            showFormInvalidField.toggle()
            return
        }
    }
    
    private func isValid(_ name: String) -> Bool {
        guard !name.isEmpty, name.count > 2
        else {
            return false
        }
        for char in name  {
            if (!(char >= "a" && char <= "z") && !(char >= "A" && char <= "Z") && !(char == " ") ) {
                return false
            }
        }
        return true
    }
    
    private func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
