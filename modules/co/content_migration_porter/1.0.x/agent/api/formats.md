<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Porter — export/import format

## Export (`/admin/content-export`, `ContentExportForm`)
`EntityExporter::exportEntities($entity_type, $ids)` returns an array keyed by entity type. For
each exported entity it also emits:
- `paragraph[]` for `entity_reference_revisions` fields (with the parent's field delta stamped
  with the paragraph `uuid`);
- the target entity array under its `target_type` key for `entity_reference` fields;
- `file[]` for `media`/image references, each with an added `download_url`
  (absolute URL from `file_url_generator`).

## Import (`/admin/content-import`, `ContentImportForm`)
Upload the JSON (validated `file_validate_extensions: json`). Steps:
1. **Validate** — checks every entity's bundle, fields, referenced paragraphs and taxonomy
   terms exist on the target; aborts with messenger errors if anything is missing.
2. **Create** in order: `paragraph` → `taxonomy_term` → `file` → `media` → `node` →
   `block_content`. IDs/vids are stripped (`enforceIsNew()`); block_content set `reusable=1`.
3. For each `file`, if the URI is absent on disk it is fetched from `download_url`
   (`file_get_contents`) and written to the recorded URI.
4. `fixEntityReferences()` resolves reference `target_id`s by looking up the stored `uuid`.

Both forms require `administer site configuration`.
