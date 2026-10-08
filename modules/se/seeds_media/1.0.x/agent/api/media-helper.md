<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MediaHelper service (`seeds_media.helper`)

Service id **`seeds_media.helper`**, class `Drupal\seeds_media\MediaHelper`
(`src/MediaHelper.php`). Constructor args: `@entity_type.manager`, `@entity_field.manager`
(declared in `seeds_media.services.yml`).

## `mediaUseablity(MediaInterface $media): int`

Returns how many entities across the whole site reference the given media entity through any
media reference field.

Mechanism:
1. Loads all `field_storage_config` entities of type `entity_reference` whose
   `settings.target_type == 'media'`.
2. For each such field, builds the data table name `"{entity_type}__{field_name}"` and a
   `SELECT entity_id, {field}_target_id FROM <table> WHERE {field}_target_id = :id` query
   (the media id is bound as a `:id` placeholder).
3. `array_reduce`s the per-field queries into one `UNION`, executes it, and returns
   `count($result)` — the number of matching rows.

Usage from custom code:

```php
$count = \Drupal::service('seeds_media.helper')->mediaUseablity($media);
if ($count > 0) {
  // Media is referenced somewhere.
}
```

Notes / limitations:
- Counts **rows**, i.e. individual reference occurrences, not distinct host entities — a media
  referenced twice by one node counts as two.
- Only covers `entity_reference` fields targeting `media`. It does **not** cover `media` embedded
  through CKEditor entity-embed (which stores UUIDs in text), reference fields of other types,
  or media referenced only in config.
- Table/column names come from field machine names (trusted field config), and the media id is a
  bound parameter — the query is not built from request input.
- This is the count consumed by the "Check Media Usability" warning on the media image edit form
  (see [../config/settings.md](../config/settings.md)).
