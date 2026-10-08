# Settings, report & permission

## Settings form & config object

Route `media_duplicates.settings` → `/admin/config/media/media-duplicates` (permission
`administer media duplicates`). Config object **`media_duplicates.settings`** (schema
`config/schema/media_duplicates.schema.yml`). There is **no `config/install` file**, so on a fresh
enable the object does not exist and every setting reads as NULL/FALSE (no restriction).

| Setting | Type | Effect |
|---|---|---|
| `restrict_duplicates` | boolean | Master switch: block saving a media item whose checksum already exists (enforced by the `MediaUniqueChecksum` constraint). |
| `restrict_new_media_only` | boolean | When restricting, only block **new** media (existing items with duplicate checksums can still be saved). Shown only when `restrict_duplicates` is on. |
| `compare_within_bundle_only` | boolean | Only treat items as duplicates when they share the same media type (bundle). Shown only when `restrict_duplicates` is on. |

```bash
drush config:get media_duplicates.settings
drush config:set media_duplicates.settings restrict_duplicates true -y
drush config:set media_duplicates.settings restrict_new_media_only true -y
drush config:set media_duplicates.settings compare_within_bundle_only true -y
```

Enforcement logic lives in `MediaUniqueChecksumValidator::canSave()`: it returns "can save" (no
violation) when `restrict_duplicates` is off, or when the item is not new and
`restrict_new_media_only` is on, or when no checksum can be computed; otherwise it calls
`ChecksumStatistics::checksumExists()` (respecting `compare_within_bundle_only`). On a blocked save
the user gets the violation plus an error message listing the duplicate media (with edit links).

## Duplicates report

Route `media_duplicates.report` → `/admin/reports/media-duplicates` (permission
`access site reports`). Lists every checksum shared by more than one media entity, with the media
items linked. "Rebuild checksums" and "Settings" action links appear on it.

## Rebuild checksums (existing media)

Route `media_duplicates.refresh_checksums` → `/admin/config/media/media-duplicates/refresh`
(permission `administer media duplicates`) runs a batch to (re)generate checksums. The equivalent
Drush command is documented in [../drush/rebuild.md](../drush/rebuild.md). Newly enabled sites with
existing media will show a "N media entities are missing a duplicates checksum" warning on
`/admin/reports/status` until checksums are rebuilt.

## Permission

- `administer media duplicates` — *"Administer media duplication settings and allow rebuilding
  checksums."* (`restrict access: true`) gates the settings and rebuild routes.
