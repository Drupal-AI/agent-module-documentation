<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 colgroup (ckeditor5_colgroup) — agent index

Client-side CKEditor 5 plugin that adds `<colgroup>`/`<col>` support to tables, for use when core's
`table.TableColumnResize` plugin is **not** enabled (works around core issue #3397556 which otherwise
strips these elements). Version 1.0.0. Core `^10 || ^11`.

## What it provides
- A **CKEditor 5 plugin** `colgroupPlugin.Colgroup` (JS only). No PHP, no routes, no permissions,
  no services, no hooks, no config schema, no admin UI, no submodules.
- Model elements `tableColumnGroup` / `tableColumn` with a `colSpan` attribute, mapped to the
  `<colgroup>` / `<col>` view elements and their `span` attribute.
- Enabled/declared via `ckeditor5_colgroup.ckeditor5.yml` (plugin id `ckeditor5_colgroup_colgroup`,
  drupal label "Colgroup", allowed elements `<colgroup>`, `<colgroup span>`, `<col>`, `<col span>`).
- Asset library `ckeditor5_colgroup/colgroup` (`ckeditor5_colgroup.libraries.yml`) loading the built
  `js/build/colgroupPlugin.js`, depending on `core/ckeditor5`.

## Dependencies
- `drupal:ckeditor5` (core CKEditor 5 module).

## Boundary note
The text format's `filter_html` allowed_html and the editor's Source Editing `allowed_tags` decide what
persists; this plugin only teaches the editor the structural colgroup/col schema. It does not add a
settings form — enable it by adding the "Colgroup" plugin to a text format.

## Solution docs
- [Colgroup CKEditor 5 plugin](plugins/colgroup.md) — schema, converters, how to enable, filter config.
