import 'package:flutter/material.dart';
import 'movie_detail_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'profile_screen.dart';
import 'all_movies_screen.dart';
import 'top_rated_movies_screen.dart';
import 'popular_movies_screen.dart';
import 'dart:async';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();

  // ⭐ ALL MOVIES (merged for reuse) - Expanded with more Nepali movies
  static final List<Map<String, String>> allMovies = [
    // Original movies
    {
      'title': 'Jerry on Top',
      'rating': '9.2',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BODk5Mzg4YzAtMzRhZC00MWQ5LWE1OWEtYTU1NWFhYWQzNTYwXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/KZiwCrGUZNk/maxresdefault.jpg',
      'description': 'Comedy adventures of Jerry.',
      'youtubeId': 'KZiwCrGUZNk',
    },
    {
      'title': 'Aama',
      'rating': '9.0',
      'genre': 'Drama',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/2/25/Aama_%282020_film%29.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/RRv_IJSQweM/maxresdefault.jpg',
      'description': 'Emotional mother-son story.',
      'youtubeId': 'RRv_IJSQweM',
    },
    {
      'title': 'Laaj Sharanam',
      'rating': '8.8',
      'genre': 'Action',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNmVkYzczY2MtZGViNi00Y2Q5LWFkMTUtODNmMTkxY2ZmMGE5XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/48-rWlGPeVc/sddefault.jpg',
      'description': 'Action and justice story.',
      'youtubeId': '48-rWlGPeVc',
    },
    {
      'title': 'Jaari',
      'rating': '8.9',
      'genre': 'Horror',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMzI2NjZiNGMtNmY5MC00Y2JlLWFmY2QtNDU2NmM4OGNlYmFhXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/5O3K8JXch1E/maxresdefault.jpg',
      'description': 'Supernatural horror.',
      'youtubeId': '5O3K8JXch1E',
    },
    {
      'title': 'Unko Sweater',
      'rating': '8.8',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BM2IzZWYyNTMtZjRkZi00YzNmLWFjZGQtNDlhNGUzMTE5YTNhXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/hWZQ0kaTbXU/maxresdefault.jpg',
      'description': 'Comedy and friendship story.',
      'youtubeId': 'hWZQ0kaTbXU',
    },
    {
      'title': 'Kalo Pothi',
      'rating': '7.8',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNjRiNTA1NzgtYTdiYy00N2QwLWEwMDgtNzM2ZjZiYWY5YmU0XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/74gClGeD5D8/sddefault.jpg',
      'description': 'Dark drama.',
      'youtubeId': '74gClGeD5D8',
    },
    {
      'title': 'Kabaddi Kabaddi 4',
      'rating': '7.8',
      'genre': 'Sports',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNDkzMGRjOWYtMGYyMy00ZTQ1LWI5NjQtNWJhODI2N2I4ZDAzXkEyXkFqcGc@._V1_QL75_UX151_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/zOJwj88rQuE/maxresdefault.jpg',
      'description': 'Sports drama.',
      'youtubeId': 'zOJwj88rQuE',
    },
    {
      'title': 'Talakjung vs Tulke',
      'rating': '8.0',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BN2YyY2QxMTAtNmFhNy00MGFlLTgwODMtYjcyYzVlZTMwN2Y2XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/Zl-JXV0JTzw/hq720.jpg',
      'description': 'Comedy battle.',
      'youtubeId': 'Zl-JXV0JTzw',
    },
    {
      'title': 'Pashupati Prasad',
      'rating': '8.6',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMDIxYTJlY2EtMzlmZi00MjUzLWJlNmUtNWE5NjJjYTQ0NjUwXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/xGOIMWh2FfE/maxresdefault.jpg',
      'description': 'Satirical comedy.',
      'youtubeId': 'xGOIMWh2FfE',
    },
    {
      'title': 'Loot',
      'rating': '8.5',
      'genre': 'Thriller',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/c/c3/Loot_2012_film.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/oRjjJ5LkGPY/maxresdefault.jpg',
      'description': 'Heist thriller.',
      'youtubeId': 'oRjjJ5LkGPY',
    },
    {
      'title': 'Loot 2',
      'rating': '8.7',
      'genre': 'Thriller',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJp9FKRYNsh8jZ6YK0i9psmBFqsywshnYMjg&s',
      'detailImage':
          'https://i.ytimg.com/vi/oRjjJ5LkGPY/maxresdefault.jpg',
      'description': 'Heist thriller sequel.',
      'youtubeId': 'oRjjJ5LkGPY',
    },
    
    // New Nepali Movies Added
    {
      'title': 'Chhadke',
      'rating': '7.5',
      'genre': 'Thriller',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNjJiYTI0MTEtNDk0OS00YmQ2LThjNjQtZjU5Yjk5OWUxMjRjXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/Sv54RX3Hv5Q/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBJjixfS8uBYDAaszQ-rQ4W9Ukk5A',
      'description': 'Chhadke is a Nepalese film that tells the story of two best friends who had dreams to fulfill when they grew up, but time and destiny seem to have other plans.',
      'youtubeId': 'Sv54RX3Hv5Q',
    },
    {
      'title': 'Prem Geet',
      'rating': '8.3',
      'genre': 'Romance',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZTMwNTEwMmQtOGEyMS00M2FiLWI2YzAtZWQ3NDRhMDY1MjhkXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/7uzbmUrT8Tg/maxresdefault.jpg',
      'description': 'A beautiful romantic story set in the hills of Nepal.',
      'youtubeId': '7uzbmUrT8Tg',
    },
    {
      'title': 'Prem Geet 2',
      'rating': '8.5',
      'genre': 'Romance',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZGEyMDQ3NDEtYzViZC00YmNmLWI4ZDEtMzVlNGZjYjNiODYxXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/SSMUBhsxICo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAFiA1FTyzKvxl9yka4-A3LK6_bVw',
      'description': 'The sequel to the hit romantic drama.',
      'youtubeId': 'SSMUBhsxICo',
    },
    {
      'title': 'Chhakka Panja',
      'rating': '8.4',
      'genre': 'Comedy',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYaSWHaot79XIHdlWFeaejJ8PrmadtwrbSWQ&s',
      'detailImage':
          'https://i.ytimg.com/vi/u5NJUF-M6pc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLD9U6vW6Yy1AHEoP0GM1XHdn8A41w',
      'description': 'A hilarious comedy about friendship and relationships.',
      'youtubeId': 'u5NJUF-M6pc',
    },
    {
      'title': 'Chhakka Panja 2',
      'rating': '8.6',
      'genre': 'Comedy',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPb_-w3AK2qVPvwPHClb3Da2jnUZ5ycSouXA&s',
      'detailImage':
          'https://i.ytimg.com/vi/q1BzJ6na4Nc/maxresdefault.jpg',
      'description': 'The blockbuster comedy sequel.',
      'youtubeId': 'q1BzJ6na4Nc',
    },
    {
      'title': 'Chhakka Panja 3',
      'rating': '8.2',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYjVjMjFjMTEtYWM5OC00ZTA1LWJkMjMtNzZhZjRlZGU4MzVmXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDlwTvBsW8h2RcsEAoXQ5O0qGlV4ikZD5Kww&s',
      'description': 'The third installment of the hit comedy series.',
      'youtubeId': 'bl8CEwqC2Wo',
    },
    {
      'title': 'Nai Nabhannu La 2',
      'rating': '7.9',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZjdhN2FlZmMtNTFmZC00N2Q3LTlkMzEtZWFmYzEwYmI5YTRmXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://m.media-amazon.com/images/M/MV5BMjliN2U3NDItYzVlOC00NDc4LTg5MmItNzkzZjQzNWNjYWVhXkEyXkFqcGc@._V1_.jpg',
      'description': 'A Drama about love and misunderstandings.',
      'youtubeId': 'aRoObj9rnn0',
    },
    {
      'title': 'Kri',
      'rating': '8.0',
      'genre': 'Action',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNDI0OTFjNzMtZTdmZC00YWM4LThiZDgtN2U0M2FhOTYxMWQ0XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/aRoObj9rnn0/maxresdefault.jpg',
      'description': 'Action-packed thriller with a strong message.',
      'youtubeId': 'aRoObj9rnn0',
    },
    {
      'title': 'Jhola',
      'rating': '8.7',
      'genre': 'Horror',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMzkwYmRkY2MtYWZkMi00MjUwLTlhODEtMTdhZmE2OGM5YmI3XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/DnbxfA3xVaY/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB1kLFa6-L5KxHwJD7z-75EU6BlVQ',
      'description': 'A powerful drama about social issues in Nepal.',
      'youtubeId': 'DnbxfA3xVaY',
    },
    {
      'title': 'Seto Surya',
      'rating': '8.4',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMmYzZDY2Y2QtYjAxNS00MTFjLWIwNWYtYmNkMzVhYjFmY2IzXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/3ZmAKH60Y0g/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLD3xwOoiSBaUiQ2x1OrlCoFSmlSaQ',
      'description': 'A poignant drama about the aftermath of civil war.',
      'youtubeId': '3ZmAKH60Y0g',
    },
    {
      'title': 'Gopi',
      'rating': '7.6',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzcxZGUxYTItYzA4Zi00ODE5LWFmNjktYmI3ZTNiZGEwNWQzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/2AN88_StD0w/maxresdefault.jpg',
      'description': 'A light-hearted comedy about village life.',
      'youtubeId': '2AN88_StD0w',
    },
    {
      'title': 'Suntali',
      'rating': '7.7',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNWRmODBkMzAtMGRlZC00YWM3LWJkMTEtNzM5OWUwNzdiZDI2XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://m.media-amazon.com/images/M/MV5BMmUzMGNmNTEtNWJmMy00YjU3LTgzMzQtZjljYTVkMTc2YTM3XkEyXkFqcGc@._V1_.jpg',
      'description': 'A comedy about a young woman\'s journey.',
      'youtubeId': 'fCfhY0E4GRo',
    },
    {
      'title': 'Mero Euta Saathi Chha',
      'rating': '8.1',
      'genre': 'Romance',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZTU0MmFmMDgtNGRhMy00MGVhLTk4MjctOTkwMmU0M2VhNmM1XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://m.media-amazon.com/images/M/MV5BZjEzNTFjZTQtNjI5Zi00Njk5LTkxOGItYzhjNGMwMTI5NDFkXkEyXkFqcGc@._V1_QL75_UX337_.jpg',
      'description': 'A touching love story set in modern Nepal.',
      'youtubeId': 'Uj8d504RYC4',
    },
    {
      'title': 'Kabbadi',
      'rating': '7.9',
      'genre': 'Comedy',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/9/9d/Nepali_Movie_Kabaddi_official_poster.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/fCfhY0E4GRo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLANT6KYDDGlzeugb5d5HaHmpLYv2A',
      'description': 'The first movie in the popular Kabbadi series about love and comedy.',
      'youtubeId': 'fCfhY0E4GRo',
    },
    {
      'title': 'Kabbadi 2',
      'rating': '8.0',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYmI3ZDM5N2ItNzNjYS00NzEyLWIyOGUtYThhZTA4ODU4YjFlXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/Uj8d504RYC4/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDDFu8Tf9uDGnL2CC8L8w7BXKvz7Q',
      'description': 'The sequel to the hit comedy love drama.',
      'youtubeId': 'Uj8d504RYC4',
    },
    {
      'title': 'Kabbadi 3',
      'rating': '8.2',
      'genre': 'Comedy',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYTBlODk3ODEtYWI0Mi00MzJiLTg3MDUtNWFiN2UzMzI5ZjRjXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/bl8CEwqC2Wo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBNXPXhAkJ8-zV5dmXkRGva3YNpnQ',
      'description': 'The third installment of the Kabbadi franchise.',
      'youtubeId': 'bl8CEwqC2Wo',
    },
    {
      'title': 'Kabbadi 4',
      'rating': '8.3',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYzcyZmE4OWQtNDAwZS00N2RmLTlmNWQtMDQyMjk2MDdkNTc5XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/zOJwj88rQuE/maxresdefault.jpg',
      'description': 'After the events of Kabaddi 3, Kaji now doesn\'t seek love as he is suffering from the pain of his previous relationships.',
      'youtubeId': 'zOJwj88rQuE',
    },
    {
      'title': 'Prasad',
      'rating': '8.5',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNDY0NmIzMmEtYTc2OC00MGEzLTg4NzItMTYwMjVlNTZjODZlXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/_3HkoreYzWQ/maxresdefault.jpg',
      'description': 'A thought-provoking drama about life and spirituality.',
      'youtubeId': '_3HkoreYzWQ',
    },
    {
      'title': 'Dhanapati',
      'rating': '8.4',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMGJjYWZmMzUtMjc2Yi00ZDAyLWE1NjktODcxOTUxZDQ4M2ViXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/80zKdSyEQok/maxresdefault.jpg',
      'description': 'A powerful story about corruption and redemption.',
      'youtubeId': '80zKdSyEQok',
    },
    {
      'title': 'Captain',
      'rating': '7.8',
      'genre': 'Sports',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNjQxOTViMWMtZTVkNS00ZWRmLTgyZDMtN2RkNTE3NDc5MTQ2XkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/cEWA3hm_M0g/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAifTb2Vq7ZsD86aG0-kdjsh0Vzrg',
      'description': 'The film focuses on the emotional journey and football career of the lead character, aiming for personal redemption and national recognition.',
      'youtubeId': 'cEWA3hm_M0g',
    },
  ];

  // 🎬 Banner will use first 5 movies
  static final List<Map<String, String>> featuredMovies =
      allMovies.take(5).toList();

  // ⭐ Top Rated - Sorted by rating
  static List<Map<String, String>> get topRatedMovies {
    final sortedMovies = List<Map<String, String>>.from(allMovies);
    sortedMovies.sort((a, b) => 
      double.parse(b['rating']!).compareTo(double.parse(a['rating']!))
    );
    return sortedMovies.take(10).toList();
  }

  // 🔥 Popular - Top 12 by rating
  static final List<Map<String, String>> popularMovies = _getPopularMovies();

  static List<Map<String, String>> _getPopularMovies() {
    final sortedMovies = List<Map<String, String>>.from(allMovies);
    sortedMovies.sort((a, b) {
      final ratingA = double.tryParse(a['rating'] ?? '0') ?? 0;
      final ratingB = double.tryParse(b['rating'] ?? '0') ?? 0;
      return ratingB.compareTo(ratingA);
    });
    return sortedMovies.take(12).toList();
  }
}

class _FirstScreenState extends State<FirstScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  
  // GlobalKey for Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Authentication state
  Map<String, String>? _loggedInUser;
  
  // Wishlist tracking - stores movie titles
  final Set<String> _wishlist = {};
  
  // Timer for auto-slide
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    startAutoSlide();
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      setState(() {
        _currentPage = (_currentPage + 1) % FirstScreen.featuredMovies.length;
      });
      
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // Add or remove movie from wishlist
  void toggleWishlist(String movieTitle) {
    setState(() {
      if (_wishlist.contains(movieTitle)) {
        _wishlist.remove(movieTitle);
      } else {
        _wishlist.add(movieTitle);
      }
    });
  }

  // Show wishlist dialog
  void _showWishlistDialog() {
    if (_loggedInUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to view your wishlist'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final wishlistMovies = FirstScreen.allMovies
        .where((movie) => _wishlist.contains(movie['title']))
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: Text(
          'My Wishlist (${wishlistMovies.length})',
          style: const TextStyle(color: Colors.red, fontSize: 20),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: wishlistMovies.isEmpty
              ? const Center(
                  child: Text(
                    'No movies in your wishlist yet!',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: wishlistMovies.length,
                  itemBuilder: (context, index) {
                    final movie = wishlistMovies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              movie: movie,
                              userData: _loggedInUser,
                              isInWishlist: true,
                              onWishlistToggle: toggleWishlist,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        toggleWishlist(movie['title']!);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${movie['title']} removed from wishlist'),
                            backgroundColor: Colors.orange,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    movie['image'] ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[900],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.white54,
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () {
                                        toggleWishlist(movie['title']!);
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie['title'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow, size: 12),
                              const SizedBox(width: 3),
                              Text(
                                movie['rating'] ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Search movies by title
  void _searchMovies(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = FirstScreen.allMovies
            .where((movie) =>
                movie['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Show search overlay
  void _showSearchOverlay() {
    showDialog(
      context: context,
      builder: (context) => SearchDialog(
        searchController: _searchController,
        onSearch: _searchMovies,
        searchResults: _searchResults,
        userData: _loggedInUser,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0f0f0f),
        elevation: 0,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Nep',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'flix',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchOverlay,
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: _buildDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Recommendation Movie Title
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recommendation',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // Banner
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: FirstScreen.featuredMovies.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final movie = FirstScreen.featuredMovies[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(
                                  movie: movie,
                                  userData: _loggedInUser,
                                  isInWishlist: _wishlist.contains(movie['title']),
                                  onWishlistToggle: toggleWishlist,
                                ),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            movie['detailImage']!, 
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[900],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[900],
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.white54,
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 16,
                            child: Text(
                              movie['title']!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // My Wishlist Section
              if (_loggedInUser != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Wishlist (${_wishlist.length})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_wishlist.isNotEmpty)
                            GestureDetector(
                              onTap: _showWishlistDialog,
                              child: const Text(
                                'View All',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (_wishlist.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              'No movies in your wishlist yet!',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _wishlist.length,
                            itemBuilder: (context, index) {
                              final movieTitle = _wishlist.elementAt(index);
                              final movie = FirstScreen.allMovies.firstWhere(
                                (m) => m['title'] == movieTitle,
                                orElse: () => {},
                              ) as Map<String, String>?;
                              
                              if (movie == null || movie.isEmpty) return const SizedBox();
                              
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(
                                          movie: movie,
                                          userData: _loggedInUser,
                                          isInWishlist: true,
                                          onWishlistToggle: toggleWishlist,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          movie['image'] ?? '',
                                          width: 120,
                                          height: 160,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 120,
                                              height: 160,
                                              color: Colors.grey[900],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  color: Colors.white54,
                                                  size: 40,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          movie['title'] ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Colors.yellow, size: 14),
                                          const SizedBox(width: 3),
                                          Text(
                                            movie['rating'] ?? 'N/A',
                                            style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              sectionTitle(context, "Top Rated Movies (${FirstScreen.topRatedMovies.take(6).length})"),
              movieList(FirstScreen.topRatedMovies.take(6).toList()),
              const SizedBox(height: 20),
              sectionTitle(context, "Popular Movies (${FirstScreen.popularMovies.take(6).length})"),
              movieList(FirstScreen.popularMovies.take(6).toList()),
              const SizedBox(height: 20),
              sectionTitle(context, "All Movies (${FirstScreen.allMovies.take(6).length})"),
              movieList(FirstScreen.allMovies.take(6).toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0f0f0f),
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1a1a1a),
              border: Border(
                bottom: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile icon and username row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _loggedInUser != null
                                ? _loggedInUser!['username'] ?? 'User'
                                : 'Guest',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _loggedInUser != null
                                ? _loggedInUser!['email'] ?? ''
                                : 'Not logged in',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Nep',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'flix',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your Movie Hub',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Main Menu Items
          _drawerMenuItem(
            icon: Icons.home,
            label: 'Home Page',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _drawerMenuItem(
            icon: Icons.star,
            label: 'Top Rated Movies',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopRatedMoviesScreen(
                    userData: _loggedInUser,
                    wishlist: _wishlist,
                    onWishlistToggle: toggleWishlist,
                  ),
                ),
              );
            },
          ),
          _drawerMenuItem(
            icon: Icons.local_fire_department,
            label: 'Popular Movies',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PopularMoviesScreen(
                    userData: _loggedInUser,
                    wishlist: _wishlist,
                    onWishlistToggle: toggleWishlist,
                  ),
                ),
              );
            },
          ),
          _drawerMenuItem(
            icon: Icons.movie,
            label: 'All Movies',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllMoviesScreen(
                    userData: _loggedInUser,
                    wishlist: _wishlist,
                    onWishlistToggle: toggleWishlist,
                  ),
                ),
              );
            },
          ),
          
          const Divider(color: Colors.white24, height: 16),
          
          // Categories Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'CATEGORIES',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          _drawerCategoryItem(
            icon: Icons.theater_comedy,
            label: 'Comedy',
            genre: 'Comedy',
          ),
          _drawerCategoryItem(
            icon: Icons.movie,
            label: 'Drama',
            genre: 'Drama',
          ),
          _drawerCategoryItem(
            icon: Icons.sports_mma,
            label: 'Action',
            genre: 'Action',
          ),
          _drawerCategoryItem(
            icon: Icons.movie,
            label: 'Horror',
            genre: 'Horror',
          ),
          _drawerCategoryItem(
            icon: Icons.sports,
            label: 'Sports',
            genre: 'Sports',
          ),
          _drawerCategoryItem(
            icon: Icons.security,
            label: 'Thriller',
            genre: 'Thriller',
          ),
          _drawerCategoryItem(
            icon: Icons.favorite,
            label: 'Romance',
            genre: 'Romance',
          ),
          
          const Divider(color: Colors.white24, height: 16),
          
          // Account Section
          _drawerMenuItem(
            icon: Icons.login,
            label: 'Login',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              ).then((result) {
                if (result != null && result is Map<String, String>) {
                  setState(() {
                    _loggedInUser = result;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Welcome back, ${result['username']}!'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
          ),
          _drawerMenuItem(
            icon: Icons.app_registration,
            label: 'Sign Up',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(),
                ),
              ).then((result) {
                if (result != null && result is Map<String, String>) {
                  setState(() {
                    _loggedInUser = result;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Welcome, ${result['username']}!'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
          ),
          _drawerMenuItem(
            icon: Icons.person,
            label: 'Profile',
            enabled: _loggedInUser != null,
            onTap: () {
              if (_loggedInUser != null) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(userData: _loggedInUser),
                  ),
                ).then((result) {
                  if (result != null && result is Map<String, String>) {
                    if (result['isLoggedIn'] == 'false') {
                      setState(() {
                        _loggedInUser = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You have been logged out'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                });
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please login first to access your profile'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          
          const Divider(color: Colors.white24, height: 16),
          
          // Additional Features
          _drawerMenuItem(
            icon: Icons.bookmark,
            label: 'My Wishlist',
            enabled: _loggedInUser != null,
            onTap: () {
              Navigator.pop(context);
              if (_loggedInUser != null) {
                _showWishlistDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please login to view your wishlist'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
          _drawerMenuItem(
            icon: Icons.info,
            label: 'About',
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog();
            },
          ),
          
          const Divider(color: Colors.white24, height: 32),
          
          // Version Text
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: enabled ? Colors.red : Colors.grey),
      title: Text(
        label,
        style: TextStyle(
          color: enabled ? Colors.white : Colors.grey,
          fontSize: 16,
        ),
      ),
      enabled: enabled,
      onTap: enabled ? onTap : null,
      hoverColor: Colors.white12,
      splashColor: Colors.red.withOpacity(0.3),
    );
  }

  Widget _drawerCategoryItem({
    required IconData icon,
    required String label,
    required String genre,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue, size: 22),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _showMoviesByGenre(genre);
      },
      hoverColor: Colors.white12,
    );
  }

  void _showMoviesByGenre(String genre) {
    final genreMovies = FirstScreen.allMovies
        .where((movie) => movie['genre'] == genre)
        .toList();
    
    if (genreMovies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No $genre movies found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    _showMoviesDialog('$genre Movies (${genreMovies.length})', genreMovies);
  }

  void _showMoviesDialog(String title, List<Map<String, String>> movies) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                movie: movie,
                userData: _loggedInUser,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        movie: movie,
                        userData: _loggedInUser,
                        isInWishlist: _wishlist.contains(movie['title']),
                        onWishlistToggle: toggleWishlist,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text(
          'About NepFlix',
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
        content: const Text(
          'NepFlix v1.0.0\n\nYour favorite movie streaming app featuring the best Nepali movies.\n\nDeveloped with Flutter\n\nTotal Movies: 31+ Nepali Movies',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {
              if (title.contains('Top Rated')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopRatedMoviesScreen(
                      userData: _loggedInUser,
                      wishlist: _wishlist,
                      onWishlistToggle: toggleWishlist,
                    ),
                  ),
                );
              } else if (title.contains('Popular')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PopularMoviesScreen(
                      userData: _loggedInUser,
                      wishlist: _wishlist,
                      onWishlistToggle: toggleWishlist,
                    ),
                  ),
                );
              } else if (title.contains('All Movies')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllMoviesScreen(
                      userData: _loggedInUser,
                      wishlist: _wishlist,
                      onWishlistToggle: toggleWishlist,
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'See All',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget movieList(List<Map<String, String>> movies) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];

        return MovieCard(
          movie: movie,
          userData: _loggedInUser,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(
                  movie: movie,
                  userData: _loggedInUser,
                  isInWishlist: _wishlist.contains(movie['title']),
                  onWishlistToggle: toggleWishlist,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Movie Card Widget
class MovieCard extends StatelessWidget {
  final Map<String, String> movie;
  final VoidCallback? onTap;
  final Map<String, String>? userData;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie['image'] ?? '',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[900],
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[900],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie['title'] ?? 'Unknown',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 12),
              const SizedBox(width: 3),
              Text(
                movie['rating'] ?? 'N/A',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  movie['genre'] ?? 'N/A',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Search Dialog Widget
class SearchDialog extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final List<Map<String, String>> searchResults;
  final Map<String, String>? userData;

  const SearchDialog({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.searchResults,
    this.userData,
  });

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late TextEditingController _controller;
  late List<Map<String, String>> _results;

  @override
  void initState() {
    super.initState();
    _controller = widget.searchController;
    _results = widget.searchResults;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1a1a1a),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF0f0f0f),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search movies by title...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.red),
                    ),
                    onChanged: (query) {
                      widget.onSearch(query);
                      setState(() {
                        _results = FirstScreen.allMovies
                            .where((movie) => movie['title']!
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: _results.isEmpty
                ? Center(
                    child: Text(
                      _controller.text.isEmpty
                          ? 'Start typing to search...'
                          : 'No movies found',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final movie = _results[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            movie['image'] ?? '',
                            width: 50,
                            height: 75,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 50,
                                height: 75,
                                color: Colors.grey[900],
                                child: const Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 75,
                                color: Colors.grey[900],
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.white54,
                                  size: 30,
                                ),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          movie['title'] ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              movie['rating'] ?? 'N/A',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                movie['genre'] ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movie: movie, userData: widget.userData),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}