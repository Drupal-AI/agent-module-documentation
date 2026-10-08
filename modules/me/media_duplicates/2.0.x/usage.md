Media Duplicates detects (and optionally blocks) duplicate media entities by computing a checksum of each media item's source on save, storing it on the media entity, and comparing checksums across the site.

---

The module adds a revisionable, translatable base field `duplicates_checksum` to every media entity and fills it in `hook_ENTITY_TYPE_presave()` using a **checksum plugin** chosen for the media's source plugin id. Two plugins ship: `File` (SHA-256 of the source file, for `file`/`image`/`audio_file`/`video_file` sources) and `OEmbed` (hash of the oEmbed source value). Detection is powered by the `ChecksumStatistics` service (`media_duplicates.checksum_statistics`), which queries the `media_field_data` table for matching checksums; a report at `/admin/reports/media-duplicates` lists every checksum shared by more than one media item. Enforcement is opt-in via a `MediaUniqueChecksum` entity constraint added to the media entity type: on the settings form (`/admin/config/media/media-duplicates`, config object `media_duplicates.settings`) you toggle `restrict_duplicates` (block saving duplicates), `restrict_new_media_only` (only block brand-new items), and `compare_within_bundle_only` (only compare within the same media type). Existing sites generate checksums for old media with the Drush command `media-duplicates:checksums:rebuild` (or the "Rebuild checksums" form at `/admin/config/media/media-duplicates/refresh`). New source/media types are supported by implementing a `MediaDuplicatesChecksum` plugin or by using `hook_media_duplicates_checksum_info_alter()` to map a media type onto an existing plugin. It provides no cleanup/merge of duplicates — only detection and restriction.

---

- Detect image media that point at byte-identical uploaded files across the library.
- Block editors from uploading the same file twice by turning on `restrict_duplicates`.
- Allow existing duplicates to keep being edited but stop new ones (`restrict_new_media_only`).
- Only treat items as duplicates within the same media type (`compare_within_bundle_only`).
- Review a site-wide report of all duplicate media groups at `/admin/reports/media-duplicates`.
- Generate checksums for a legacy library after install via `drush media-duplicates:checksums:rebuild`.
- Rebuild checksums for just the `image` and `video` bundles after changing algorithms.
- Surface a "N media entities are missing a duplicates checksum" warning on the status report.
- Identify duplicate remote videos/oEmbed items that share the same source URL.
- Prevent duplicate document media from bloating storage.
- Add duplicate detection for a custom media source by writing a MediaDuplicatesChecksum plugin.
- Map a new file-based media type onto the existing File checksum via `hook_..._checksum_info_alter()`.
- Show editors the list of conflicting media (with edit links) when a save is blocked.
- Enforce media uniqueness site-wide as an entity validation constraint (works on forms and API saves).
- Store a SHA-256 fingerprint on each media item for later comparison/tooling.
- Pair with Entity Usage to locate and consolidate where duplicates are referenced.
- Audit how many duplicate media exist via the runtime requirements on the status report.
- Gate media uniqueness with the `administer media duplicates` permission (restricted access).
- Compare checksums with the `ChecksumStatistics` service in custom reporting code.
- Keep checksums correct across revisions and translations (field is revisionable + translatable).
- Progressively roll out enforcement: report-only first, then restrict new, then restrict all.
- Fingerprint media on import/migration so duplicates surface immediately.
- Query which checksums have duplicates programmatically (`checksumsWithDuplicates()`).
