# Drush commands

Defined in `src/Commands/MediaExpireCommands.php` (registered via `drush.services.yml`).

| Command | Aliases | Action |
|---|---|---|
| `media:expire-check` | `mec`, `media-expire-check` | Runs `MediaExpireService::unpublishExpiredMedia()` immediately — the same sweep that `hook_cron` performs. Unpublishes every expired, currently-published media in each expiring bundle and clears its expire field. |

Takes no arguments or options. Useful to force expiry outside the cron window (e.g. right after
changing an expire date, or in a deployment/QA script). Legacy `media-expire-check` (the old
`drush/media_expire.drush.inc` name) is kept as an alias.
