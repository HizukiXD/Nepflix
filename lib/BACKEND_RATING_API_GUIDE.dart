// BACKEND IMPLEMENTATION GUIDE FOR RATING SYSTEM
// This file explains what endpoints and models need to be created on the backend

/*
========== MONGODB SCHEMA FOR RATINGS ==========

// Rating Schema
{
  "_id": ObjectId,
  "movieTitle": String (required, indexed),
  "userId": String (required),
  "userName": String,
  "email": String,
  "rating": Number (1-5, required),
  "comment": String,
  "createdAt": Date (auto),
  "updatedAt": Date (auto)
}

========== REQUIRED API ENDPOINTS ==========

1. ADD/CREATE RATING & COMMENT
   POST /api/ratings
   Body: {
     "movieTitle": "Movie Title",
     "userId": "user_email_or_id",
     "rating": 4.5,
     "comment": "Great movie!"
   }
   Response: { "success": true, "ratingId": "..." }

2. GET ALL RATINGS FOR A MOVIE
   GET /api/ratings?movieTitle=MovieTitle
   Response: {
     "ratings": [
       {
         "_id": "...",
         "movieTitle": "...",
         "userName": "...",
         "rating": 4.5,
         "comment": "...",
         "createdAt": "..."
       }
     ]
   }

3. GET USER'S RATING FOR A MOVIE
   GET /api/ratings/user?movieTitle=MovieTitle&userId=user_email
   Response: {
     "rating": {
       "_id": "...",
       "rating": 4.5,
       "comment": "...",
       "createdAt": "..."
     }
   }

4. UPDATE RATING & COMMENT
   PUT /api/ratings/update
   Body: {
     "movieTitle": "...",
     "userId": "...",
     "rating": 5,
     "comment": "Updated comment"
   }
   Response: { "success": true, "updatedRating": {...} }

5. DELETE RATING
   DELETE /api/ratings/delete
   Body: {
     "movieTitle": "...",
     "userId": "..."
   }
   Response: { "success": true, "message": "Rating deleted" }

6. GET TOP RATED MOVIES
   GET /api/ratings/top-rated?limit=10
   Response: {
     "movies": [
       {
         "movieTitle": "...",
         "averageRating": 4.5,
         "totalRatings": 10,
         "image": "...",
         "genre": [...],
         "description": "..."
       }
     ]
   }

7. GET AVERAGE RATING FOR MOVIE
   GET /api/ratings/average?movieTitle=MovieTitle
   Response: {
     "movieTitle": "...",
     "averageRating": 4.5,
     "totalRatings": 10
   }

========== MIDDLEWARE & VALIDATION ==========

Required Validations:
- Rating must be between 1 and 5
- MovieTitle must not be empty
- UserId must not be empty
- Comment should be limited to 500 characters
- Authentication required for adding/updating/deleting ratings

Authentication Headers:
- Bearer token for user verification (optional but recommended)

========== AGGREGATION QUERY FOR TOP RATED ==========

MongoDB Aggregation Pipeline Example:

db.ratings.aggregate([
  {
    $group: {
      _id: "$movieTitle",
      averageRating: { $avg: "$rating" },
      totalRatings: { $sum: 1 },
      // If storing movie data in ratings collection:
      genre: { $first: "$genre" },
      image: { $first: "$image" },
      description: { $first: "$description" }
    }
  },
  { $sort: { averageRating: -1 } },
  { $limit: 10 }
])

If using separate collections, join with:
{
  $lookup: {
    from: "movies",
    localField: "_id",
    foreignField: "title",
    as: "movieData"
  }
}

========== RESPONSE EXAMPLES ==========

Adding Rating Response:
{
  "success": true,
  "rating": {
    "_id": "507f1f77bcf86cd799439011",
    "movieTitle": "Aama",
    "userId": "user@example.com",
    "userName": "John Doe",
    "rating": 4.5,
    "comment": "Amazing movie!",
    "createdAt": "2024-04-18T10:30:00Z"
  }
}

Get Ratings Response:
{
  "ratings": [
    {
      "_id": "507f1f77bcf86cd799439011",
      "movieTitle": "Aama",
      "userName": "John Doe",
      "rating": 4.5,
      "comment": "Amazing movie!",
      "createdAt": "2024-04-18T10:30:00Z"
    },
    {
      "_id": "507f1f77bcf86cd799439012",
      "movieTitle": "Aama",
      "userName": "Jane Smith",
      "rating": 4.0,
      "comment": "Very good drama",
      "createdAt": "2024-04-17T15:20:00Z"
    }
  ]
}

Top Rated Movies Response:
{
  "movies": [
    {
      "movieTitle": "Aama",
      "averageRating": 4.5,
      "totalRatings": 15,
      "image": "https://...",
      "genre": ["Drama"],
      "description": "Emotional mother-son story."
    },
    {
      "movieTitle": "Prem Geet",
      "averageRating": 4.3,
      "totalRatings": 12,
      "image": "https://...",
      "genre": ["Romance"],
      "description": "A beautiful romantic story."
    }
  ]
}
*/

// NOTE: The frontend is ready and waiting for these endpoints.
// Once backend APIs are implemented, ratings will work seamlessly.
