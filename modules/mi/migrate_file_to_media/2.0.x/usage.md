Migrate File To Media converts existing file/image field values into Media entities (and the matching media reference fields), de-duplicating identical binaries so each unique file becomes a single reusable media entity.

---

The module provides the tooling to move a site from plain `file`/`image` fields to core Media. First a Drush command generates the target media reference fields from your existing file fields (`drush migrate:file-media-fields <entity_type> <bundle> <source_field_type> <target_media_bundle>`, alias `mf2m`), creating a `<field>_media` entity-reference field for each matching file field. You then write (or generate, via the `mf2m_media` Drush generator) migrate_plus migrations that run in steps: **step 1** uses the `media_entity_generator` source plugin to create one media entity per referenced file — calculating a binary hash so duplicate uploads collapse to a single media entity (`check_duplicate` / `check_media_duplicate` process plugins) — and **step 2** uses the `content_entity:<type>` source to populate the new `<field>_media` reference fields on the original entities via the `file_id_lookup` process plugin. Duplicate detection is backed by two database tables, `migrate_file_to_media_mapping` and `migrate_file_to_media_mapping_media`, populated by `drush migrate:duplicate-file-detection <migration>` (and optionally `migrate:duplicate-media-detection` to reuse pre-existing media). It supports translated file/image fields (creating translated media entities), revisions, paragraphs and any entity type as a source, and includes Drupal 7 source variants. A bundled `migrate_file_to_media_example` submodule ships a complete Article image migration as a worked example. Requires migrate_tools and migrate_plus.

---

- Convert an Article's `field_image` file field into a Media reference field (`field_image_media`).
- Auto-generate media reference fields for every image field on a content type with one Drush command.
- Migrate all file fields of a bundle to media in bulk.
- De-duplicate identical images so re-used files become a single media entity.
- Calculate a binary hash of every file to detect duplicates before importing.
- Migrate translated image fields into translated media entities (one image per language).
- Migrate file fields on paragraphs, not just nodes.
- Migrate file fields on taxonomy terms or any content entity type.
- Preserve alt/title text when creating the media entity from an image field.
- Generate the migration YAML skeletons interactively with `drush generate mf2m_media`.
- Run the migration in resumable, rollback-able steps via the migrate framework.
- Reuse existing media entities instead of creating duplicates (`migrate:duplicate-media-detection`).
- Link newly created media entities back onto the source entities' reference fields (step 2).
- Migrate Drupal 7 file entities into Drupal 10/11 media entities.
- Migrate D7 paragraph or taxonomy file fields to media (dedicated D7 source plugins).
- Handle content revisions when moving files to media (with the documented core patches).
- Copy the underlying file binary into the media entity via the `media_file_copy` process plugin.
- Name new media entities from the file name or alt text via the `media_name` process plugin.
- Track file→media id mapping in dedicated database tables for auditing.
- Start from the shipped example module (`migrate_file_to_media_example`) as a template.
- Push migrated images to a CDN (e.g. rokka.io) as part of step 1.
- Migrate audio/video/document file fields to their matching media bundles.
