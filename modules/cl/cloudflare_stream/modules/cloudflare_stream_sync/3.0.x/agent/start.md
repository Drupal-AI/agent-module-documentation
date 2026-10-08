# Cloudflare Stream - Sync — agent index

Submodule of `cloudflare_stream`. Imports videos already in your Cloudflare account into Drupal as
Media items, via a sync form (Batch API) or a Drush command. Depends on the configured parent module
and a Cloudflare-backed Media type.

- **The sync form, config keys, incremental behavior, and how a Media item is created** →
  [configure/sync.md](configure/sync.md)
- **`drush cloudflarestream:sync` (alias `css`)** → [drush/sync.md](drush/sync.md)

Key facts:
- Form route `cloudflare_stream_sync.sync` at `/admin/config/media/cloudflare-stream/sync`,
  permission `sync cloudflare stream videos` (no `restrict access` flag; reaches the admin sync UI).
- Service `cloudflare_stream_sync` (`Drupal\cloudflare_stream_sync\SyncVideos`).
- Config `cloudflare_stream_sync.settings`: `media_type_id`, `last_imported` (unix ts).
- Dedup: a video is imported only if no existing media has `<source_field>.cloudflareStreamVideoID`
  equal to the Cloudflare `uid` (query runs `accessCheck(FALSE)`).
- Parent's `cloudflare_stream.api::listVideos()` fetches videos; `after` = last_imported for
  incremental syncs.
