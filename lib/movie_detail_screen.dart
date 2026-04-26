import 'package:flutter/material.dart';
import 'first_screen.dart';
import 'video_player_screen.dart';
import 'rating_comment_system.dart';
import 'services/rating_service.dart';
import 'widgets/movie_rating_badge.dart';


class MovieDetailScreen extends StatefulWidget {
  final Map<String, String> movie;
  final Map<String, String>? userData;
  final bool isInWishlist;
  final Function(String)? onWishlistToggle;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    this.userData,
    this.isInWishlist = false,
    this.onWishlistToggle,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _isInWishlist;
  double _averageRating = 0.0;
  double _userRating = 0.0;
  bool _isRatingLoading = true;

  @override
  void initState() {
    super.initState();
    _isInWishlist = widget.isInWishlist;
    _fetchRatings();
  }

  Future<void> _fetchRatings() async {
    if (!mounted) return;
    setState(() => _isRatingLoading = true);

    try {
      final movieTitle = widget.movie['title'] ?? '';
      
      // Fetch average rating
      final avgResponse = await RatingService.getAverageRating(movieTitle);
      
      // Fetch user rating if logged in
      double userRating = 0.0;
      if (widget.userData != null && widget.userData!['token'] != null) {
        final userResponse = await RatingService.getUserRating(
          movieTitle: movieTitle,
          userId: widget.userData?['email'] ?? widget.userData?['username'] ?? '',
          token: widget.userData!['token']!,
        );
        if (userResponse['rating'] != null) {
          userRating = (userResponse['rating']['rating'] ?? 0.0).toDouble();
        }
      }

      if (mounted) {
        setState(() {
          _averageRating = (avgResponse['averageRating'] ?? 0.0).toDouble();
          _userRating = userRating;
          _isRatingLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching ratings in Detail Screen: $e');
      if (mounted) {
        setState(() => _isRatingLoading = false);
      }
    }
  }


  @override
  void didUpdateWidget(MovieDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update wishlist state if parent changes it
    if (oldWidget.isInWishlist != widget.isInWishlist) {
      _isInWishlist = widget.isInWishlist;
    }
  }

  void _toggleWishlist() {
    // Check if user is logged in - FIXED: Check if userData exists and has email/username
    if (widget.userData == null || 
        (widget.userData!['email'] == null && widget.userData!['username'] == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to add movies to wishlist'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Toggle wishlist
    setState(() {
      _isInWishlist = !_isInWishlist;
    });

    // Call parent callback if provided
    if (widget.onWishlistToggle != null) {
      widget.onWishlistToggle!(widget.movie['title']!);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInWishlist
              ? '${widget.movie['title']} added to wishlist'
              : '${widget.movie['title']} removed from wishlist',
        ),
        backgroundColor: _isInWishlist ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0f0f0f),
        elevation: 0,
        title: Text(
          widget.movie['title'] ?? 'Movie Details',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Image with gradient overlay
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: Image.network(
                        widget.movie['detailImage'] ?? widget.movie['image'] ?? '',
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
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Movie Title
              Text(
                widget.movie['title'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Rating, Year, HD Badge & Wishlist Button
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        _isRatingLoading 
                            ? '...' 
                            : _averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (!_isRatingLoading && _userRating > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.yellow.withOpacity(0.5)),
                          ),
                          child: Text(
                            'You: ${_userRating.toStringAsFixed(1)}',
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],

                    ],
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '2024',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'HD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Wishlist Button
                  GestureDetector(
                    onTap: _toggleWishlist,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _isInWishlist ? Colors.red.withOpacity(0.2) : Colors.transparent,
                        border: Border.all(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isInWishlist ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _isInWishlist ? 'Added' : 'Wishlist',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                widget.movie['description'] ?? 'No description available.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 24),

              // Watch Trailer Button
              if (widget.movie['youtubeId'] != null && widget.movie['youtubeId']!.isNotEmpty)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoId: widget.movie['youtubeId']!,
                            title: widget.movie['title'] ?? 'Trailer',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 24,
                    ),
                    label: const Text(
                      'Watch Trailer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              // Rating & Comment System
              RatingCommentSystem(
                movieTitle: widget.movie['title'] ?? '',
                userId: widget.userData?['email'] ?? widget.userData?['username'],
                userEmail: widget.userData?['email'],
                userToken: widget.userData?['token'],
                userName: widget.userData?['username'],
              ),

              const SizedBox(height: 40),

              // Similar Movies Section
              Text(
                'Similar Movies Like ${widget.movie['title']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              buildSimilarMoviesSection(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Get similar movies sorted by rating
  List<Map<String, String>> getSimilarMovies() {
    final currentGenre = widget.movie['genre'] ?? '';
    
    // Filter movies with same genre, exclude current movie, and sort by rating
    final similarMovies = FirstScreen.allMovies
        .where((m) => m['genre'] == currentGenre && m['title'] != widget.movie['title'])
        .toList();
    
    // Sort by rating in descending order (highest first)
    similarMovies.sort((a, b) {
      final ratingA = double.tryParse(a['rating'] ?? '0') ?? 0;
      final ratingB = double.tryParse(b['rating'] ?? '0') ?? 0;
      return ratingB.compareTo(ratingA);
    });
    
    return similarMovies;
  }

  // Build similar movies widget
  Widget buildSimilarMoviesSection() {
    final similarMovies = getSimilarMovies();
    
    if (similarMovies.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Center(
          child: Text(
            'No similar movies found',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: similarMovies.length,
        itemBuilder: (context, index) {
          final similarMovie = similarMovies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                      movie: similarMovie,
                      userData: widget.userData,
                      isInWishlist: false, // You might want to pass actual wishlist state
                      // onWishlistToggle: widget.onWishlistToggle, // Pass the callback if needed
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      similarMovie['image'] ?? '',
                      width: 120,
                      height: 160,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 120,
                          height: 160,
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
                  // Movie Title
                  SizedBox(
                    width: 120,
                    child: Text(
                      similarMovie['title'] ?? '',
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
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 14),
                      const SizedBox(width: 3),
                      MovieRatingBadge(
                        movieTitle: similarMovie['title'] ?? '',
                        initialRating: similarMovie['rating'],
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}