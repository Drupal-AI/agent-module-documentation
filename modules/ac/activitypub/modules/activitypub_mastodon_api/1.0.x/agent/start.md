<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub Mastodon API (activitypub_mastodon_api) — agent index

Submodule of **activitypub**. Implements a subset of the Mastodon client REST API as core `@RestResource`
plugins so Mastodon apps can drive a Drupal ActivityPub server. Auth is OAuth2 (Simple OAuth) via
`activitypub_api`.

## Dependencies
`activitypub`, `activitypub_api` (which pulls `rest` + `simple_oauth`).

## REST resources (`src/Plugin/rest/resource/*`, extend `ActivityPubApiRestBase`)
- `Apps.php` → `POST /api/v1/apps` (app registration; **anonymous**, gated by permission
  `create activitypub mastodon api consumer`; `$addAccessCheckRequirement = FALSE`).
- `Account.php`, `AccountVerify.php` → account lookup + `verify_credentials`.
- `Timeline.php` (`/api/v1/timelines/home|…`), `TimelinePublic.php`, `Conversations.php`,
  `Bookmarks.php`, `Favourites.php`, `Notifications.php`.
- `Statuses.php` → `/api/v1/statuses/{id}/{action}` (single status, context, post/boost/favourite).
- `MediaV1.php`, `MediaV2.php` → media upload. `SearchV2.php` → `/api/v2/search`.
- `InstanceV1.php`, `InstanceV2.php` (+ `InstanceBase.php`), `Preferences.php`.

Shaping logic: `src/Traits/MastodonApiTrait.php` (`buildStatus`, `buildAccount*`,
`buildMediaAttachments`, `buildTimeline`, visibility/notification mapping, pager conditions). OAuth
consumer creation reuses `activitypub_api`'s `ActivityPubApiOauth2Trait`.

## Auth model
Non-`apps` resources inherit the parent access check `_user_authenticated_and_has_actor_check`
(authenticated user owning an actor) + OAuth2 bearer token. `apps` is deliberately open (Mastodon
`/api/v1/apps` spec) but requires the `create activitypub mastodon api consumer` permission — granted to
the **anonymous** role by `hook_install()` (`activitypub_mastodon_api_install()`).

## Config (`activitypub_mastodon_api.settings`)
`timeline_limit` (default entries), `timeline_max_limit` (hard cap on client-requested `limit`).
`Settings::get('activitypub_mastodon_api_include_context', TRUE)`,
`activitypub_mastodon_api_reblog_prefix`, `activitypub_mastodon_api_access_token_expire_time`.

## Routes / services / Drush
Settings form `activitypub_mastodon_api.settings` (`/admin/config/services/activitypub/mastodon-api`,
`administer activitypub settings`). `EventSubscriber/ActivityPubMastodonApiEventSubscriber.php`.
Drush `ActivityPubMastodonApiCommands` (`drush.services.yml`).

## Solution doc
- Endpoints, auth flow & operating notes: [agent/api/endpoints.md](api/endpoints.md)
