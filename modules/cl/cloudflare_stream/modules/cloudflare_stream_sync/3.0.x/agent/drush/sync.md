# Drush: cloudflarestream:sync

`Drupal\cloudflare_stream_sync\Drush\Commands\SyncCommand` (registered via the module's
`drush.services.yml` / `src/Drush`).

```
drush cloudflarestream:sync            # sync using media_type_id stored in config
drush cloudflarestream:sync my_type    # sync using media type "my_type"
drush css                              # alias
```

- Argument `media_type_id` (optional): the Media type to receive imported videos. If omitted, uses
  `cloudflare_stream_sync.settings:media_type_id`; if that's also empty, `syncVideos()` throws
  `\ValueError`. A non-existent id throws `\TypeError`.
- Calls `SyncVideos::syncVideos()` — same import + dedup logic as the form, but runs synchronously
  (no Batch UI) and updates `last_imported` at the end.
- Exceptions are caught and logged to the `cloudflare_stream` (default) logger; the command does not
  re-throw.
- Typical use: a server cron entry to keep Drupal Media in step with Cloudflare uploads.
