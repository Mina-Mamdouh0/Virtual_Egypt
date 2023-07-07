class SignUpModel{
  final String firstName;
  final String lastName;
  final String lung;
  final String nationality;
  final String email;
  final String phone;
  final String uId;
  final String profile;
  final String password;
  final double rating;
  final double rateApp;
  final String rateMsgApp;
  final String typeAccount;

  SignUpModel({required this.rating,required this.rateApp,required this.rateMsgApp,required this.firstName,required this.lastName,required this.email,required this.phone,required this.uId,required this.profile,required this.nationality,
  required this.password,required this.lung,required this.typeAccount});

  factory SignUpModel.formJson(Map<String, dynamic> json,){
    return SignUpModel(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      lung: json['Lung'],
      nationality: json['Nationality'],
      email:json['Email'],
      phone: json['Phone'],
      uId: json['Id'],
      typeAccount: json['TypeAccount'],
      password: json['Password'],
      profile: json['Profile'],
      rateApp: json['RateApp'],
      rateMsgApp: json['RateMsgApp'],
      rating: json['Rating'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Lung': lung,
      'Nationality': nationality,
      'Email':email,
      'Phone': phone,
      'Id': uId,
      'TypeAccount': typeAccount,
      'Password': password,
      'Profile': profile,
      'RateApp': rateApp,
      'RateMsgApp': rateMsgApp,
      'Rating': rating,
    };

  }
}