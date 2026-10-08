<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The GetGoogleData service

Service id: **`googlereviews.get_google_data`** — class `GetGoogleData`
(`GetGoogleDataInterface`). Both block plugins use it; call it from custom code too.

## Methods

```php
$svc = \Drupal::service('googlereviews.get_google_data');

// Fetch reviews / rating for a place.
$data = $svc->getGoogleReviews(
  array $fields = [],            // field list (mapped to legacy 'fields' or v1 X-Goog-FieldMask)
  int $max_reviews = 5,          // cap on returned reviews
  string $reviews_sort = 'newest', // 'newest' | 'most_relevant' (legacy only)
  string $language = '',         // '' = current interface language
  ?string $google_place_id = '', // '' = fall back to config google_place_id
  ?int $minimum_rating = NULL,   // hide reviews below this rating
  string $filtered_words = ''    // comma-separated words to exclude by text/author
);

$svc->getCacheMaxAge();            // int, from config cache_max_age
$svc->getGooglePlacesApiVersion(); // int, config google_places_api (0 legacy / 1 v1)
```

## Behavior

- Reads `google_auth_key`, `google_api_url`, and `google_place_id` from
  `googlereviews.settings`; if auth key or place id is empty it sets an admin error message
  and returns `[]`.
- Branches on the API version (see configure/settings.md for legacy vs v1 request shape) and
  normalizes both into an array with `place_id`, `rating`, `user_ratings_total`, `url`, and a
  `reviews` list of `author_name`, `author_url`, `profile_photo_url`, `rating`,
  `relative_time_description`, `text`.
- `filterReviews()` applies `minimum_rating` and `filtered_words` (case-insensitive substring
  match on review text or reviewer name).
- Guzzle/`RequestException` and API-error responses are logged to the `googlereviews` channel
  and surfaced as a generic admin messenger error; the method returns whatever it has (often `[]`).

The request host comes from the admin-set `google_api_url` (fixed Google default); it is not
derived from end-user input.
