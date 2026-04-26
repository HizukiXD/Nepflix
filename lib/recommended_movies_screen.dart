import 'package:flutter/material.dart';
import 'services/rating_service.dart';
import 'movie_detail_screen.dart';
import 'widgets/movie_rating_badge.dart';

class RecommendedMoviesScreen extends StatefulWidget {
  final Map<String, String>? userData;
  final Set<String> wishlist;
  final Function(String) onWishlistToggle;

  const RecommendedMoviesScreen({
    super.key,
    this.userData,
    required this.wishlist,
    required this.onWishlistToggle,
  });

  @override
  State<RecommendedMoviesScreen> createState() => _RecommendedMoviesScreenState();
}

class _RecommendedMoviesScreenState extends State<RecommendedMoviesScreen> {
  late Future<List<Map<String, dynamic>>> _topRatedMovies;

  @override
  void initState() {
    super.initState();
    _topRatedMovies = _loadTopRatedMovies();
  }

  Future<List<Map<String, dynamic>>> _loadTopRatedMovies() async {
    try {
      final response = await RatingService.getTopRatedMovies(limit: 20);
      final movies = List<Map<String, dynamic>>.from(response['movies'] ?? []);
      return movies;
    } catch (e) {
      debugPrint('Error loading top rated movies: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _topRatedMovies = _loadTopRatedMovies();
          });
          await _topRatedMovies;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Top Rated Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Movies recommended by user ratings',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _topRatedMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(color: Colors.red),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error loading movies: ${snapshot.error}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _topRatedMovies = _loadTopRatedMovies();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.star_outline,
                                color: Colors.white54,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'No rated movies yet',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Be the first to rate movies!',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final movies = snapshot.data!;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return TopRatedMovieCard(
                          movie: movie,
                          userData: widget.userData,
                          isInWishlist:
                              widget.wishlist.contains(movie['title']),
                          onWishlistToggle: widget.onWishlistToggle,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ========== Top Rated Movie Card ==========
class TopRatedMovieCard extends StatefulWidget {
  final Map<String, dynamic> movie;
  final Map<String, String>? userData;
  final bool isInWishlist;
  final Function(String) onWishlistToggle;

  const TopRatedMovieCard({
    super.key,
    required this.movie,
    this.userData,
    required this.isInWishlist,
    required this.onWishlistToggle,
  });

  @override
  State<TopRatedMovieCard> createState() => _TopRatedMovieCardState();
}

class _TopRatedMovieCardState extends State<TopRatedMovieCard> {
  late bool _isInWishlist;

  @override
  void initState() {
    super.initState();
    _isInWishlist = widget.isInWishlist;
  }

  @override
  void didUpdateWidget(TopRatedMovieCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isInWishlist != widget.isInWishlist) {
      _isInWishlist = widget.isInWishlist;
    }
  }

  void _toggleWishlist() {
    setState(() {
      _isInWishlist = !_isInWishlist;
    });
    widget.onWishlistToggle(widget.movie['title'] ?? '');
  }

  // Helper method to safely get genre
  String _getGenre() {
    final genre = widget.movie['genre'];
    if (genre == null) return 'Drama';
    if (genre is String) return genre;
    if (genre is List) return (genre).join(', ');
    return genre.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Convert to the format expected by MovieDetailScreen
        final movieData = <String, String>{
          'title': widget.movie['title'] ?? 'Unknown',
          'rating': widget.movie['averageRating']?.toString() ?? '0',
          'genre': _getGenre(),
          'image': widget.movie['image'] ?? '',
          'detailImage': widget.movie['detailImage'] ?? '',
          'description': widget.movie['description'] ?? 'No description',
          'youtubeId': widget.movie['youtubeId'] ?? '',
        };
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              movie: movieData,
              userData: widget.userData,
              isInWishlist: _isInWishlist,
              onWishlistToggle: (movieTitle) => _toggleWishlist(),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Image with Overlay
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.network(
                    widget.movie['image'] ?? '',
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

                  // Rating Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 14),
                          const SizedBox(width: 4),
                          MovieRatingBadge(
                            movieTitle: widget.movie['title'] ?? '',
                            initialRating: (widget.movie['averageRating'] ?? 0).toString(),
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Wishlist Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: _toggleWishlist,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Movie Title
          Text(
            widget.movie['title'] ?? 'Unknown',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 4),

          // Rating & Count
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 12),
              const SizedBox(width: 2),
              MovieRatingBadge(
                movieTitle: widget.movie['title'] ?? '',
                initialRating: (widget.movie['averageRating'] ?? 0).toString(),
                fontSize: 11,
              ),
              const SizedBox(width: 4),
              Text(
                '(${widget.movie['totalRatings'] ?? 0})',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}