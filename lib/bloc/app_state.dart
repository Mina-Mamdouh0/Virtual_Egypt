
abstract class AppState {}

class InitialState extends AppState{}

//Auth
class LoadingLoginScreen extends AppState{}
class SuccessLoginScreen extends AppState{}
class ErrorLoginScreen extends AppState{}
class VisiblePasswordLogin extends AppState{}
class GetDarkTheme extends AppState{}
class SetDarkTheme extends AppState{}

class LoadingSignUpScreen extends AppState{}
class ErrorSignUpScreen extends AppState{}
class LoadingCreateUserScreen extends AppState{}
class SuccessCreateUserScreen extends AppState{}
class ErrorCreateUserScreen extends AppState{}

class LoadingGetUserScreen extends AppState{}
class SuccessGetUserScreen extends AppState{}
class ErrorGetUserScreen extends AppState{}

class LogoutState extends AppState{}

//post
class LoadingAddPost extends AppState{}
class SuccessAddPost extends AppState{}
class ErrorAddPost extends AppState{}

class LoadingPostWithImage extends AppState{}
class SuccessPostWithImage extends AppState{}
class ErrorPostWithImage extends AppState{}
class ShowImagePost extends AppState{}
class ClearImagePost extends AppState{}

//trip
class LoadingTripState extends AppState{}
class SuccessTripState extends AppState{}
class ErrorTripState extends AppState{}

//product
class LoadingProductState extends AppState{}
class SuccessProductState extends AppState{}
class ErrorProductState extends AppState{}

//setting
class ChangeImageState extends AppState{}

class LoadingEditInfo extends AppState{}
class SuccessEditInfo extends AppState{}
class ErrorEditInfo extends AppState{}

class LoadingRatApp extends AppState{}
class SuccessRatApp extends AppState{}
class ErrorRatApp extends AppState{}

//Ads
class LoadingAdsState extends AppState{}
class SuccessAdsState extends AppState{}
class ErrorAdsState extends AppState{}

