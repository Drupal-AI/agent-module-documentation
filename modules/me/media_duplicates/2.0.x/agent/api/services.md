# Services, field & constraint

## `duplicates_checksum` base field

`media_duplicates_entity_base_field_info()` adds a `string` (max_length 64) base field
`duplicates_checksum` to **every** media entity — revisionable and translatable, hidden from form
and view display. It is populated in `media_duplicates_media_presave()`: the checksum plugin for the
media's source id computes the value (or NULL + a logged warning if no plugin/data). The value is
stored on the media entity and queried from the `media_field_data` table.

## `ChecksumStatistics` service

Service id `media_duplicates.checksum_statistics` (class `ChecksumStatistics`, arg `@database`).
Query helpers against `media_field_data`:

| Method | Returns |
|---|---|
| `checksumExists($checksum, $entity = NULL, bool $compareWithinBundleOnly = FALSE)` | bool — checksum already used by another media (optionally same bundle only; excludes `$entity`'s own mid). |
| `checksumsWithDuplicates()` | array `checksum => count` for checksums used by >1 media. |
| `checksumDuplicates($checksum, $entity = NULL)` | array `mid => name` of media sharing a checksum. |
| `numberOfMissingChecksums()` | int — media with a NULL checksum (drives the status-report warning). |

```php
$stats = \Drupal::service('media_duplicates.checksum_statistics');
$groups = $stats->checksumsWithDuplicates();   // duplicate report data
```

## `MediaUniqueChecksum` constraint

`media_duplicates_entity_type_alter()` adds the entity-level constraint `MediaUniqueChecksum` to the
`media` entity type, so it runs on **every** media validation (entity forms *and* programmatic
`$media->validate()` / REST). `MediaUniqueChecksumValidator::validate()` only adds a violation when
`canSave()` returns false — which honours `restrict_duplicates`, `restrict_new_media_only`, and
`compare_within_bundle_only` (see [../configure/settings.md](../configure/settings.md)). The
violation message is `This %value already exists as a media entity in the system.` plus a messenger
error listing the duplicate items.

## Checksum plugin manager

`plugin.manager.media_duplicates.checksum` — see [../plugins/checksum.md](../plugins/checksum.md)
for `createInstanceForMediaType()` / `getDefinitionForMediaType()`.
