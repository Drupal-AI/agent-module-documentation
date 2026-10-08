<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Autosave History Log (ckeditor_historylog) — agent index

A **pure client-side CKEditor 5 plugin** that autosaves the editor's content to the
**browser's `localStorage`** and adds a toolbar **History Log** dropdown to roll back to an
earlier autosaved revision. Storage is per editor instance and per browser — each editor on a
page has its own history, and nothing is stored server-side. Meant as disaster-recovery (e.g.
recover a long article after a crash/lost tab), not a full versioning system. Package `CKEditor 5`.
Core `^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.0-alpha7** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`ckeditor5`** (core), from `.info.yml`. Nothing else.
- Composer `require` is **empty** (`composer.json`) — no third-party PHP/JS libraries.

## What it provides (from source)

- **One CKEditor 5 plugin** `ckeditor_historylog_button` (`ckeditor_historylog.ckeditor5.yml`):
  toolbar item `historyLog` (label "History Log"), `elements: false` (adds no new allowed HTML
  tags). It bundles two JS plugins in order — `history_log.HistoryLog` then core
  `autosave.Autosave` (Autosave loaded last so HistoryLog can pre-set the autosave config).
- **One PHP class** `Plugin/CKEditor5Plugin/HistoryLog` (`CKEditor5PluginDefault` +
  `CKEditor5PluginConfigurableInterface`) — renders the per-text-format settings form and pushes
  the seven settings into the editor JS via `getDynamicPluginConfig()` under the `historyLog` key.
- **Config schema** `ckeditor5.plugin.ckeditor_historylog_button`
  (`config/schema/ckeditor_historylog.schema.yml`) for those seven settings.
- **Libraries** (`.libraries.yml`): `autosave` (bundled core-autosave build), `history_log`
  (the plugin build, depends on `autosave` + `core/ckeditor5`), and `history_log.admin` (CSS for
  the toolbar-config icon).
- **JS source** under `js/ckeditor5_plugins/history_log/src/` (built to `js/build/history_log.js`
  and `js/build/autosave.js`, both minified & preprocess:false) + 70+ translation files.

## What it does NOT provide (verified — no server surface)

No `*.routing.yml`, no `*.services.yml`, no `*.module`, no `*.install`, no `*.permissions.yml`,
no controllers/entities/DB access, no upload, no HTTP client. All persistence is browser
`localStorage`. There is **no settings page of its own** — you enable it by adding the History
Log button to a text format's CKEditor 5 toolbar.

## Solution docs

- **Per-text-format settings form, config schema, PHP↔JS config bridge** →
  [config/settings.md](config/settings.md)
- **Client-side behavior: autosave loop, localStorage layout, revert command, dropdown UI,
  expiry/quota trimming** → [plugins/history-log.md](plugins/history-log.md)

## Privacy note (public-safe)

Drafts live in the browser's `localStorage` until `expireMinutes` (default 1 day) elapses or the
size cap trims them. On a **shared/public browser profile** a prior author's draft can persist
for the next user of that machine — a data-remnant consideration for sensitive content. There is
no access-control role.
