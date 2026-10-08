<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Reviewed Date (content_reviewed_date) — agent index

Records when each **node** was last reviewed by an editor and reports **stale** content that is
overdue for review. Package `Content`. Core `^11`. License GPL-2.0-or-later. Version 1.1.0.
Depends on core **`node`** and **`datetime`**. No external services, no libraries, no Drush.

## What it provides (from source)

- **Two base fields on every node type** (`hook_entity_base_field_info` in
  `content_reviewed_date.module`): `content_reviewed_date` (datetime, type `date`, label *Last
  Reviewed*) and `content_reviewed_uid` (entity_reference → user, label *Reviewed By*). Both
  revisionable, not translatable, not required. Present on all bundles; only bundles selected in
  settings are actively used.
- **Auto-stamp on save** (`hook_node_presave`): when an *authenticated* user saves an existing
  node of a tracked bundle, today's date is written to the review fields — unless the review date
  was already changed earlier in the request. New nodes and anonymous/CLI saves are skipped.
- **`ReviewedDateManager`** service (`content_reviewed_date.manager`): all review logic —
  `isEnabled()`, `getEnabledBundles()`, `getThresholdDays()`, `getThresholdDaysForBundle()`,
  `isStale()`, `markAsReviewed()`. See [api/manager.md](api/manager.md).
- **Config object** `content_reviewed_date.settings` (`bundles`, `threshold_days`,
  `threshold_days_per_bundle`) with schema and a settings form. See
  [config/settings.md](config/settings.md).
- **Stale-content report** at `/admin/content/stale-review`
  (`StaleContentController::listStale`). See [config/settings.md](config/settings.md).
- **Mark as Reviewed** form + custom access check on a node local-task tab. See
  [fields/review-fields.md](fields/review-fields.md).

## Routes & permissions

- `content_reviewed_date.settings` → `/admin/config/content/reviewed-date` — perm **`administer
  content reviewed date`**.
- `content_reviewed_date.stale_report` → `/admin/content/stale-review` — perm **`administer
  content reviewed date`**.
- `content_reviewed_date.mark_reviewed` → `/node/{node}/mark-reviewed` — custom access check
  `_mark_reviewed_access` (perm **`mark content as reviewed`** + bundle tracked + node update
  access).

Permissions (`content_reviewed_date.permissions.yml`): **`mark content as reviewed`** (editor
action) and **`administer content reviewed date`** (`restrict access: true`).

## Solution docs

- [config/settings.md](config/settings.md) — settings form, config keys/schema, install defaults,
  the stale-content report, uninstall.
- [api/manager.md](api/manager.md) — `ReviewedDateManager` public API and staleness rules.
- [fields/review-fields.md](fields/review-fields.md) — the two base fields, the presave
  auto-stamp, the Mark as Reviewed form, and its access check.
