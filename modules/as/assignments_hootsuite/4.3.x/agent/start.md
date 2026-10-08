<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assignments Hootsuite (assignments_hootsuite) — agent index

Extends the **Assignments** module with a **Hootsuite** REST-API integration over **OAuth2**. Each enabled Hootsuite social profile becomes an `assignment` bundle; scheduling that assignment on a node schedules (or deletes) a Hootsuite post. Version 4.3.0, core `^10 || ^11`, PHP `^8.1`.

- **Depends on:** `assignments:assignments`, `oauth2_client:oauth2_client` (composer: `drupal/assignments:^4.1`, `drupal/oauth2_client:^4.1`).
- **Package:** assignments. No config schema, no submodules, no Drush.
- **Permission:** `administer hootsuite api settings` (`restrict access: TRUE`) — gates all three routes.

## Routes (`assignments_hootsuite.routing.yml`)
- `assignments_hootsuite.settings` — `admin/config/services/assignments_hootsuite` → `Form\Settings` (client id/secret, OAuth2 + API endpoint URLs).
- `assignments_hootsuite.profiles` — `.../assignments_hootsuite/profiles` → `Form\Profiles` (select Hootsuite social profiles → create bundles).
- `assignments_hootsuite.callback` — `assignments_hootsuite/callback` (GET) → `Controller\Callback::callbackUrl` (OAuth2 redirect target).

## Services (`assignments_hootsuite.services.yml`)
- `assignments_hootsuite.client` → `Service\HootsuiteAPIClient` (implements `HootsuiteAPIClientInterface`) — OAuth2 auth URL, token exchange/refresh, generic `connect()` REST call.
- `assignments_hootsuite.post_manager` → `Service\HootsuitePostManager` (implements `HootsuitePostManagerInterface`) — schedule/delete Hootsuite posts, image upload, profile metadata.

## Hooks (`assignments_hootsuite.module`)
`hook_node_insert/update/predelete`, `hook_assignment_predelete`, `hook_entity_translation_create` — all delegate to the post manager keyed off `field_hs_assignment`.

## Config & state
- Config object `assignments_hootsuite.settings`: `client_id`, `client_secret`, `url_auth_endpoint`, `url_token_endpoint`, `url_post_message_endpoint`, `url_post_media_endpoint`, `url_social_profiles_endpoint`, `url_delete_message_endpoint`, plus `social_profile_<id>` flags.
- Tokens live in Drupal `state`: `hootsuite_access_token`, `hootsuite_refresh_token` (moved out of the old `assignments_hootsuite.tokens` config by `assignments_hootsuite_update_10000`).
- Bundle fields (created by `Profiles`): `field_hs_post`, `field_hs_date`, `field_hs_image`, `field_hs_profile_id`, `field_hs_profile_name`, `field_hs_post_id` (+ optional `field_hs_pinterest_board`/`field_hs_pinterest_url`); node reference `field_hs_assignment`.

## Solution docs
- [config/settings.md](config/settings.md) — install, settings + profiles forms, OAuth2 connect flow, config keys.
- [api/client.md](api/client.md) — `HootsuiteAPIClient`: auth URL, token exchange/refresh, `connect()`.
- [api/post-manager.md](api/post-manager.md) — `HootsuitePostManager` + node/assignment hooks, fields, image upload.
