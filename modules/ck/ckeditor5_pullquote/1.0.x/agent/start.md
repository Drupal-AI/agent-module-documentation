<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Pullquote (ckeditor5_pullquote) — agent index

CKEditor 5 toolbar button that wraps a selection in a `<pullquote>` element or inserts a standalone `<pulledquote>`, with optional `cite` and per-text-format style variants. Version **1.0.7**, core `^10.5 || ^11`. Package: CKEditor5. License GPL-2.0-or-later.

## What it provides
- **One CKEditor 5 plugin**: `ckeditor5_pullquote_pullquote` (declared in `ckeditor5_pullquote.ckeditor5.yml`), PHP class `Drupal\ckeditor5_pullquote\Plugin\CKEditor5Plugin\Pullquote` — a `CKEditor5PluginDefault` that is `CKEditor5PluginConfigurable`.
- **Filter allowlist elements** registered by the button: `<pullquote>`, `<pullquote class>`, `<cite>`, `<pulledquote>`, `<pulledquote class role>`.
- **Config schema** `ckeditor5.plugin.ckeditor5_pullquote_pullquote` (a `variants` sequence of `{class, label}`).
- **Libraries** (`ckeditor5_pullquote.libraries.yml`): `pullquote` (compiled CKEditor plugin), `admin` (settings CSS), `frontend` (cloning behavior + display CSS, attached on every page).
- **Hook**: `ckeditor5_pullquote_page_attachments()` in the `.module` attaches the `frontend` library site-wide.

## What it does NOT provide
No routes, no `*.permissions.yml`, no services, no entities, no Drush commands, no submodules, no new plugin types. Configuration is per-text-format (via the plugin's settings form), so there is no standalone settings route (`configure: null`).

## Dependencies
`drupal:ckeditor5` (core). No Composer/external library deps.

## How it works (two modes)
- **auto** → stored as `<pullquote>`; the frontend behavior clones it into a floated, `aria-hidden` `<pulledquote>` inside its parent `<p>`.
- **manual** → stored as `<pulledquote role="doc-pullquote">` (standalone).
Both accept a `cite` attribute (downcast to a `<cite>` child) and a single variant `class`.

## Solution docs
- [config/settings.md](config/settings.md) — enabling the button, the `variants` config form, schema, and the filter allowlist.
- [plugins/pullquote.md](plugins/pullquote.md) — the CKEditor 5 plugin internals (model schema, up/downcast converters, JS commands/UI, frontend behavior).
