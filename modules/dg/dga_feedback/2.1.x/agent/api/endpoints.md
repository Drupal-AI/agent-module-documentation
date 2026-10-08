<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submit/stats endpoints & the feedback service API

## JSON endpoints — `DgaFeedbackController` (`src/Controller/DgaFeedbackController.php`)

### `POST /dga-feedback/submit` → `submitFeedback()`
Route requirements: `_access: TRUE` + `_permission: access content`, `methods: [POST]`,
`_format: json`. Accepts a JSON body.

Processing order:
1. Resolve language (path prefix `/ar|/en`, then `?lang=`, then Accept-Language for anon)
   to pick EN/AR message strings.
2. Reject non-POST (405) and reject requests without `X-Requested-With: XMLHttpRequest`
   (400) — this header requirement blocks classic cross-site form posts.
3. Parse JSON (`json_decode`); require `is_useful` ∈ {`yes`,`no`}.
4. Normalize `url` (strip `/xx` lang prefix, trim trailing slash). `entity_id` is only
   honored for authenticated users.
5. Require a non-empty `reasons` array; each reason is `Xss::filter()`ed, length-capped by
   `reason_max_length`, and the array is capped at `reason_max_count`.
6. Require non-empty `feedback`; `Xss::filter()`ed and truncated to `feedback_max_length`.
7. `gender`, if present, must be `male|female|prefer_not_to_say`.
8. Rate limit (if `rate_limit_max_submissions > 0`): count rows in the last
   `rate_limit_time_window` seconds keyed by `ip_address` (anon) or `user_id` (auth);
   429 when at/over the limit.
9. Save via `DgaFeedbackService::saveFeedback()`; on failure for anonymous users a direct
   `$database->insert('dga_feedback')` fallback is attempted.
10. Return `{ success, message, feedback_id, statistics:{yes_percentage,total_count}, ... }`
    with no-cache headers. Operational logging records id/user/useful/url only — never the
    feedback text, reasons, or demographics (PII stays in the table).

### `GET /dga-feedback/stats` → `getStats()`
`_permission: access content`. Query params `url`, `entity_type`, `entity_id`; returns
`{ success, statistics }` from `getStatistics`/`getStatisticsByEntity`/`getStatisticsByUrl`.

### `GET /dga-feedback/refresh-block` → `refreshBlock()`
`_access: TRUE` + `_permission: access content`. Returns `{ success, statistics, ... }`
for the current/normalized URL or entity; used by the widget to refresh live counts.

## Service API — `dga_feedback.service` (`src/Service/DgaFeedbackService.php`)

Constructor args: `@database`, `@config.factory`, `@cache_tags.invalidator`,
`@logger.factory`. All writes invalidate cache tag `dga_feedback:submissions`.

- `saveFeedback(array $data): int|false` — normalizes URL, re-sanitizes reasons/feedback
  with `Xss::filter()`, validates `is_useful`, inserts a row (`created = time()`).
- `getStatistics($entity_type=NULL, $entity_id=NULL, $url=NULL): array` — returns
  `yes_count`, `no_count`, `total_count`, `yes_percentage` (rounded). Matches by entity OR
  URL with language-prefix-tolerant URL variants. `getStatisticsByUrl`, `getStatisticsByEntity`,
  `getOverallStatistics` are thin wrappers.
- `getAllSubmissions($limit, $offset, $filters, $sort_by, $sort_direction): array` — filtered,
  sorted, paginated list; `sort_by` is whitelisted, direction forced ASC/DESC, text filters
  use `escapeLike`. Decodes the `reasons` JSON column to an array.
- `getSubmissionsCount($filters): int`, `getSubmissionById($id): array|false`.
- `deleteSubmission($id): bool`, `bulkDeleteSubmissions(array $ids): int` (int-casts/filters
  ids, `IN` delete), `updateSubmission($id, $data): bool` (re-sanitizes fields).
- `purgeExpiredSubmissions(int $days): int` — deletes rows older than `days` (cron retention).
- Dashboard aggregates: `getUsefulnessDistribution`, `getStatisticsGroupedByUrl`,
  `getUniqueUrlCount`, `getMostUsefulPage`, `getMostFeedbackPage`, `getRecentActivity`
  (7/30-day conditional aggregation), `getUsefulPercentage`, `getSubmissionsByUserType`.

All queries use the DB query builder with placeholders/`escapeLike` — no string-concatenated
SQL. Free-text input (`feedback`, `reasons`) is `Xss::filter()`ed on every write path.
