<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Complete Webform Exporter (complete_webform_exporter) — agent index

Packages a webform submission as a ZIP: an `.xlsx` spreadsheet of the submission's values
**plus every file attached to it** (managed files and signature images). Works one submission at
a time from a per-submission route, or in bulk from a Views submission listing. Version **1.0.9**.
Core `^10.1 || ^11`. Depends on `webform:webform`; uses PhpSpreadsheet (ships with Webform). No
settings form, no config beyond the bulk-action config entity.

## Entry points

- **Single-submission route** `complete_webform_exporter.export_submission`
  `path: /admin/structure/webform/manage/{webform_id}/submission/{submission_id}/files_download`,
  `_controller: CompleteWebFormExporterController::downloadDownload`,
  `_permission: 'download any webform submission managed files'` (defined by this module,
  **`restrict access: TRUE`**). A per-submission **Export submission** operation link is added to
  every `webform_submission` row via `hook_entity_operation` (`CompleteWebformExporterHooks`).
- **Bulk Views action** `webform_submission_export_action`
  (`Plugin/Action/WebformSubmissionsExporterAction`, `type: webform_submission`). Registered into
  Webform's `webform_submission_bulk_form_actions` at install (and by `update_10001`). Its
  `access()` requires **`update` access** on each selected submission entity. `executeMultiple()`
  builds one spreadsheet for all selected submissions, zips it with their files, and streams the
  ZIP directly (`BinaryFileResponse` + `->send()`).

## Classes

- `Service/ExporterService` — all the real work (service id `complete_webform_exporter.exporter`):
  - `buildHeaders($elements)` — fixed columns `Serial number, Submission ID, Created, User,
    LANGUAGE, IP ADDRESS`, then one column per element (skips layout/markup/value/hidden types via
    `$skipElementTypes`); label from `#admin_title ?? #title ?? #key`.
  - `buildRow($webform, $submission, $elements)` — fixed values (serial, id, created date, owner
    display name, langcode, `remote_addr`) then per-element value; arrays imploded with `, `;
    `radios`/`select` mapped to their option label; file elements emitted as absolute file URLs;
    `webform_signature` emitted as an absolute URL to the HMAC-named signature PNG.
  - `collectFileIds()` — gathers fids from all managed-file elements (`getElementsManagedFiles`).
  - `getSignatureRealpath()` — resolves the on-disk signature PNG via
    `Crypt::hmacBase64('webform-signature-' . $token, Settings::getHashSalt())`.
  - `createExcel($headers, $rows, $base)` — writes `temporary://…-<time>.xlsx` with PhpSpreadsheet.
  - `createZip($basename, $callback)` / `addFilesToArchive()` / `addRealPathsToArchive()` — build
    the ZIP in `temporary://`.
- `Controller/CompleteWebFormExporterController::downloadDownload($webform_id, $submission_id)` —
  loads both entities (404 if either missing), builds a one-row spreadsheet, collects fids and
  signature paths, zips them with the Excel, deletes the temp Excel, returns the ZIP as a
  `BinaryFileResponse` attachment.
- `Plugin/Action/WebformSubmissionsExporterAction` — the bulk equivalent over many submissions.
- `Hook/CompleteWebformExporterHooks` — `hook_help` (help page) and `hook_entity_operation` (the
  per-row Export link). `.module` wires them via `#[LegacyHook]` shims.

## Install effects

`hook_install` (and `update_10001`) append `webform_submission_export_action` to
`webform.settings:settings.webform_submission_bulk_form_actions`, so the bulk action shows up on
Webform submission listings. `update_10002` normalises the action label to `Export submission`.
Config: `config/install/system.action.webform_submission_export_action.yml` +
`config/schema/complete_webform_exporter.action.schema.yml`.

## Compatibility note (verified 500)

`ExporterService::__construct()` type-hints the **concrete** classes
`Drupal\Core\File\FileUrlGenerator` and `Drupal\Core\StreamWrapper\StreamWrapperManager`, not their
interfaces. `file_url_generator` is a service that decoupled/CDN modules commonly replace. On a
site where the replacement only *implements* `FileUrlGeneratorInterface` (observed with
`lupus_decoupled_ce_api`), the container throws a `TypeError` and the route returns **HTTP 500**.
One-word fix per argument: hint `FileUrlGeneratorInterface` / `StreamWrapperManagerInterface`.
