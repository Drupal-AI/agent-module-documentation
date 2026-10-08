<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Mastodon API — endpoints & operation

## Enable
`drush en activitypub_mastodon_api` (pulls `activitypub_api`, `rest`, `simple_oauth`). REST resources
are attribute-defined (`#[RestResource]`) so they self-register; you may need to grant/format them via
the REST UI (`restui`) depending on your REST config. Configure timeline limits at
`/admin/config/services/activitypub/mastodon-api`.

## Client onboarding flow (Mastodon-compatible)
1. `POST /api/v1/apps` (`Apps::post`) with `client_name` (+ optional `redirect_uris`, `scopes`,
   `website`) → creates a Simple OAuth `consumer` (`ActivityPubApiOauth2Trait::createConsumer`) and
   returns `client_id` / `client_secret`. This route is **anonymous** but requires the
   `create activitypub mastodon api consumer` permission, which `hook_install()` grants to anonymous.
   (No flood control — a `// Consider adding flood control?` note is present; unbounded consumer
   creation is possible.)
2. OAuth2 authorization-code flow is handled by Simple OAuth at `/oauth/authorize` + `/oauth/token`
   (the `activitypub_api` middleware lets the token request body be JSON).
3. All other endpoints are called with the resulting bearer token.

## Endpoint groups
- Accounts: `Account.php`, `AccountVerify.php` (`/api/v1/accounts/verify_credentials`).
- Timelines: `Timeline.php` (home/notifications/direct/bookmark by id), `TimelinePublic.php`
  (`/api/v1/timelines/public`, `local` filter), `Conversations.php`, `Bookmarks.php`, `Favourites.php`,
  `Notifications.php`. `MastodonApiTrait::buildTimeline()` + `addPagerConditions()` (`since_id`,
  `min_id`, `max_id`).
- Statuses: `Statuses.php` `/api/v1/statuses/{id}/{action}` — `status` (single), `context`
  (ancestors/descendants), and create actions (post/boost/favourite).
- Media: `MediaV1.php`, `MediaV2.php` (upload via `ActivityPubApiTrait::handleFileUploads`).
- Discovery/metadata: `SearchV2.php` (uses `activitypub.resolve_service`), `InstanceV1/V2.php`,
  `Preferences.php`.

## Response shaping
`MastodonApiTrait::buildStatus()` converts a stored `activitypub_activity`/payload into a Mastodon
status; `buildAccountFromActor()`/`buildAccount()` build account objects (remote actor data is fetched
through `Utility::getServer()`/`signServerRequestWithInstance()` and images are proxied via
`activitypub.media_cache`). `content` is returned as the stored HTML string — client sanitizes on
render. Client-requested `limit` is clamped to `timeline_max_limit`.

## Auth requirements
All resources except `Apps` inherit `_user_authenticated_and_has_actor_check` (authenticated user who
owns an `activitypub_actor`) plus OAuth2. `permissions()` returns `[]` for those (access = actor check
+ token). Note that timeline/notification/DM resources operate on `$this->currentUser` and are scoped
per-user; the single-status `Statuses::get()` `status`/`context` actions load by numeric activity id.
