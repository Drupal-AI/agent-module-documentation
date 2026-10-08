# Cloudflare Stream — agent index

Integrates Cloudflare Stream as a Drupal video field: uploads go to your Cloudflare account via TUS
resumable upload, playback uses Cloudflare's embed player. Provides a field type, widget, formatters,
a `cfstream://` stream wrapper, an API service, a Media source, and two config permissions. Depends on
core `media`.

- **Credentials/config, permissions, field + Media type setup, config keys** →
  [configure/settings.md](configure/settings.md)
- **The `cloudflare_stream` + `cloudflare_stream.api` services and the upload/stream-wrapper flow** →
  [api/services.md](api/services.md)

Submodule (own docs):
- `cloudflare_stream_sync` → [../../modules/cloudflare_stream_sync/3.0.x/agent/start.md](../../modules/cloudflare_stream_sync/3.0.x/agent/start.md)

Key facts:
- Field type `cloudflarevideo` (extends file), widget `cloudflarevideo_default` (extends `FileWidget`),
  formatters `cloudflarevideo_default` (video) + a thumbnail formatter. Media source plugin id
  `cloudflare_stream`.
- Config object `cloudflare_stream.settings`: `api_token`, `account_id`, `subdomain`, `debug_messages`.
  Form route `cloudflare_stream.admin_config.settings` at `/admin/config/media/cloudflare-stream/settings`.
- Permissions: `access cloudflare stream config page`, `administer cloudflare stream settings`
  (neither is `restrict access`; both only reach the credentials/config UI).
- Stream wrapper scheme `cfstream` (`Drupal\cloudflare_stream\StreamWrapper\CloudflareStreamWrapper`):
  write → local temp → TUS upload on `stream_close` → video id kept in private tempstore for
  `CloudflareVideoItem::preSave`, local file deleted.
- API base `https://api.cloudflare.com/client/v4/accounts/<account_id>/stream`; auth
  `Authorization: Bearer <api_token>`.
