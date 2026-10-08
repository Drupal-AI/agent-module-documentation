# Drush commands

Registered by `drush.services.yml` as `media_avportal.commands` (`AvPortalCommands`, injected with
`media_avportal.media_updater`).

| Command | Option | Behavior |
|---|---|---|
| `media-avportal:refresh-mapped-fields` | `--mids` = comma-separated media ids | Re-pulls title/thumbnail (and any mapped source metadata) from the AV Portal for existing media. Omit `--mids` to refresh **all** AV Portal media. |

No alias is defined; `@validate-module-enabled media_avportal` guards it.

```bash
# Refresh every AV Portal media entity:
drush media-avportal:refresh-mapped-fields

# Refresh specific media entities:
drush media-avportal:refresh-mapped-fields --mids=12,34,56
```

Internally the command builds a Drupal batch whose operations call
`AvPortalMediaUpdater::refreshMappedFields()` (per id, or once with `NULL` for all). For each media
whose source provider is `media_avportal`, the updater marks the source field as changed so core
re-maps the metadata from the remote source on save, logging each update to the `avportal_media`
channel (see [../api/client.md](../api/client.md)). Run it after upstream titles/thumbnails change,
since stored metadata is not refreshed automatically.
