<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deduplication (advanced_filesystem_dedup) — agent index

Sub-module of **Advanced Filesystem**. Exact (SHA-256) and perceptual (pHash/dHash) file
deduplication plus duplicate-upload alerts. Depends on core `file` and `advanced_filesystem`.
Package `Advanced Filesystem`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version 1.0.27 (dir 1.0.x).

- **All routes, their controllers/forms and permission** → [config/routes.md](config/routes.md)

## What it actually is

- A **routing-only** sub-module: `*.routing.yml`, `*.links.menu.yml`, `*.links.task.yml`, README,
  `.info.yml`. **No `src/`, no config, no permissions, no hooks, no Drush.**
- Every `_controller` / `_form` resolves to a class in the **parent `advanced_filesystem`
  namespace**, so the hashing/merge/delete logic (and its security review) belongs to the parent.
- All routes under `/admin/config/media/advanced_filesystem/*`, gated by
  `_permission: 'administer advanced filesystem'`, `_admin_route: true`.

## Routes (parent-namespace targets)

- `advanced_filesystem.dedupe` — `AdvancedFilesystemDedupeForm` (`…/dedupe`).
- `advanced_filesystem.perceptual_dedupe` — `AdvancedFilesystemPerceptualDedupeForm`
  (`…/perceptual-dedupe`).
- `advanced_filesystem.duplicate_alert` — `AdvancedFilesystemDuplicateAlertForm` (`…/duplicate-alert`).
- `advanced_filesystem.dedupe_group_preview` — `AdvancedFilesystemDupeGroupController::groupReview`
  (`…/dedupe/group/{hash}`, `hash: [0-9a-f]{64}`).
- `advanced_filesystem.dedupe_cleanup` — `AdvancedFilesystemDedupeCleanupForm` (`…/dedupe/cleanup`).
- `advanced_filesystem.dedupe_cleanup_report` — `AdvancedFilesystemDedupeCleanupController::cleanupReport`
  (`…/dedupe/cleanup-report`).

## Notes

- The destructive merge/delete happens through the confirm forms
  (`AdvancedFilesystemDedupeForm` / `…DedupeCleanupForm`) in the parent module — POST forms with
  Drupal's built-in form CSRF token, admin-permission-gated.
- The group-preview route takes a `{hash}` regex-constrained to a 64-char lowercase hex string
  (a SHA-256), used only to look up a duplicate group — not a file path.
- To audit the actual hashing, reference-merge and deletion, read the parent `advanced_filesystem`
  classes named above; this sub-module owns no PHP.
