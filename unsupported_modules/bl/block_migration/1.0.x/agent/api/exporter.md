<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export service & YAML format

Service `block_migration.exporter` → `Drupal\block_migration\Service\BlockContentExporter` (`src/Service/BlockContentExporter.php`). Constructor: `@entity_type.manager`, `@language_manager`. Bundle-agnostic; auto-detects fields.

## Public API

- `exportAll(string $destination, array $options=[]): array` — loads blocks (`loadBlocks`), resolves languages (`getLanguagesToExport`), writes one YAML per translation, returns `['exported','skipped','errors']`. (The Drush export command does its own loop but reuses `buildExportData`.)
- `buildExportData($translatedBlock, string $langcode): array` — builds the export array for one block translation (see schema below).

## Field detection

`getCustomFields()` walks `$block->getFieldDefinitions()`, skipping computed fields and the base-field set `$baseFieldsToSkip`: `id, uuid, revision_id, type, langcode, info, changed, reusable, revision_translation_affected, default_langcode, revision_default, revision_created, revision_user, revision_log`. Every remaining non-empty field is serialized by `exportFieldData()`.

## `exportFieldData()` — per field type

- `text_long`, `text_with_summary` → `{value, format (default 'plain_text'), summary?}` plus `embed_entities: []`.
- `string`, `string_long`, `text` → `{value}`.
- `entity_reference`, `image`, `file` → `{target_id, alt?, title?}` (**reference only** — no file bytes/entity).
- `link` → `{uri, title, options}`.
- `boolean` → `{value: bool}`.
- `integer`, `decimal`, `float` → `{value (default 0)}`.
- `datetime` → `{value}`.
- `list_string`, `list_integer` → `{value}`.
- default (any other type) → `$item->getValue()` (all properties).

## YAML schema (one file per block × language)

```yaml
site_uuid: ''
uuid: <block uuid>
entity_type: block_content
bundle: <bundle machine name>
base_fields:
  info: <admin label>
  reusable: true
  langcode: <langcode>
  block_revision_id: <revision id>
  enforce_new_revision: true
custom_fields:
  body:
    - { value: '<html>', format: full_html, summary: '', embed_entities: [] }
  field_link:
    - { uri: 'https://…', title: '…', options: [] }
  field_image:
    - { target_id: 123, alt: '…', title: '…' }
```

Filename: `block_content-{ID}-{safe_label}-{langcode}.yml` (`safe_label` = `preg_replace('/[^a-zA-Z0-9_]/','_', label)`). Dumped with `Yaml::dump($data, 10, 2)`.

## Operating notes
- Text fields preserve their original `format` verbatim on export and re-apply it on import (`updateBlockFields`), so the target site must define the same text-format machine names.
- References are ID-based: images/files/media resolve only if the same `target_id` exists on the target; use a dedicated media-migration tool for full asset transfer.
- Import groups files by `uuid`; keep all per-language files for one block together in the import directory.
