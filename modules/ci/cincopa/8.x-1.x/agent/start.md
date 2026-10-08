<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cincopa Multimedia Platform (cincopa) — agent index

Integrates the hosted Cincopa media platform (cincopa.com) into Drupal. Its working
mechanism is a **text-format filter**: an editor writes `[cincopa <gallery-id>]` in
filtered text, the filter emits a placeholder `<div>`, and Cincopa's external
`libasync.js` runtime renders the gallery/video/audio player client-side. Drupal
stores **no** API credentials and makes **no** server-side media calls.

- **Machine name:** `cincopa` · **Package:** Input filters · **Type:** module
- **Core:** `^9.3 || ^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependencies:** none declared in `cincopa.info.yml`. No composer requirements.
- **Config:** none — no `config/install`, no config schema, no settings form/route.
- **Permissions:** none provided (no `cincopa.permissions.yml`).

## What it provides

- **Filter plugin** `filter_cincopa` ("Parse Cincopa Tags"),
  `src/Plugin/Filter/FilterCincopa.php` — the primary, D9–D11 integration path.
- **Libraries** (`cincopa.libraries.yml`): `cincopa.filter.main` (external
  `https://www.cincopa.com/media-platform/runtime/libasync.js`), `cincopa.filter`,
  `cincopa.gallery`, `cincopa.selgallery` (local `js/plugin.js` + jQuery/ajax deps).
- **Route** `cincopa.gallery_dialog` (`/cincopa/dialog/gallery/{filter_format}`) →
  `CincopaGallery::content`, permission `access content` — a read-only info dialog.
- **CKEditor 4 plugins** `cincopagallery`, `cincopaselgallery`
  (`src/Plugin/CKEditorPlugin/…`) plus `cincopa_ckeditor_plugin_info_alter()` — legacy,
  **inert on CKEditor 5 (D10/D11)** since the D7-era `ckeditor` module is absent.
- **Hooks** in `cincopa.module`: `hook_theme` (`cincopa` theme), `hook_element_info_alter`
  (attach lib to toolbar), `hook_theme_registry_alter` (admin help banner override).
- **Dead/legacy code:** `src/Form/EditorCincopagalleryDialog.php` (not routed; references
  an undefined `ImagePopup` class copied from image_popup).

## Solution docs

- [Cincopa tag filter](filters/cincopa-filter.md) — `[cincopa <id>]` filter, output, libraries, setup.
- [Editor buttons, route & hooks](editor/ckeditor-and-hooks.md) — CKEditor 4 plugins, dialog route, theme/registry hooks (legacy).
