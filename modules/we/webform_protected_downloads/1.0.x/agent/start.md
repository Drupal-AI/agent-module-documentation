<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Protected Downloads (webform_protected_downloads) — agent index

Adds a Webform **handler** that gates a file download behind a form submission. When a visitor
submits a webform that carries the handler, the module stores a `webform_protected_downloads`
content entity linking that submission to the configured file and mints a per-submission
download link at `/webform_protected_file/{hash}/download`. The link is surfaced through the
`[webform_submission:protected_download_url]` token, placed in a confirmation message or email.

Depends on `webform:webform ^6.2`, core `file`, and `token:token`. There is **no module settings
page** (`configure` is null) — everything is configured per webform on the handler. Defines no
permissions and no Drush commands. Provides a config schema for the handler settings and one
content entity type.

- **Add the handler to a webform; every handler setting; file upload + allowed extensions;
  expiry / one-time links; and surfacing the link via the token** →
  [configure/handler.md](configure/handler.md)
- **The manager service, the `webform_protected_downloads` entity + its methods, and the
  download route / controller flow** → [api/manager.md](api/manager.md)

Key facts:
- Webform handler plugin id `webform_protected_downloads` (class `WebformProtectedDownloadsHandler`,
  label "Webform Protected Download", category "Downloads", cardinality UNLIMITED — add several per
  webform for several downloads).
- Handler setting keys: `verify_access`, `expiration_one_time`, `expiration_time`,
  `expiration_page`, `expiration_page_custom`, `expiration_error_message`, `protected_file`,
  `protected_file_allowed_extensions`, `debug`. Config schema type
  `webform.handler.webform_protected_downloads`.
- Uploaded files land under `private://webform_protected_downloads/[Y]-[m]` and are marked
  permanent via `file.usage` when the handler is saved.
- Content entity type `webform_protected_downloads` (base_table `webform_protected_downloads`,
  key `id`); fields: `webform_submission`, `handler_id`, `file`, `hash`, `active`, `expire`,
  `onetime`.
- Service `webform_protected_downloads.manager` (class `WebformProtectedDownloadsManager`):
  `getSubmissionByHash($hash)`, `getSubmissionByUuid($uuid, $handler_id = '')`.
- Route `webform_protected_downloads.download` → `WebformProtectedDownloadsController::protectedFileDownload`
  (path `/webform_protected_file/{hash}/download`, `_permission: 'access content'`).
- Token `[webform_submission:protected_download_url]`, with a per-handler sub-token, e.g.
  `[webform_submission:protected_download_url:webform_protected_downloads_2]`.
- Release documented: `8.x-1.0-alpha3` (no stable release exists on this branch).
