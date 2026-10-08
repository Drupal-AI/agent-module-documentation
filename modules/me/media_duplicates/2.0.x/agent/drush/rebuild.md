# Drush: rebuild media checksums

```
media-duplicates:checksums:rebuild <bundles...>
```

Regenerates the `duplicates_checksum` for existing media (batch). Use it after installing on a site
with existing media, after changing checksum algorithms, or after adding a checksum plugin.

- Defined in `src/Commands/MediaDuplicatesCommands.php::checksumsRebuild()`, wired via
  `drush.services.yml`, `@validate-module-enabled media_duplicates`.
- **Argument** `bundles` — one or more media type machine names, or `all`. If omitted, an interactive
  `@hook interact` prompts you to choose a media type (or All).

```bash
# All media types:
drush media-duplicates:checksums:rebuild all
# Specific bundles:
drush media-duplicates:checksums:rebuild image video
```

It builds a progressive batch (`MediaDuplicatesChecksumBatch::tasks($bundles)`) and runs it via
`drush_backend_batch_process()`.

> Note: the module's **status-report** description and README call this
> `media-duplicates:refresh-checksums` / `media-duplicates:checksums:rebuild` inconsistently — the
> **actual registered command id is `media-duplicates:checksums:rebuild`** (verify with `drush list`).
> The same rebuild is available in the UI at `/admin/config/media/media-duplicates/refresh`.
