<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Alignment Buttons (ckeditor5_alignment) — agent index

Exposes CKEditor 5 text alignment as **four separate toolbar buttons** (Align Left / Center / Right / Justify) instead of core's single alignment dropdown. Installed version **1.0.0-beta2** (version-dir `1.0.x`). Core `^10 || ^11`.

## What it actually is
A code-free module: only `ckeditor5_alignment.info.yml` + `ckeditor5_alignment.ckeditor5.yml`. No PHP, no JS, no CSS, no routes, no permissions, no config schema, no services. It defines **one CKEditor 5 plugin** that reuses CKEditor 5's built-in `alignment.Alignment` plugin and core's `core/ckeditor5.alignment` library.

## Dependencies
- `drupal:ckeditor5` (core).
- Reuses core libraries `core/ckeditor5.alignment` and `ckeditor5/internal.admin.alignment`.

## Provides
- **CKEditor 5 plugin** `ckeditor5_alignment_alignment` (defined in `ckeditor5_alignment.ckeditor5.yml`).
- **Toolbar items:** `alignment:left`, `alignment:center`, `alignment:right`, `alignment:justify`.
- **Output classes:** `text-align-left|center|right|justify` on text-container (block) elements.
- No entities, no plugin *types*, no services, no drush commands.

## Configuration
No settings route. Configure per text format at `/admin/config/content/formats` by adding the buttons in the CKEditor 5 toolbar builder. See:

- [agent/plugins/alignment.md](plugins/alignment.md) — the CKEditor 5 plugin definition, toolbar items, GHS `elements`, and how to enable it.
