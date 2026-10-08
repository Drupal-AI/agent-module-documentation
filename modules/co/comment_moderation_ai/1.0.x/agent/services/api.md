<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, hooks & data model

## Services (`comment_moderation_ai.services.yml`)

### `comment_moderation_ai.openai_client` — `Service\OpenAIClient`
Args: `@config.factory`, `@http_client`, `@logger.factory`, `@?key.repository`.
- `moderateContent($content)`: resolves the API key (Key entity via `api_key_id`, else legacy
  `api_key` config), POSTs `{input, model}` to `api_endpoint` with `Authorization: Bearer <key>`,
  `timeout: 30`. Returns decoded JSON, or `NULL` on missing config / `RequestException`. TLS
  verification is Guzzle default (on). Only key *length* is logged, never the value.
- `checkContent($content)`: calls `moderateContent`, then for each returned
  `category_scores[category]` that is enabled in config and ≥ `moderation_threshold`, marks
  `flagged` and collects the category. Returns
  `['flagged'=>bool, 'categories'=>[], 'category_scores'=>[], 'raw_result'=>...]`. **Fails open** —
  on API failure returns `flagged => FALSE`.
- `testConnection()` / `getConnectionStatus()`: diagnostics used by `hook_requirements`.

### `comment_moderation_ai.comment_moderator` — `Service\CommentModerator`
Args: `@config.factory`, `@comment_moderation_ai.openai_client`, `@entity_type.manager`,
`@logger.factory`.
- `moderateComment(CommentInterface)`: main entry. Returns early if `enabled` is FALSE, if the
  owner has `bypass comment moderation`, or if there's no content. Extracts subject +
  `strip_tags(comment_body)`, runs `OpenAIClient::checkContent()` then `checkCustomPolicies()`; on
  flag calls `handleFlaggedComment()`.
- `handleFlaggedComment()` → `determineFlaggedStatus()` (top score → `auto_flagged_high` ≥0.9 /
  `auto_flagged_medium` ≥0.7 / `pending_review` ≥0.5 / `flagged_low_risk`), `storeFlaggedComment()`
  (INSERT into `openai_flagged_comments`), then `handleCommentByStatus()` — high-risk always
  `setUnpublished()->save()`; medium only if `auto_unpublish`.
- `checkCustomPolicies()` + per-policy helpers (`checkKeywordFiltering`, `checkLengthRestrictions`,
  `checkRateLimiting`, `checkCompetitorDetection`, `checkMarketingDetection`, `checkPiiDetection`).
- `getFlaggedComments()`, `getFlaggedComment()`, `updateFlaggedCommentStatus($cid,$status,$modId)`.
- `flagCommentPostModeration($comment,$reason,$reporterId,$data)`: programmatic post-publication
  flag; gated by `post_moderation.enabled`. **Not wired to any route/UI** in this release.
- Static label maps: `getAvailableStatuses()`, `getStatusActions()`, `getStatusOptions()`,
  `getFlagSourceOptions()`.
- Bug: references `$this->logger` (never set) on the `auto_flagged_high` branch; also uses a stale
  `openai_comment_moderation` logger channel. Errors are swallowed by the hooks' try/catch.

### `comment_moderation_ai.flagged_comment_storage` — `Service\FlaggedCommentStorage`
Args: `@database`, `@entity_type.manager`. Read/aggregate layer used by controllers/cron:
`getFlaggedComment`, `getFlaggedComments(filters,limit,offset)`, `getFlaggedCommentsCount`,
`getStatistics()` (totals per status + top categories, table-exists guarded),
`cleanupOldRecords($days)` (deletes `approved`/`rejected` rows older than N days).

## Hooks (`comment_moderation_ai.module`)

- `hook_comment_presave`: moderate when the comment `isNew()` or `comment_body` changed; stores the
  result on `$comment->openai_moderation_result` (wrapped in try/catch).
- `hook_comment_insert`: logs; if no presave result exists, re-runs `moderateComment()` and
  unpublishes on flag when `auto_unpublish`.
- `hook_comment_update`: when a comment transitions unpublished→published and wasn't previously
  flagged, re-moderates and (if `auto_unpublish`) re-unpublishes.
- `hook_form_comment_form_alter` + `comment_moderation_ai_comment_form_validate`: when `enabled`,
  adds a warning notice and a `#validate` that calls `OpenAIClient::checkContent()` and blocks
  submission with a form error if flagged. **This means a submission can trigger up to two
  Moderation API calls** (validate + presave).
- `hook_cron`: if `cleanup_enabled` (not exposed in any form — config-only), delete records older
  than `cleanup_days` (default 90).
- `hook_views_pre_view`: for view `comment` display `page_unapproved`, injects `moderation_status`
  / `moderation_priority` filters and `moderation_status` / `is_flagged` fields, and moves
  `operations` last.
- `hook_theme`: `flagged_comments_list`, `flagged_comment_details`.

## Data model — `openai_flagged_comments` (`.install` `hook_schema`)

Columns: `id` (serial PK), `comment_id`, `entity_type`, `entity_id`, `user_id`,
`flagged_categories` (JSON), `category_scores` (JSON), `raw_result` (JSON), `status`
(varchar 30, default `pending_review`), `flag_source` (varchar 20, default `automatic`),
`moderator_id`, `moderator_notes`, `created`, `moderated`. Indexes on `comment_id`, `user_id`,
`status`, `created`, and `(entity_type, entity_id)`. Rows are written by
`CommentModerator::storeFlaggedComment()` and read by the storage service / views field plugins.

## Programmatic examples

```php
// Moderate a comment on demand.
$result = \Drupal::service('comment_moderation_ai.comment_moderator')->moderateComment($comment);
// ['flagged'=>bool, 'categories'=>[...], 'category_scores'=>[...], 'raw_result'=>...]

// Post-publication flag (no UI; call directly). Requires post_moderation.enabled.
\Drupal::service('comment_moderation_ai.comment_moderator')
  ->flagCommentPostModeration($comment, 'Spam reported', $reporterUid, ['note' => '...']);

// Change a flag's status.
\Drupal::service('comment_moderation_ai.comment_moderator')
  ->updateFlaggedCommentStatus($comment->id(), 'approved', \Drupal::currentUser()->id());
```
