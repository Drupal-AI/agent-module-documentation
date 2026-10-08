<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX endpoints & DgaRatingService

Source: `src/Controller/DgaRatingController.php`, `src/Service/DgaRatingService.php`,
`dga_rating.routing.yml`, `dga_rating.services.yml`.

## Routes (front-end JSON)

| Route | Path | Method | Requirements | Controller method |
|---|---|---|---|---|
| `dga_rating.submit` | `/dga-rating/submit` | POST | `_access: TRUE`, `_permission: access content` | `DgaRatingController::submitRating` |
| `dga_rating.stats` | `/dga-rating/stats` | GET | `_access: TRUE` | `DgaRatingController::getStats` |
| `dga_rating.refresh_block` | `/dga-rating/refresh-block` | GET | `_access: TRUE`, `_permission: access content` | `DgaRatingController::refreshBlock` |

All return `application/json` (`_format: json`).

## submitRating(Request)

Accepts a JSON body read via `json_decode($request->getContent())`. Flow:

1. Handles an `OPTIONS` preflight (returns CORS allow headers) and rejects any non-POST with 405.
2. Reads `dga_rating.settings` and picks EN/AR error text by current interface language.
3. Validates: JSON present (400), `rating` numeric and cast to int in **1-5** (400), `feedback`
   non-empty after `trim()` (400, "Feedback is required").
4. Normalizes `url` (strips a `/xx` language prefix, trims trailing slash, defaults `/`).
5. `feedback` is sanitized with `\Drupal\Component\Utility\Xss::filter()` and rejected if longer
   than `feedback_max_length` (default 5000).
6. **Anonymous rate limiting:** if the user is anonymous and `rate_limit_max_submissions > 0`,
   counts rows in `{dga_rating}` for the request IP within the last `rate_limit_time_window`
   seconds (defaults 20 / 3600) and returns 429 when the cap is reached.
7. Builds the save array: `entity_id` is taken from the payload **only for authenticated users and
   only when > 0** (anonymous always store `entity_id = 0`); `user_id` is NULL for anon; stores the
   request IP. Calls `DgaRatingService::saveRating()`.
8. On a failed save for anonymous users, retries once with a direct
   `$database->insert('dga_rating')` fallback, then 500s if still failing.
9. Optionally re-reads the just-inserted row (up to 3 tries with a 0.1s sleep — tolerant of
   replication lag), recomputes stats for the node/URL, and returns
   `{success, message (thank-you, localized), rating, rating_id, statistics:{average,count},
   average, count}`.

Note: the submit route is a stateless anonymous AJAX endpoint (no per-request CSRF token; abuse is
bounded by per-IP rate limiting for anonymous users). `hook_page_attachments()` publishes
`drupalSettings.csrfToken` for client-side use by other consumers.

## getStats(Request) / refreshBlock(Request)

Read-only. Query params `url`, `entity_type`, `entity_id`. `getStats` returns
`{success, statistics}`; `refreshBlock` normalizes the URL the same way as submit and returns
`{success, statistics, average, count}`. Both delegate to the service's `getStatistics*` methods.

## DgaRatingService (`dga_rating.service`)

Constructor args: `@database`, `@config.factory`, `@cache_tags.invalidator`, `@logger.factory`.
All queries use the DB query builder (parameterized conditions; `escapeLike()` for LIKE filters).
On write/delete/update it invalidates the cache tag `dga_rating:submissions`.

Write / mutate:
- `saveRating(array $data): int|false` — re-normalizes URL, re-`Xss::filter()`s + truncates feedback,
  validates rating 1-5 and non-empty URL, inserts (with `created = time()`), returns insert id.
- `updateSubmission($id, array $data): bool` — updates rating (1-5) and/or `Xss::filter()`ed feedback.
- `deleteSubmission($id): bool` — deletes one row by int id.
- `bulkDeleteSubmissions(array $ids): int` — casts ids to positive ints, deletes with `IN`.

Read / statistics (all return arrays):
- `getStatistics($entity_type, $entity_id, $url)` — average+count; matches by entity AND/OR
  normalized URL (with EN/AR prefix and trailing-slash variants) to unify anon and auth ratings.
- `getStatisticsByUrl($url)`, `getStatisticsByEntity($type, $id)`, `getOverallStatistics()`.
- `getAllSubmissions($limit, $offset, $filters, $sort_by, $sort_direction)` — sort field/direction
  are validated against allowlists (`id, rating, created, url, user_id`; ASC/DESC).
- `getSubmissionsCount($filters)`, `getSubmissionById($id)`.
- `getRatingDistribution()` (counts per 1-5), `getUniqueUrlCount()`,
  `getStatisticsGroupedByUrl($limit, $order_by, $order_direction)` (order field allowlisted;
  distributions fetched in one batched query), `getTopRatedPage()`, `getMostReviewedPage()`,
  `getRecentActivity()` (7/30-day counts+avgs via conditional aggregation),
  `getPositiveRatingsPercentage()` (4-5 stars), `getSubmissionsByUserType()` (anon vs auth).
