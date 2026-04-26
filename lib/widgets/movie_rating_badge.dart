import 'package:flutter/material.dart';
import '../services/rating_service.dart';

class MovieRatingBadge extends StatefulWidget {
  final String movieTitle;
  final String? initialRating;
  final double fontSize;

  const MovieRatingBadge({
    super.key,
    required this.movieTitle,
    this.initialRating,
    this.fontSize = 11,
  });

  @override
  State<MovieRatingBadge> createState() => _MovieRatingBadgeState();
}

class _MovieRatingBadgeState extends State<MovieRatingBadge> {
  double? _rating;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRating();
  }

  @override
  void didUpdateWidget(MovieRatingBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movieTitle != widget.movieTitle) {
      _fetchRating();
    }
  }

  Future<void> _fetchRating() async {
    try {
      final response = await RatingService.getAverageRating(widget.movieTitle);
      if (mounted) {
        setState(() {
          _rating = (response['averageRating'] ?? 0.0).toDouble();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching rating for ${widget.movieTitle}: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Text(
        '...',
        style: TextStyle(
          color: Colors.yellow, 
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    
    final displayRating = _rating != null
        ? _rating!.toStringAsFixed(1)
        : (widget.initialRating ?? '0.0');

    return Text(
      displayRating,
      style: TextStyle(
        color: Colors.yellow,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
