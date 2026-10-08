<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO — export mechanism

How an entity becomes a JSON file. Source: `src/Service/EntityIoExport.php`,
`src/Service/EntityIoExporter.php`, `src/Controller/*`, `src/Form/Export/*`,
`entity_io.routing.yml`, `entity_io.module`.

## The two export services

- **`EntityIoExport` (`entity_io.export`)** — builds the data array. `export($entity, $depth,
  $max_depth, $selected_fields, $current_langcode)` iterates every field via `exportEntity()` →
  `getFieldValue()`. `getFieldValue()` switches on the field type: scalars return
  `$item->getValue()`; `entity_reference` / `entity_reference_revisions` recurse by target type
  (`getNode`, `getUser`, `getTaxonomyTerm`, `getParagraph`, `getMedia`, `getComment`, `getFile`,
  `getImage`, and `*Type` variants). `getFile()`/`getImage()` read the file and add a
  **`base64`** key. A static `$exportedEntities` index plus a `token`/`already_exported` marker
  prevents infinite recursion; translations are appended under `translations`. `max_depth = -1`
  means unlimited depth (the default used by the UI/CLI). Unknown field types fall through to the
  `hook_entity_io_export_<field_type>_alter` hook (see `entity_io.api.php`).
- **`EntityIoExporter` (`entity_io.exporter`)** — `::toJson($entity, $depth, $max_depth,
  $selected_fields, $langcode, $format='json', $isRevision=FALSE)` calls `EntityIoExport::export`,
  adds `__version__`, optionally compresses (`internal_optimize_json`), `json_encode`s, computes a
  unique filename `<type>-<id>[-rev-<vid>].<fmt>`, writes it to
  `<scheme>://<directory>/<entity_type>/` and populates static `$json`, `$fileName`, `$format`,
  `$publicUrl`. Formats: `json`, `gz` (`gzencode`), `br` (Brotli). For the `private` scheme the URL
  points at the `entity_io.private_file_download` route.

Which fields are exported is decided by `EntityIoExport::getSelectedFields($entity)`, which reads
the per-bundle config object for that entity type (see [../config/settings.md](../config/settings.md));
when no config exists it falls back to **all** fields (`getAllFields`).

## Export UI entry points (`entity_io.module`)

- `hook_entity_operation` adds an **"Export JSON"** operation to node/term/user/block/comment/media
  entities (shown when the user has `administer site configuration`).
- `hook_preprocess_table` adds an **"Export"** link to each row of the node/term/media/block
  revision-history tables, pointing at the matching `*_revision_export` route.
- `hook_page_attachments` attaches the `entity_io/admin` library on admin routes / for
  authenticated users. `hook_theme` registers the `diffs_table` theme (used by import).

## Routes and permissions (`entity_io.routing.yml`)

Per-entity export **forms** (build `Form\Export\*JsonExportForm` / `EntityIoExportForm`):

| Route | Path | Permission |
|---|---|---|
| `entity_io.node_export_form` | `/node/{node}/export` | `export node json` |
| `entity_io.term_export_form` | `/taxonomy/term/{taxonomy_term}/export` | `export taxonomy json` |
| `entity_io.user_export_form` | `/user/{user}/export` | `export user json` |
| `entity_io.media_export_form` | `/media/{media}/export` | `export media json` |
| `entity_io.block_export_form` | `/block/{block_content}/export` | `export block json` |
| `entity_io.comment_export_form` | `/comment/{comment}/export` | `administer export comment json` (undefined perm) |

Revision export **controllers** (each streams the requested revision as JSON directly;
`NodeRevisionExportController`, `TaxonomyTermRevisionExportController`,
`MediaRevisionExportController`, `BlockRevisionExportController`):

| Route | Path |
|---|---|
| `entity_io.node_revision_export` | `/node/{node}/revisions/{node_revision}/export` |
| `entity_io.taxonomy_term_revision_export` | `/taxonomy/term/{taxonomy_term}/revisions/{…}/export` |
| `entity_io.media_revision_export` | `/media/{media}/revisions/{media_revision}/export` |
| `entity_io.block_revision_export` | `/block/{block_content}/revisions/{…}/export` |

Batch export forms — all `export batch json`: `entity_io.export_form`
(`/admin/config/entity-io/export`, `EntityExportSelectorForm`), `entity_io.export_form_batch`
(`EntityBatchExportForm`), `entity_io.export_form_batch_ids` (`EntityBatchIdsExportForm`).

Other export routes — all `administer site configuration`: `entity_io.<entity>_export_json`
(`/<entity>/{id}/export/json`, via `EntityIoExportController::export`, which renders
`EntityIoExportGenericForm`) and `entity_io.private_file_download`
(`/admin/config/entity-io/download/{entity_type}/{filename}`, `FileDownloadController::download`).

JSON API routes: `entity_io.receive_json` (`POST /api/receive-json`,
`JsonApiController::receiveJson` — Basic-Auth checked against `entity_io.settings`) and
`entity_io.export_json` (`GET /api/export-json/{bundle}/{id}/{revision}`,
`JsonApiController::exportJson`).
