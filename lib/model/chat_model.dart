class ChatModel{
  final String message;
  final String id;

  ChatModel(this.message,this.id);
  factory ChatModel.jsonDate(date){
    return ChatModel(date['message'],date['id']);
  }
}