<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Controls the maximum length of the media `name` field, both at the field-definition level and in the database schema.

---

`hook_entity_base_field_info_alter()` (`media_title_length.module`) sets `media.name`'s `max_length` setting to the value stored in `media_title_length.config` (`title_length`, default 255). The settings form `TitleLengthForm` at `/admin/mtl/config` (permission **`modify title length`**, `restrict access: true`) accepts an integer 1-65535 and, on submit, calls `media_title_length_changer('media','name',$length)`, which performs a live DB alter: it updates the last-installed field storage definition, the `entity.storage_schema.sql` key-value store, and runs `Database::changeField()` on both `media_field_data` and `media_field_revision` (and `admin_audit_trail.ref_char` when that module exists) to widen/narrow the `varchar` column. Because it directly alters storage, shrinking below existing data lengths risks truncation - increases are safe. There is no submodule, service, or Drush command; the whole feature is the config value plus the schema-changer function.

---

- Increase the media name limit beyond core's 255 characters for long document titles.
- Enforce a shorter media name limit to keep listings tidy.
- Set the limit once via `/admin/mtl/config` and have it applied to the DB schema immediately.
- Keep the base-field `max_length` in sync with the actual column width.
- Widen `media_field_data` and `media_field_revision` name columns together.
- Also widen `admin_audit_trail.ref_char` so audit logging of long names doesn't fail.
- Restrict who can change the limit via the `modify title length` permission.
- Support long auto-generated media names (e.g. from Media Pixabay or bulk upload).
- Avoid "data too long" errors when importing media with long filenames.
- Apply a consistent name length policy across all media bundles.
- Store the chosen length persistently in `media_title_length.config`.
- Validate the entered value is numeric and within 1-65,535 before applying.
- Use on Drupal 8.8+, 9 or 10 sites with the core Media module.
- Re-run the change simply by re-saving the form with a new value.
- Pair with content migrations that carry titles longer than 255 chars.
- Keep revisions consistent by altering the revision table in the same operation.
