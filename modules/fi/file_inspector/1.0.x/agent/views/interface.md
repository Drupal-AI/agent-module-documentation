<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Inspector — routes, forms & Views integration

## Routes & permissions (`file_inspector.routing.yml`)

All routes set `_admin_route: TRUE` and are permission-gated:

| Route | Path | Permission | Handler |
|-------|------|-----------|---------|
| `file_inspector.overview` | `/admin/reports/file-inspector` | `view file inspector` | `OverviewController::build` |
| `file_inspector.settings` | `/admin/config/media/file-inspector` | `administer file inspector` | `SettingsForm` |
| `file_inspector.batch` | `…/file-inspector/batch` | `administer file inspector` | `BatchForm` |
| `file_inspector.import` | `/admin/content/file-inspector/import/{id}` | `import unmanaged files` | `ImportForm` |
| `file_inspector.delete` | `/admin/content/file-inspector/delete/{id}` | `delete unmanaged files` | `DeleteForm` |
| `file_inspector.bulk_confirm` | `/admin/reports/file-inspector/confirm` | `view file inspector` | `BulkConfirmForm` |

`{id}` is constrained to `^[1-9]\d{0,9}$` and typed as integer. Menu links
(`file_inspector.links.menu.yml`) place the listing under Reports and settings under
Config → Media; local tasks (`file_inspector.links.task.yml`) add Settings/Batch tabs and an
Overview / "View Files" tab pair (the latter targets `view.file_inspector.page_1`).

Permissions (`file_inspector.permissions.yml`): `view file inspector`;
`administer file inspector`, `delete unmanaged files`, `import unmanaged files` all
`restrict access: true`.

## Access model (grounded in source)

- Single-file `ImportForm`/`DeleteForm` use `FileOperationFormTrait::loadAndValidateFile()`, which
  throws `NotFoundHttpException` for a missing record and `AccessDeniedHttpException` unless the row
  is UNMANAGED — so managed/imported/deleted rows cannot be targeted even by direct URL.
- Bulk flows re-check the `delete`/`import` permission **again at build and at submit** (roles may
  have changed between steps) and re-load + re-validate UNMANAGED status from the DB at submit time.
  `BulkOperationsForm::submitForm()` and `BulkConfirmForm` throw `AccessDeniedHttpException` on a
  permission mismatch. The `bulk_confirm` route only needs `view file inspector`, but the form
  gates the destructive operation behind its own permission internally.
- All four operation forms are Form API forms (`ConfirmFormBase` / `FormBase`), so the state-changing
  step is a POST protected by Drupal's per-form CSRF token; the GET only renders "are you sure?".
  `ActionsField` documents this explicitly to justify caching the plain action links.

## Confirm forms (`src/Form/`)

- `ImportForm` / `DeleteForm` — single-file confirm forms. Import shows a media-bundle selector
  (via `MediaBundleSelectionTrait`) when `canImportMedia()` and multiple media types exist; delegates
  to `ManageFiles::importFile()` / `removeFile()`.
- `BulkOperationsForm` — two-step (select → confirm) form embedded near the View. Collects selected
  ids from a hidden JSON field and/or `bulk_select` checkboxes, validates they exist and are
  UNMANAGED (`validateSelectForm()`), then executes via `BulkFileOperationTrait`.
- `BulkConfirmForm` — reads `bulk_operation` / `bulk_selected_ids` from **private tempstore**
  (`tempstore.private`, collection `file_inspector`), confirms, executes, and clears the tempstore.
- `BulkFileOperationTrait::executeDeleteOperation()` / `executeImportOperation()` — loop the
  pre-validated files, re-skip any row no longer UNMANAGED, and tally success/error counts. Status
  transitions are owned by the `ManageFiles` methods, not re-set here.
- `MediaBundleSelectionTrait` — builds a `select` when >1 media type exists, else a hidden `value`
  with an informational note. `getAvailableMediaTypes()` loads all `media_type` config entities.

## Overview page (`OverviewController::build`, `src/Controller/OverviewController.php`)

Renders a native `#type => table` of per-status counts + grand total from
`DataService::getStatusCounts()`. Each row links to `view.file_inspector.page_1` pre-filtered to that
status code; actionable statuses (unprocessed, unmanaged) get the error colour when non-zero. Empty
store → a guidance message linking to the batch page. Cached with tags
`file_inspector` + `file_inspector_statistics`, context `user.permissions`. Degrades to a friendly
error message on exception.

## Views integration

`hook_views_data()` (`file_inspector.module`) exposes the `file_inspector` base table, standard
handlers for scalar columns, a relationship to `file_managed` (on `path` → `uri`), and custom
handlers under `src/Plugin/views/`:

- **Fields** — `file_inspector_path` (`PathField`): renders the URI as a link to the file's absolute
  URL (`target=_blank`, `rel=noopener noreferrer`) only when the scheme is a valid registered stream
  wrapper; DELETED rows and non-URI paths fall back to `sanitizeValue()` plain text (no broken
  links, output escaped). `file_inspector_actions` (`ActionsField`): a dropbutton of Import/Delete
  links shown only for UNMANAGED rows, each gated by the viewer's permission (+ `canImportMedia()`
  for import). `file_inspector_media` (`MediaField`): links the imported Media entity's edit form,
  batch-loading media in `preRender()`; per-cell it enforces the viewer's `view`/`update` access on
  the Media entity and hides the label from users without view access; the whole column is
  suppressed via `access()` when Media import is unavailable. `file_inspector_status` (`StatusField`)
  and `file_inspector_bulk_select` (`BulkSelectField`) round out the row.
- **Filters** — `file_inspector_status_filter` (`StatusFilter`) and `file_inspector_mime_type_filter`
  (`MimeTypeFilter`), both `views.filter.in_operator` subclasses (schema in
  `config/schema/file_inspector.schema.yml`). `file_inspector_update_10002()` migrates the optional
  View's stored MIME filter from the generic `string` plugin to `file_inspector_mime_type_filter`.

The optional View `views.view.file_inspector` (`config/optional/`) provides the ready-made listing;
`hook_theme` (`src/Hook/FileInspectorHooks.php`) registers the `file_inspector_import_complete`
template.

## Operating it

1. Configure at `/admin/config/media/file-inspector` (see [../config/settings.md](../config/settings.md)).
2. `/admin/config/media/file-inspector/batch` → **Track files** (populates the table), then
   **Process tracked files** (classifies managed/unmanaged).
3. `/admin/reports/file-inspector` → overview counts; the "View Files" tab is the filterable listing
   with per-row Import/Delete and bulk operations.
