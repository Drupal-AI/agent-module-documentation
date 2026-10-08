D7 Content Import recreates Drupal 7 content (vocabularies, terms, content types and fields, files, nodes, URL aliases and menus) in Drupal 11 from XML files produced by a bundled export script.

---

The module is a pragmatic "export-to-XML, import-from-XML" migration tool that bypasses the core D7 to D8/9/10/11 upgrade path. On the source D7 site an admin runs `d7_export_script/export_content.php` under Drush, producing `taxonomy.xml`, `nodes.xml`, `files.xml`, `aliases.xml`, `menus.xml` and (with Webform 7.x-4.x) `webforms.xml`. On the D11 site those files are fed either to an admin form at `/admin/content/d7-import` (gated by the core `administer site configuration` permission) or to a family of Drush commands (`d7-import:all`, `:nodes`, `:terms`, `:files`, `:vocabularies`, `:content-types`, `:aliases`, `:menus`, `:purge`). Seven importer services do the work: `VocabularyImporter`, `TermImporter`, `ContentTypeImporter`, `FileImporter`, `NodeImporter`, `AliasImporter`, `MenuImporter`, plus a `FieldTypeMapper`. The importers preserve original entity IDs by creating the entity, then force-updating the id across base, data, revision and dedicated field tables, and finally bumping the table `AUTO_INCREMENT` past the imported max so future inserts do not collide. Content types and fields are synthesised from the data itself: D7 field types map to D11 types, cardinality is inferred from observed deltas, list `allowed_values` are gathered from usage, entity_reference target types/handlers are derived from the D7 field type, and every field is added to the default form and view displays. Robustness touches include topological ordering of taxonomy terms (orphans/cycles attach at root with a warning), missing source files skipped rather than creating broken managed-file rows, stream-wrapper URI resolution (`public://`, `private://`, `temporary://`), invalid XML control-character sanitisation, memory-bounded cache resets during long runs, and progress logging. An optional `d7_import_webform` submodule maps D7 Webform components, fieldsets, wizard pages, settings and email handlers into a D11 Webform config entity.

---

- Migrate an entire Drupal 7 site's content into Drupal 11 without doing a stepwise core upgrade migration.
- Export D7 content to portable XML files with the bundled `export_content.php` Drush script (supports multisite via `drush -l`).
- Import everything in one shot with `drush d7-import:all /path/to/export/`.
- Preserve original node IDs (NIDs) so inbound links, bookmarks and references stay valid after migration.
- Preserve taxonomy term IDs (TIDs) and file IDs (FIDs) across the move.
- Auto-create vocabularies discovered from the exported terms.
- Import taxonomy terms with full parent/child hierarchy, correctly ordered so parents exist before children.
- Auto-create content types and fields inferred from the exported nodes, with no manual field setup.
- Map two dozen D7 field types (text, image, file, taxonomy_term_reference, entityreference, link, date, list, number, email, telephone, geofield, address, video_embed_field, etc.) to their D11 equivalents.
- Infer field cardinality (single vs unlimited) from how many values nodes actually used.
- Collect `allowed_values` for list_string / list_integer fields from the exported data.
- Bind `taxonomy_term_reference` fields back to their originating vocabulary automatically.
- Register every imported field on the default form and view displays so content is immediately editable and visible.
- Import file entities and optionally copy the physical files from a D7 files directory path.
- Import URL aliases for both nodes and taxonomy terms, with upsert semantics for re-runs.
- Import custom menus and menu links, converting D7 paths (`node/123`, `<front>`, external URLs) to D11 URIs.
- Run individual stages selectively (only terms, only nodes, only files, etc.) from the form checkboxes or per-command Drush.
- Skip individual stages of a full import with `--skip-vocabularies`, `--skip-nodes`, and the other `--skip-*` flags.
- Clean existing data before importing a stage via the form's "Clean before import" option or `drush d7-import:purge`.
- Re-run a failed or partial import safely: already-existing entities are skipped, and corrected aliases are updated in place.
- Import D7 webforms (Webform 7.x-4.x) as D11 Webform config entities via the `d7_import_webform` submodule.
- Convert D7 webform email settings into D11 Webform `email` handlers, translating excluded components and cid-based recipients.
- Run very large imports safely inside `tmux`/`screen`/`nohup` with progress notices every 100 nodes and periodic entity-cache resets.
