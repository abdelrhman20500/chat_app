class Message{
  late String message;
  final String id;
  Message(this.message, this.id);
  factory Message.fromJson(jsonData){
    return Message(jsonData["messages"], jsonData["id"]);
  }
}