Migrate Source CSV provides a `csv` source plugin for Drupal's Migrate API, letting you import rows from CSV files into any Drupal entity via a migration definition.

---

This module adds a single but essential piece to the Migrate ecosystem: a source plugin with the id `csv` that reads records from a delimited (CSV) file and feeds them into a migration. You reference it as `source: plugin: csv` in a migration YAML, point it at a `path`, and declare which column(s) form the unique `ids`. Under the hood it uses the well-tested `league/csv` library, so it streams large files efficiently and supports configurable `delimiter`, `enclosure`, and `escape` characters. The header row is taken from `header_offset` (defaults to record 0); set it to `null` for headerless files and supply your own `fields` list of name/label pairs instead. It can also synthesize an incrementing record number per row (`create_record_number` / `record_number_field`), which is handy when a file has no natural key. It plays with the rest of Migrate — process plugins, destinations, migration_lookup, highwater marks — exactly like the core SQL source. Because everything is configuration, migrations are exportable and can be run with Migrate Tools/Drush. It is the standard way to move spreadsheet or exported data into Drupal.

---

- Import nodes from a CSV export (e.g. articles from a legacy CMS spreadsheet).
- Migrate users from a CSV of accounts into Drupal user entities.
- Load taxonomy terms from a categories CSV.
- Populate a custom entity type from a delimited data dump.
- Import product data into Commerce from a supplier CSV.
- Migrate media/file references listed in a CSV.
- Use a single-column `ids` key to uniquely identify each record.
- Use a composite (multi-column) key via an array of `ids`.
- Handle pipe- or tab-delimited files by setting `delimiter`.
- Parse files that quote fields with single quotes via `enclosure`.
- Read headerless CSVs by setting `header_offset: null` and defining `fields`.
- Override header names/labels with an explicit `fields` list.
- Generate a synthetic row number key with `create_record_number` for keyless files.
- Stream very large CSV files without loading them entirely into memory.
- Import from a remote/stream-wrapper path (e.g. `public://`, `s3://`).
- Use `/dev/null` as an empty source for `migration_lookup`-only stub migrations.
- Combine with process plugins to transform CSV columns before saving.
- Chain to any Migrate destination (content, config, entities).
- Run and roll back CSV imports with Migrate Tools Drush commands.
- Re-import changed rows using Migrate's highwater/track-changes features.
- Seed demo/content-staging environments from spreadsheets.
- Import translations by migrating per-language CSV files.
- Feed data into a content-sync pipeline from periodically exported CSVs.
- Bulk-load reference data (countries, regions, codes) from CSV.
