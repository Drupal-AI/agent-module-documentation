# Brightcove Video Connect — agent index

Integrates Drupal with the Brightcove Video Cloud (OAuth client-credentials via the `brightcove/api`
SDK). Mirrors Brightcove videos/playlists/players/custom-fields/text-tracks into Drupal entities,
pushes videos up via Dynamic Ingest, and syncs via queues (cron / Drush / callbacks). Configure at
`/admin/config/media/brightcove_api_client` (route `entity.brightcove_api_client.collection`).
Many core + contrib deps (datetime, image, inline_entity_form, link, options, path, time_formatter,
taxonomy, token, views). Three submodules.

- **API clients, subscriptions, cron settings, defaults, config entities** → [configure/config.md](configure/config.md)
- **Entities, `BrightcoveUtil` API wrappers (CMS/DI/PM), sync queues, callbacks** → [api/api.md](api/api.md)
- **`brightcove:sync-all` Drush command** → [drush/drush.md](drush/drush.md)
- **Permissions matrix** → [permissions/permissions.md](permissions/permissions.md)
- **Hooks & entity behavior the module implements** → [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs):
- `brightcove_proxy` → [../../modules/brightcove_proxy/3.3.x/agent/start.md](../../modules/brightcove_proxy/3.3.x/agent/start.md) — route API calls via HTTP/SOCKS proxy.
- `media_brightcove` → [../../modules/media_brightcove/3.3.x/agent/start.md](../../modules/media_brightcove/3.3.x/agent/start.md) — "Brightcove Video" media source.
- `brightcove_gallery` → [../../modules/brightcove_gallery/3.3.x/agent/start.md](../../modules/brightcove_gallery/3.3.x/agent/start.md) — In-Page Experience galleries (experimental).

Key facts:
- Config entity `brightcove_api_client` (id, account_id, client_id, secret_key, default_player, max_custom_fields). OAuth token cached in `keyvalue.expirable` (`brightcove.expirable_access_token_storage`).
- Content entities: `brightcove_video`, `brightcove_playlist`, `brightcove_text_track`. Also `brightcove_player`, `brightcove_custom_field`, `brightcove_subscription`.
- Callbacks: `brightcove/ingestion-callback/{token}` (token-gated via `_brightcove_csrf_callback_access_check`) and `brightcove/notification-callback` (`_access: TRUE`).
- Settings `brightcove.settings`: `defaultAPIClient`, `notification.callbackExpirationTime` (86400), `disable_cron`, `ingestion.marked_field_expiry`.
