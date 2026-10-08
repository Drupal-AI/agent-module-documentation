<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActivityPub — configuration

## Install / enable
`drush en activitypub` (pulls `image`, `options`, `webfinger`, `nodeinfo`). Composer libs
`swentel/activitypub`, `micilini/video-stream` must be present. Configure at
`/admin/config/services/activitypub` (`administer activitypub settings`).

RSA keys are generated per actor by `Signature::generateKeys()` into
`Settings::get('activitypub_keys_path', 'private://activitypub/keys')/<actor>/{public,private}.pem`
(`chmod 0600`). The ActivityPhp remote-object cache lives in
`Settings::get('activitypub_cache_path', 'private://activitypub/cache')` (TTL
`activitypub_cache_ttl`, default 604800s). Both require a working **private** file system.

## Main settings object — `activitypub.settings`
Form: `src/Form/ActivityPubSettingsForm.php`; schema: `config/schema/activitypub.schema.yml`;
defaults: `config/install/activitypub.settings.yml`. Key values:

- Profile/media: `avatar_user_field` (default `user_picture`), `avatar_user_style` (`thumbnail`),
  `header_user_field`, `header_user_style`, `metadata_user_field`, `avatar_default_path`
  (`assets/avatar.png`), `attachment_content_style`.
- Processing handlers: `process_outbox_handler`, `process_inbox_handler`,
  `inbox_remove_x_days_handler` — set to `cron` to run in `activitypub_cron()`, else empty (use Drush).
- Inbox: `inbox_shared_enabled` (bool — opens `/activitypub/inbox`), `inbox_require_follow`,
  `inbox_backfill_follow` + `inbox_backfill_amount` (10), `inbox_blocked_domains` (newline glob list),
  `inbox_ignore_types` (default `Add`,`Offer`,`Remove`), `inbox_remove_x_days` (0=off) +
  `inbox_remove_x_days_keep_unread`.
- `site_wide_uid` — user id whose actor is used by the `publish to site-wide actor` permission.
- Filters: `filter_format`, `filter_format_summary` (both `activitypub` by default; a restricted
  format shipped in `config/optional/filter.format.activitypub.yml`).
- Caching: `cache_images`, `cache_avatar_style`, `cache_attachment_style`, `cache_videos`,
  `cache_adapter` (`file_system` | `drupal_pdo`).
- Logging toggles: `log_general_inbox_error` (on), `log_unsaved_inbox_activity`, `log_error_signature`
  (on), `log_ignore_error_signature` (on), `log_success_signature`, `log_followee_check`.

## `Settings::get()` overrides (settings.php)
`activitypub_keys_path`, `activitypub_cache_path`, `activitypub_cache_ttl`,
`activitypub_local_hosts` (hosts treated as non-public → outbound signing/fetch skipped; default
`['localhost']`, checked by `Utility::hostIsPublic()`).

## ActivityPub types (config entities)
Manage at `/admin/config/services/activitypub/activitypub-type` (`administer activitypub types`).
Ships enabled/optional types in `config/install/activitypub.activitypub_type.*.yml`: `note`, `follow`,
`accept`, `undo`, `delete`, `context`. Each references a `@ActivityPubType` plugin id + configuration
(`plugin.id`, `plugin.configuration.activity`, and for dynamic types `target_entity_type_id`,
`target_bundle`, `object`, `field_mapping`). Enabling a **dynamic** type for `node:article` exposes
`/node/{id}?_format=activity_json`, an outbox form element on that bundle, and an `alternate` link tag
(`activitypub_entity_view()`).

## Admin routes & permissions
- `activitypub.settings` — `administer activitypub settings`.
- `entity.activitypub_type.*` — `administer activitypub types` (`enable`/`disable` carry `_csrf_token`).
- `activitypub.admin.activities` / `.queue` — `manage all activitypub activities` (`restrict access`).
- `activitypub.admin.timeline_items` — `manage all activitypub timeline items` (`restrict access`).
- `activitypub.admin.cache` — `administer activitypub settings`.
- Per-user tabs `/user/{user}/activitypub[/settings|/timeline-items]` require `user.update` entity
  access **and** `UserController::currentUserAndActivityPubPermissionCheck`.

## Drush
`drush activitypub:*` (`src/Commands/ActivityPubCommands.php`) prepares/handles the outbox and inbox
queues and runs old-activity cleanup — the CLI alternative to the `cron` handlers above.
