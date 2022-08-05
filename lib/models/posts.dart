import 'dart:convert';
import 'package:http/http.dart' as http;

class Posts {
  Posts({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

List<Posts> postsFromJson(String str) =>
    List<Posts>.from(json.decode(str).map((x) => Posts.fromJson(x)));

String postsToJson(List<Posts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Client {
//   Future<List<Posts>> getPosts() async {
//     var client = http.Client();

//     var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//     var response = await client.get(url);
//     if (response.statusCode == 200) {
//       var json = response.body;
//       return postsFromJson(json);
//     }
//   }
// }

Future<List<Posts>> getPosts() async {
  const url = 'https://jsonplaceholder.typicode.com/posts';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var json = response.body;
    return postsFromJson(json);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
