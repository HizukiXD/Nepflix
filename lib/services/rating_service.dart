import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RatingService {
  static String get baseUrl => dotenv.env['BACKEND_URL'] ?? 'http://localhost:5000';

  // ========== Add / Update Rating & Comment ==========
  static Future addRatingAndComment({
    required String movieTitle,
    required String userId, // unused, kept for compatibility
    required double rating,
    required String comment,
    required String token,
  }) async {
    var url = Uri.parse("$baseUrl/api/ratings");
    // Scale rating from 0-5 stars → 1-10 backend range
    final backendRating = (rating * 2).clamp(1, 10).toInt();
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "movieTitle": movieTitle,
        "rating": backendRating,
        "comment": comment,
      }),
    );
    return jsonDecode(response.body);
  }

  // ========== Get Ratings & Comments for Movie ==========
  static Future getMovieRatings(String movieTitle) async {
    var url = Uri.parse("$baseUrl/api/ratings?movieTitle=${Uri.encodeComponent(movieTitle)}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return {"ratings": []};
  }

  // ========== Get User's Movie Rating ==========
  static Future getUserRating({
    required String movieTitle,
    required String userId, // unused, kept for compatibility
    required String token,
  }) async {
    var url = Uri.parse("$baseUrl/api/ratings/user?movieTitle=${Uri.encodeComponent(movieTitle)}");
    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Convert backend rating (1-10) back to stars (0-5)
      if (data['rating'] != null) {
        data['rating']['rating'] = (data['rating']['rating'] / 2.0);
      }
      return data;
    }
    return {"rating": null};
  }

  // ========== Delete Rating ==========
  static Future deleteRating({
    required String movieTitle,
    required String userId, // unused, kept for compatibility
    required String token,
  }) async {
    var url = Uri.parse("$baseUrl/api/ratings");
    var response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "movieTitle": movieTitle,
      }),
    );
    return jsonDecode(response.body);
  }

  // ========== Get Average Rating for Movie ==========
  static Future getAverageRating(String movieTitle) async {
    var url = Uri.parse("$baseUrl/api/ratings/average?movieTitle=${Uri.encodeComponent(movieTitle)}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Convert backend average (1-10) to stars (0-5)
      if (data['averageRating'] != null) {
        data['averageRating'] = (data['averageRating'] / 2.0);
      }
      return data;
    }
    return {"averageRating": 0.0, "totalRatings": 0};
  }

  // ========== Get Top Rated Movies ==========
  static Future getTopRatedMovies({int limit = 10}) async {
    var url = Uri.parse("$baseUrl/api/ratings/top-rated?limit=$limit");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return {"movies": []};
  }
}
