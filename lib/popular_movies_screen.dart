import 'package:flutter/material.dart';
import 'movie_detail_screen.dart';

class PopularMoviesScreen extends StatefulWidget {
  final Map<String, String>? userData;
  final Set<String> wishlist;
  final Function(String) onWishlistToggle;

  const PopularMoviesScreen({
    super.key,
    this.userData,
    required this.wishlist,
    required this.onWishlistToggle,
  });

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  // Static movie data - same as in first_screen.dart
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
    },
    {
      'title': 'Nai Nabhannu La 2',
      'rating': '7.9',
      'genre': 'Drama',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZjdhN2FlZmMtNTFmZC00N2Q3LTlkMzEtZWFmYzEwYmI5YTRmXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://m.media-amazon.com/images/M/MV5BMjliN2U3NDItYzVlOC00NDc4LTg5MmItNzkzZjQzNWNjYWVhXkEyXkFqcGc@._V1_QL75_UX337_.jpg',
      'description': 'A Drama about love and misunderstandings.',
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
    },
  ];

  // Get popular movies - top 12 by rating
  List<Map<String, String>> get popularMovies {
    final sortedMovies = List<Map<String, String>>.from(allMovies);
    sortedMovies.sort((a, b) {
      final ratingA = double.tryParse(a['rating'] ?? '0') ?? 0;
      final ratingB = double.tryParse(b['rating'] ?? '0') ?? 0;
      return ratingB.compareTo(ratingA);
    });
    return sortedMovies.take(12).toList();
  }

  @override
  Widget build(BuildContext context) {
    final movies = popularMovies;

    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0f0f0f),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Popular Movies',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GridView.builder(
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
            userData: widget.userData,
            isInWishlist: widget.wishlist.contains(movie['title']),
            onWishlistToggle: widget.onWishlistToggle,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    movie: movie,
                    userData: widget.userData,
                    isInWishlist: widget.wishlist.contains(movie['title']),
                    onWishlistToggle: widget.onWishlistToggle,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Movie Card Widget
class MovieCard extends StatelessWidget {
  final Map<String, String> movie;
  final VoidCallback? onTap;
  final Map<String, String>? userData;
  final bool isInWishlist;
  final Function(String) onWishlistToggle;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.userData,
    required this.isInWishlist,
    required this.onWishlistToggle,
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
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (userData != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => onWishlistToggle(movie['title']!),
                        child: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
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