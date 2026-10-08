# API — ReviewService, fetch flow, cron & the `review` content type

Service **`google_reviews.reviews_service`** → `Drupal\google_reviews\ReviewService`
(constructor arg `@config.factory`). Endpoint constant
`ReviewService::API_URL = "https://maps.googleapis.com/maps/api/place/details/json"`.

Call it directly to import reviews:

```php
$added = \Drupal::service('google_reviews.reviews_service')->getReviews();
// int: number of new 'review' nodes created.
```

## Public methods

### `getReviews(): int`
Reads `google_reviews.api_key` and `google_reviews.place_id` from
`google_reviews.settings`. Splits `place_id` on `", "` (`array_filter(explode(', ', …))`);
returns `0` if there is no place id or no key. For each place it calls `importReview()`,
then for each review in the response creates a node **only if not already imported**
(`isCreated()`), incrementing and returning the created count.

### `importReview($client, $place_id, $api_key): ?array`
`GET`s the Places Details endpoint with query
`fields=reviews,rating,user_ratings_total`, `place_id`, `key`, using
`\Drupal::httpClient()`. On HTTP 200 it JSON-decodes the body, writes
`google_reviews.rating` and `google_reviews.user_ratings_total` back into
`google_reviews.settings`, and returns the decoded result. Guzzle `RuntimeException`s are
caught and logged to the `google_review_module` logger channel; a non-200 returns `NULL`.

### Private helpers
- `isCreated($review)` — dedupe: loads `review` nodes by `title` = `"<author_name> : <rating>"`; a match means "already imported".
- `createReview($review)` — creates the node (see field map below) with `status => FALSE` (unpublished).
- `getTitleOf($review)` — `author_name . " : " . rating`.
- `getTimeInYears($review)` — parses `relative_time_description` ("a year ago" / "N years ago") into an integer year count for `field_review_time`.

## How a fetch is triggered (three ways)

1. **Cron** — `google_reviews_cron()` (`google_reviews.module`) resolves
   `ReviewController` and calls `fetchReviews()`.
2. **Route** — `google_reviews.add_reviews` (`/reviews`, controller
   `\Drupal\google_reviews\Controller\ReviewController::fetchReviews`, permission
   `google_reviews admin`) returns a render array with "N reviews added. Please validate
   in the content."
3. **Settings form** — saving `ReviewSettingsForm` redirects to `/reviews` (see
   `../configure/settings.md`).

`ReviewController::fetchReviews()` just delegates to
`ReviewService::getReviews()` (the controller is injected with the service via
`create()`).

## "Caching" model

There is no Drupal cache-API layer here. Fetched reviews are **persisted as `review`
nodes**; the aggregate rating/total are stored in the `google_reviews.settings` config.
The block reads from those nodes/config, so data survives between fetches. Because
`isCreated()` matches on the `author_name : rating` title, a later fetch will **not**
update a review whose author + star count are unchanged.

## `review` content type (config/optional)

Node type `review` ("Review", description "Google review content element"), created
unpublished by the import. Fields mapped from the Google Places review object:

| Node field | Storage type | Google API field |
|---|---|---|
| `title` | node title | `author_name . " : " . rating` |
| `field_review_name` | `string` | `author_name` |
| `field_review_photo_url` | `string_long` | `profile_photo_url` |
| `field_review_language` | `string` | `language` |
| `field_review_rating` | `list_integer` | `rating` |
| `field_review_time_description` | `string` | `relative_time_description` |
| `field_review_time` | `integer` | derived years from `relative_time_description` |
| `field_review_message` | `string_long` | `text` |

## Other implemented hooks

- `hook_theme()` — registers `reviews_theme` (see `../blocks/reviews-block.md`).
- `hook_cron()` — auto-imports on every cron run (no interval throttle).
