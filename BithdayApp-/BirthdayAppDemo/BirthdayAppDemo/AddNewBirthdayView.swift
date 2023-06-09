

import SwiftUI

class AddNewBdayData: ObservableObject {
    @Published var name: String = ""
    @Published var date: Date = Date()
}

struct AddNewBirthdayView: View {
    @Binding var addNewPresented: Bool
    @ObservedObject var newData = AddNewBdayData()
    private let viewModel = AddNewBirthdayViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.titleText)
                    .font(.title)
                Spacer()
            }
            .padding(.bottom, 10)
            
            TextField("your name ", text: $newData.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .foregroundColor(.black)
            
            VStack {
                Text("Date of birth")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Rectangle().fill(Color.blue))
                
                DatePicker(selection: $newData.date, in: ...Date(), displayedComponents: .date) {
                    Text("")
                }.labelsHidden()
            }.clipShape(RoundedRectangle(cornerRadius: 20))
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
            .padding()
            .shadow(radius: 5)
            
            HStack (spacing: 30) {
                Button(action: {self.addNewPresented.toggle()}) {
                    Text("Cancel")
                    .bold()
                }.padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                
                Button(action: {self.addNew()}) {
                    Text("Save")
                    .bold()
                }.padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            
            Spacer()
        }.foregroundColor(.white)
        .padding()
            .padding(.top, 50)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: .leading, endPoint: .trailing))
            .onTapGesture {
                DismissKeyboardHelper.dismiss()
            } .edgesIgnoringSafeArea(.all)
    }
    
    func addNew() {
        let birthday = BirthdayViewModel(id: UUID(), name: newData.name, date: newData.date)
        viewModel.saveBirthday(birthday: birthday)
        addNewPresented.toggle()
    }
}

struct AddNewBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBirthdayView(addNewPresented: .constant(true))
    }
}
