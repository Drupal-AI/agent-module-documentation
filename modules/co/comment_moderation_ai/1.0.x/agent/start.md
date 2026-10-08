<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Moderation AI (comment_moderation_ai) — agent index

Moderates Drupal **comments** with **OpenAI's Moderation API** plus a set of local regex/keyword
"custom policies". Every new (or content-changed) comment is checked on save via
`hook_comment_presave`; flagged comments are recorded in a custom `openai_flagged_comments` table,
optionally auto-unpublished, and reviewed through admin screens. Package `Custom`. Installed
version **1.0.1** (version dir `1.0.x`). `.info.yml` declares `core_version_requirement: ^11`
(the project's drupal.org metadata also lists ^10). License GPL-2.0-or-later.

## Dependencies

- Core modules (all required, `.info.yml`): `comment`, `user`, `system`, `field`.
- Contrib: **`key`** (`key:key`) — **hard** dependency; the OpenAI API key is a Key entity.
- `composer.json` `require` is empty (no PHP libraries; uses core's `http_client` / Guzzle).
- External service: an OpenAI-compatible **Moderation** endpoint (default
  `https://api.openai.com/v1/moderations`), model `omni-moderation-latest` /
  `omni-moderation-2024-09-26`. It calls the *classification* Moderation endpoint (`input`+`model`),
  not a chat/complet/generative prompt.

## What it provides (from source)

- **Comment hooks** (`comment_moderation_ai.module`): `hook_comment_presave` (moderate new/changed
  comments), `hook_comment_insert` + `hook_comment_update` (re-check + auto-unpublish),
  `hook_form_comment_form_alter` + a `#validate` handler (block flagged submissions inline, show a
  "comments are reviewed" notice), `hook_cron` (cleanup old records), `hook_views_pre_view`
  (inject moderation fields/filters into the `comment` view `page_unapproved`), `hook_theme`.
- **Services** (`.services.yml`): `comment_moderation_ai.openai_client` (`OpenAIClient`),
  `comment_moderation_ai.comment_moderator` (`CommentModerator`),
  `comment_moderation_ai.flagged_comment_storage` (`FlaggedCommentStorage`).
- **Routes** (`.routing.yml`, all under `/admin/config/comment-moderation-ai` except the detail
  page): general settings, custom policies, post-moderation settings, reports, flagged-comments
  list, and `comment_details` at `/admin/content/flagged-comments/{comment_id}`.
- **Permissions** (`.permissions.yml`): `administer comment moderation ai` (restrict access),
  `view flagged comments`, `moderate flagged comments`, `bypass comment moderation`.
- **Views plugins** (`src/Plugin/views/`): field handlers `ModerationStatus`, `ModerationPriority`,
  `FlaggedIndicator`; filters `ModerationStatusFilter`, `PriorityFilter`.
- **DB table** `openai_flagged_comments` (`.install` `hook_schema`) — flag records, scores, status,
  flag source, moderator audit fields.
- **Config** `comment_moderation_ai.settings` (single config object; schema in
  `config/schema/`) — API, categories, thresholds, custom policies, post-moderation.
- Twig templates `flagged-comments-list`, `flagged-comment-details`; `admin` library (css/js).

## Config & data flow

Config object `comment_moderation_ai.settings` (defaults in `config/install/`): `enabled` is
**false** by default, so nothing runs until an admin enables it and sets a Key. `moderation_threshold`
default `0.8`; all 11 OpenAI categories on by default; six custom-policy groups (keyword, length,
rate-limiting, competitor, marketing, PII) all default **off**. See
[config/settings.md](config/settings.md).

Flow: `hook_comment_presave` → `CommentModerator::moderateComment()` → `OpenAIClient::checkContent()`
(OpenAI scores vs threshold vs enabled categories) + local `checkCustomPolicies()` (regex/keyword) →
if flagged, `storeFlaggedComment()` writes a row and status is derived from the top score
(`auto_flagged_high ≥0.9`, `auto_flagged_medium ≥0.7`, `pending_review ≥0.5`, else
`flagged_low_risk`); high-risk is unpublished immediately, medium only if `auto_unpublish`.

## Solution docs

- **All config: API, categories, threshold, custom policies, post-moderation, schema** →
  [config/settings.md](config/settings.md)
- **Services API, hooks, moderation flow, DB schema, programmatic flagging** →
  [services/api.md](services/api.md)
- **Routes, permissions, admin screens, Views integration, templates, known route/PSR-4 bugs** →
  [admin/routes-permissions.md](admin/routes-permissions.md)

## Caveats (functional, from source)

An incomplete module rename (`openai_comment_moderation` → `comment_moderation_ai`) left stale route
references, so the **General Settings** page and the **Flagged Comments list** page throw
`RouteNotFoundException`; a views field file has a PSR-4 class/filename mismatch. Details and the
exact locations are in [admin/routes-permissions.md](admin/routes-permissions.md). The project is
**not covered by Drupal's security advisory policy** (`security_advisory_coverage: not-covered`).
