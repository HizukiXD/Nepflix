import 'package:flutter/material.dart';
import 'movie_detail_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  static final List<Map<String, String>> topRatedMovies = [
    {
      'title': 'Jerry on Top',
      'rating': '9.2',
      'image':
          'https://m.media-amazon.com/images/M/MV5BODk5Mzg4YzAtMzRhZC00MWQ5LWE1OWEtYTU1NWFhYWQzNTYwXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/KZiwCrGUZNk/maxresdefault.jpg',
      'description':
          'A hilarious comedy about Jerry\'s outrageous adventures and misadventures in the world of entertainment.',
    },
    {
      'title': 'Aama',
      'rating': '9.0',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/2/25/Aama_%282020_film%29.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/RRv_IJSQweM/maxresdefault.jpg',
      'description':
          'A heartwarming drama exploring the deep bond between a mother and her son, filled with emotional moments and life lessons.',
    },
    {
      'title': 'Laaj Sharanam',
      'rating': '8.8',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNmVkYzczY2MtZGViNi00Y2Q5LWFkMTUtODNmMTkxY2ZmMGE5XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/48-rWlGPeVc/sddefault.jpg?v=6819df76',
      'description':
          'A thrilling action-packed story of courage, justice, and the fight against corruption in a small town.',
    },
    {
      'title': 'Jaari',
      'rating': '8.9',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMzI2NjZiNGMtNmY5MC00Y2JlLWFmY2QtNDU2NmM4OGNlYmFhXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/5O3K8JXch1E/maxresdefault.jpg',
      'description':
          'A spine-chilling horror film that delves into supernatural mysteries and terrifying encounters.',
    },
    {
      'title': 'Unko Sweater - The Woolen Sweater',
      'rating': '8.8',
      'image':
          'https://m.media-amazon.com/images/M/MV5BM2IzZWYyNTMtZjRkZi00YzNmLWFjZGQtNDlhNGUzMTE5YTNhXkEyXkFqcGc@._V1_.jpg',
      'detailImage':
          'https://i.ytimg.com/vi/hWZQ0kaTbXU/maxresdefault.jpg',
      'description':
          'A comedic tale of friendship, fashion mishaps, and unforgettable adventures in the world of woolen sweaters.',
    },
  ];

  static final List<Map<String, String>> popularMovies = [
    {
      'title': 'Kalo Pothi',
      'rating': '7.8',
      'image': 'https://m.media-amazon.com/images/M/MV5BNjRiNTA1NzgtYTdiYy00N2QwLWEwMDgtNzM2ZjZiYWY5YmU0XkEyXkFqcGc@._V1_.jpg',
      'detailImage': 'https://i.ytimg.com/vi/74gClGeD5D8/sddefault.jpg',
      'description': 'A dark and intense drama about crime, betrayal, and the consequences of one\'s actions in the underworld.',
    },
    {
      'title': 'Kabaddi Kabaddi 4',
      'rating': '7.8',
      'image': 'https://m.media-amazon.com/images/M/MV5BNDkzMGRjOWYtMGYyMy00ZTQ1LWI5NjQtNWJhODI2N2I4ZDAzXkEyXkFqcGc@._V1_QL75_UX151_.jpg',
      'detailImage': 'https://i.ytimg.com/vi/zOJwj88rQuE/maxresdefault.jpg',
      'description': 'An exciting sports drama following the passionate world of kabaddi and the rivalries that come with it.',
    },
    {
      'title': 'Talakjung vs Tulke',
      'rating': '8.0',
      'image': 'https://m.media-amazon.com/images/M/MV5BN2YyY2QxMTAtNmFhNy00MGFlLTgwODMtYjcyYzVlZTMwN2Y2XkEyXkFqcGc@._V1_.jpg',
      'detailImage': 'https://i.ytimg.com/vi/Zl-JXV0JTzw/hq720.jpg?sqp=-oaymwEXCK4FEIIDSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLDHOx33gLfdXLOkEDp3hTJsmHApHA',
      'description': 'A comedic battle of wits between two eccentric characters in a hilarious showdown.',
    },
    {
      'title': 'Pashupati Prasad',
      'rating': '8.6',
      'image': 'https://m.media-amazon.com/images/M/MV5BMDIxYTJlY2EtMzlmZi00MjUzLWJlNmUtNWE5NjJjYTQ0NjUwXkEyXkFqcGc@._V1_.jpg',
      'detailImage': 'https://i.ytimg.com/vi/xGOIMWh2FfE/maxresdefault.jpg',
      'description': 'A satirical comedy poking fun at politics, bureaucracy, and the absurdities of everyday life.',
    },
    {
      'title': 'Loot 2',
      'rating': '8.7',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJp9FKRYNsh8jZ6YK0i9psmBFqsywshnYMjg&s',
      'detailImage': 'https://i.ytimg.com/vi/oRjjJ5LkGPY/maxresdefault.jpg',
      'description': 'A thrilling heist film about a group of unlikely criminals planning the perfect robbery.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0f0f0f),
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Nep',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: 'flix',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.red),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Featured Movie
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://i.ytimg.com/vi/hWZQ0kaTbXU/maxresdefault.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black54,
                      Colors.black87,
                    ],
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Unko Sweater',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 Top Rated
            sectionTitle(context, "Top Rated Movies"),
            movieList(topRatedMovies),

            const SizedBox(height: 24),

            // 🔥 Popular
            sectionTitle(context, "Popular Movies"),
            movieList(popularMovies),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ✅ Section Title Widget
  Widget sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  // ✅ Movie List Widget
  Widget movieList(List<Map<String, String>> movies) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: MovieCard(
              movie: movie,
            ),
          );
        },
      ),
    );
  }
}

// ✅ Movie Card
class MovieCard extends StatelessWidget {
  final Map<String, String> movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 120,
              height: 140,
              child: Stack(
                children: [
                  Image.network(
                    movie['image'] ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, color: Colors.white),
                      );
                    },
                  ),

                  // ⭐ Rating badge
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        movie['rating'] ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 6),

          SizedBox(
            width: 120,
            child: Text(
              movie['title'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}