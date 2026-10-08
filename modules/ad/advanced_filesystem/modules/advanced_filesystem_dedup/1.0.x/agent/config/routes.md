<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deduplication — routes, menu & tasks

## Install / enable

```bash
drush pm:install advanced_filesystem_dedup
drush cr
```

Requires the parent `advanced_filesystem` (its controllers/forms back every route) plus core `file`.
This sub-module contributes only routing + links.

## Routes (`advanced_filesystem_dedup.routing.yml`)

All are `_permission: 'administer advanced filesystem'`, `_admin_route: true`. Target classes live
in the **parent** `advanced_filesystem` module.

| Route | Path | Target |
|---|---|---|
| `advanced_filesystem.dedupe` | `/admin/config/media/advanced_filesystem/dedupe` | `AdvancedFilesystemDedupeForm` |
| `advanced_filesystem.perceptual_dedupe` | `…/perceptual-dedupe` | `AdvancedFilesystemPerceptualDedupeForm` |
| `advanced_filesystem.duplicate_alert` | `…/duplicate-alert` | `AdvancedFilesystemDuplicateAlertForm` |
| `advanced_filesystem.dedupe_group_preview` | `…/dedupe/group/{hash}` (`[0-9a-f]{64}`) | `AdvancedFilesystemDupeGroupController::groupReview` |
| `advanced_filesystem.dedupe_cleanup` | `…/dedupe/cleanup` | `AdvancedFilesystemDedupeCleanupForm` |
| `advanced_filesystem.dedupe_cleanup_report` | `…/dedupe/cleanup-report` | `AdvancedFilesystemDedupeCleanupController::cleanupReport` |

## Menu & local tasks

- `…links.menu.yml` adds a "Deduplication" group under `advanced_filesystem.config` with children
  Deduplicate, Visual similarity and Duplicate alerts.
- `…links.task.yml` adds local tabs for Deduplicate, Visual similarity, Duplicate alerts, Cleanup and
  Cleanup report, based on `advanced_filesystem.dedupe`.

## Operating notes

- **Hash-based dedup** (`advanced_filesystem.dedupe`): groups files with identical SHA-256 content;
  the group-preview route resolves a 64-hex hash to its group; the merge step re-points references to
  a canonical file and deletes the extras via the parent's confirm form.
- **Perceptual dedup** (`advanced_filesystem.perceptual_dedupe`): pHash (accurate) or dHash (fast)
  with a configurable maximum Hamming distance and a MIME-type scope; finds visually similar images.
- **Duplicate alerts** (`advanced_filesystem.duplicate_alert`): warns on upload when the SHA-256 of
  the incoming file already exists; the alert level and receiving roles are configurable.
- The hashing, reference-merge and deletion logic all live in the parent `advanced_filesystem`
  module — review those classes there; this sub-module only wires up the routes and links.
