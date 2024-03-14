class MyUser{
  static const collectionName = "users";
  late String id;
  late String email;
  late String username;

  MyUser({required this.id, required this.email, required this.username});

  MyUser.fromJson(Map json){
    id = json["id"];
    email = json["email"];
    username = json["username"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "username": username,
      "email": email
    };
  }
}