# Media Duplicates — agent index

Detects and optionally blocks duplicate media by hashing each media item's source into a
`duplicates_checksum` base field on presave, then comparing checksums across the site. Depends on
`media`. Ships checksum plugins for File and OEmbed sources; extensible via a plugin type.

- **Settings (restrict/report/compare), the report & rebuild routes, the permission** →
  [configure/settings.md](configure/settings.md)
- **The `MediaDuplicatesChecksum` plugin type: annotation, base class, interface, built-ins, manager** →
  [plugins/checksum.md](plugins/checksum.md)
- **Drush `media-duplicates:checksums:rebuild`** →
  [drush/rebuild.md](drush/rebuild.md)
- **`hook_media_duplicates_checksum_info_alter()`** →
  [hooks/info-alter.md](hooks/info-alter.md)
- **`ChecksumStatistics` service, the `duplicates_checksum` field, the `MediaUniqueChecksum` constraint** →
  [api/services.md](api/services.md)

Key facts:
- Config object `media_duplicates.settings` with booleans `restrict_duplicates`, `restrict_new_media_only`, `compare_within_bundle_only`. No config/install file — the object is absent (all effectively FALSE) until saved.
- Base field `duplicates_checksum` on media (revisionable, translatable), set in `media_duplicates_media_presave()`.
- Enforcement = `MediaUniqueChecksum` constraint on the media entity type (only bites when `restrict_duplicates` is on).
- Report: `/admin/reports/media-duplicates` (perm `access site reports`). Settings: `/admin/config/media/media-duplicates` (perm `administer media duplicates`).
- Drush: `media-duplicates:checksums:rebuild <bundles...>` (note: the module's status-report text mislabels it `media-duplicates:refresh-checksums`; the real command id is `media-duplicates:checksums:rebuild`).
