# Media Expire — agent index

Auto-unpublishes media entities once a per-bundle date field passes, optionally showing a fallback media
item in their place. Depends on core `media`. No settings page (`configure` null), no permission of its
own; configured through third-party settings on each media type. Provides one Drush command.

- **Enabling expiry per media type, the third-party settings, cron/fallback behavior** →
  [configure/expire.md](configure/expire.md)
- **The Drush command** → [drush/commands.md](drush/commands.md)

Key facts:
- Config lives as `media_type` third-party settings under the `media_expire` namespace:
  `enable_expiring` (bool), `expire_field` (a `datetime` field name), `fallback_media` (media UUID).
- `MediaExpireService::unpublishExpiredMedia()` (service `media_expire.service`) runs on `hook_cron` and
  from `drush media:expire-check`.
- `hook_ENTITY_TYPE_build_defaults_alter` renders the fallback media for an unpublished item of an
  expiring bundle; `MediaExpireAccessControlHandler` grants `view` on such items to *view media* holders
  and a `RouteSubscriber` points the media canonical route at `MediaViewController`.
- A GraphQL `DataProducer` plugin (`FallbackEntity`) exposes the fallback for decoupled use.
