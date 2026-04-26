import 'package:flutter/material.dart';
import 'services/rating_service.dart';

// ========== Rating & Comment System Main Widget ==========
class RatingCommentSystem extends StatefulWidget {
  final String movieTitle;
  final String? userId;
  final String? userEmail;
  final String? userToken;
  final String? userName;

  const RatingCommentSystem({
    super.key,
    required this.movieTitle,
    this.userId,
    this.userEmail,
    this.userToken,
    this.userName,
  });

  @override
  State<RatingCommentSystem> createState() => _RatingCommentSystemState();
}

class _RatingCommentSystemState extends State<RatingCommentSystem> {
  double _userRating = 0;
  String _userComment = '';
  bool _isLoading = false;
  List<Map<String, dynamic>> _ratings = [];
  bool _commentsLoading = false;
  double _averageRating = 0;
  int _totalRatings = 0;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _loadMovieRatings();
    _loadAverageRating();
    if (widget.userId != null && widget.userToken != null) {
      _loadUserRating();
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _loadMovieRatings() async {
    if (!mounted) return;
    setState(() => _commentsLoading = true);
    try {
      final response = await RatingService.getMovieRatings(widget.movieTitle);
      if (mounted) {
        setState(() {
          _ratings = List<Map<String, dynamic>>.from(response['ratings'] ?? []);
        });
      }
    } catch (e) {
      debugPrint('Error loading ratings: $e');
    } finally {
      if (mounted) {
        setState(() => _commentsLoading = false);
      }
    }
  }

  void _loadAverageRating() async {
    try {
      final response = await RatingService.getAverageRating(widget.movieTitle);
      if (mounted) {
        setState(() {
          _averageRating = (response['averageRating'] ?? 0.0).toDouble();
          _totalRatings = response['totalRatings'] ?? 0;
        });
      }
    } catch (e) {
      debugPrint('Error loading average rating: $e');
    }
  }

  void _loadUserRating() async {
    final token = widget.userToken;
    if (token == null) return;
    try {
      final response = await RatingService.getUserRating(
        movieTitle: widget.movieTitle,
        userId: widget.userId!,
        token: token,
      );
      if (response['rating'] != null && mounted) {
        setState(() {
          _userRating = (response['rating']['rating'] ?? 0).toDouble();
          _userComment = response['rating']['comment'] ?? '';
          _commentController.text = _userComment;
        });
      }
    } catch (e) {
      debugPrint('Error loading user rating: $e');
    }
  }

  void _submitRating() async {
    if (widget.userId == null || widget.userToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to rate this movie'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_userRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await RatingService.addRatingAndComment(
        movieTitle: widget.movieTitle,
        userId: widget.userId!,
        rating: _userRating,
        comment: _userComment,
        token: widget.userToken!,
      );

      if (response['success'] ?? false) {
        _loadMovieRatings();
        _loadAverageRating();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rating submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _deleteRating() async {
    if (widget.userId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text(
          'Delete Rating',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete your rating?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      setState(() => _isLoading = true);
      try {
        await RatingService.deleteRating(
          movieTitle: widget.movieTitle,
          userId: widget.userId!,
          token: widget.userToken ?? '',
        );
        
        _loadMovieRatings();
        _loadAverageRating();
        
        if (mounted) {
          setState(() {
            _userRating = 0;
            _userComment = '';
            _commentController.clear();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rating deleted successfully'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Average Rating Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2a2a2a),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Movie Rating',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        _averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_totalRatings rating${_totalRatings != 1 ? 's' : ''}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              RatingStarsViewer(rating: _averageRating),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // User Rating Section
        if (widget.userId != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Your Rating',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (widget.userName != null && widget.userName!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.red,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.userName!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Rating Stars
              RatingStarsInput(
                rating: _userRating,
                onRatingChanged: (rating) => setState(() => _userRating = rating),
              ),
              const SizedBox(height: 16),
              // Comment Input
              TextField(
                onChanged: (value) => _userComment = value,
                controller: _commentController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: (widget.userName != null && widget.userName!.isNotEmpty)
                      ? 'Share your thoughts as ${widget.userName}...'
                      : 'Share your thoughts about this movie...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF2a2a2a),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Submit & Delete Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitRating,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: Colors.red.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Submit Rating',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (_userRating > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _deleteRating,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'Login to rate this movie',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),

        // Comments Section
        const Text(
          'User Reviews',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (_commentsLoading)
          const Center(
            child: CircularProgressIndicator(color: Colors.red),
          )
        else if (_ratings.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'No reviews yet. Be the first to review!',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _ratings.length,
            itemBuilder: (context, index) {
              final rating = _ratings[index];
              return CommentCard(rating: rating);
            },
          ),
      ],
    );
  }
}

// ========== Rating Stars Input Widget ==========
class RatingStarsInput extends StatelessWidget {
  final double rating;
  final Function(double) onRatingChanged;

  const RatingStarsInput({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...List.generate(5, (index) {
          return GestureDetector(
            onTap: () => onRatingChanged((index + 1).toDouble()),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.star,
                color: index < rating ? Colors.yellow : Colors.white24,
                size: 32,
              ),
            ),
          );
        }),
        const SizedBox(width: 12),
        Text(
          rating > 0 ? '${rating.toStringAsFixed(1)}/5.0' : 'Select rating',
          style: TextStyle(
            color: rating > 0 ? Colors.yellow : Colors.white54,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ========== Rating Stars Viewer Widget ==========
class RatingStarsViewer extends StatelessWidget {
  final double rating;

  const RatingStarsViewer({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  index < rating.floor()
                      ? Icons.star
                      : index < rating
                          ? Icons.star_half
                          : Icons.star_outline,
                  color: Colors.yellow,
                  size: 20,
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ========== Comment Card Widget ==========
class CommentCard extends StatelessWidget {
  final Map<String, dynamic> rating;

  const CommentCard({super.key, required this.rating});

  String _getDisplayName() {
    // Check for userName in the rating object
    if (rating['userName'] != null && rating['userName'].toString().isNotEmpty) {
      return rating['userName'].toString();
    }
    
    // Check for username
    if (rating['username'] != null && rating['username'].toString().isNotEmpty) {
      return rating['username'].toString();
    }
    
    // Check for userEmail and extract name from email
    if (rating['userEmail'] != null && rating['userEmail'].toString().isNotEmpty) {
      final email = rating['userEmail'].toString();
      final usernameFromEmail = email.split('@').first;
      if (usernameFromEmail.isNotEmpty) {
        return usernameFromEmail;
      }
      return email;
    }
    
    // Check for userId as last resort
    if (rating['userId'] != null && rating['userId'].toString().isNotEmpty) {
      final userId = rating['userId'].toString();
      if (userId.length > 8) {
        return 'User_${userId.substring(0, 8)}';
      }
      return 'User_$userId';
    }
    
    return 'Anonymous';
  }

  @override
  Widget build(BuildContext context) {
    final rawRating = (rating['rating'] ?? 0).toDouble();
    final displayRating = (rawRating / 2.0).clamp(0.0, 5.0);
    final displayText = displayRating.toStringAsFixed(1);

    String dateText = 'Just now';
    final createdAt = rating['createdAt'];
    if (createdAt != null && createdAt.toString().length >= 10) {
      dateText = createdAt.toString().substring(0, 10);
    }

    final displayName = _getDisplayName();
    
    // Debug: print rating data to console to see what fields are available
    debugPrint('Review Data: $rating');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Name and Icon at the top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.redAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                dateText,
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
          
          const SizedBox(height: 8),

          // 2. Star Rating
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < displayRating.round()
                      ? Icons.star
                      : Icons.star_outline,
                  color: Colors.yellow,
                  size: 14,
                );
              }),
              const SizedBox(width: 8),
              Text(
                '$displayText / 5.0',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          
          // 3. Comment Text
          if ((rating['comment'] ?? '').toString().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              rating['comment'].toString(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}