import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000"; // use your PC IP if on phone

  // ========== Auth ==========
  static Future login(String email, String password) async {
    var url = Uri.parse("$baseUrl/api/auth/login");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return jsonDecode(response.body);
  }

  static Future register(String name, String email, String password) async {
    var url = Uri.parse("$baseUrl/api/auth/register");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );
    return jsonDecode(response.body);
  }

  // ========== Movies ==========
  static Future getMovies() async {
    var url = Uri.parse("$baseUrl/api/movies");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  // ========== Ratings ==========
  static Future addRating(String movieId, int rating) async {
    var url = Uri.parse("$baseUrl/api/ratings");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"movieId": movieId, "rating": rating}),
    );
    return jsonDecode(response.body);
  }

  // ========== Watchlist ==========
  static Future addToWatchlist(String movieId) async {
    var url = Uri.parse("$baseUrl/api/watchlist");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"movieId": movieId}),
    );
    return jsonDecode(response.body);
  }

  static Future getWatchlist() async {
    var url = Uri.parse("$baseUrl/api/watchlist");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  // ========== Reviews ==========
  static Future addReview(String movieId, String review) async {
    var url = Uri.parse("$baseUrl/api/reviews");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"movieId": movieId, "review": review}),
    );
    return jsonDecode(response.body);
  }

  static Future getReviews(String movieId) async {
    var url = Uri.parse("$baseUrl/api/reviews?movieId=$movieId");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  // ========== Recommendations ==========
  static Future getRecommendations() async {
    var url = Uri.parse("$baseUrl/api/recommendations");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  // ========== User ==========
  static Future getUserProfile() async {
    var url = Uri.parse("$baseUrl/api/user");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}