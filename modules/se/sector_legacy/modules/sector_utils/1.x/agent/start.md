<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector Utilities (sector_utils) — agent index

Submodule of **Sector Legacy**. **Hook-only** editor-UX/admin-UI polish for the Sector
distribution. Package `Sector`. Core `^10 || ^11`. **No `dependencies:`** (soft-integrates with
`entity_usage` and `ds` when present). GPL-2.0-or-later. Version 1.0.6.

## What it provides (all in `sector_utils.module`)

- **`hook_page_attachments`** — attaches library `sector_utils/admin` (`css/layout.css`) **only**
  when the active theme is `claro`.
- **`hook_form_node_form_alter`** — on `claro`: moves `$form['status']` into the `meta` group with
  a "Publishing" heading, clones `$form['actions']` into `meta`, sets original actions
  `#access = FALSE`. For `node_page_form` / `node_page_edit_form`: relabels the status widget to
  "Published" and clears its description.
- **`hook_form_alter`** → **`sector_utils_track_entity_usage()`** — no-op unless `entity_usage` is
  enabled; on a media `ContentEntityDeleteForm` with usages, replaces `$form['description']`
  `#markup` with helper text linking to `entity.media.entity_usage`.
- **`hook_preprocess_field`** — rewrites `field_filesize` via `ByteSizeMarkup::create()` and
  `field_mimetype` via `_niceMimeType()` (a fixed MIME → label map: PDF/DOC/DOCX/TXT/RTF/PPT/PPTX/
  XLS/XLSX/XML/CSV/ZIP).
- **`hook_ds_pre_render_alter`** — adds class `entity-status-unpublished` on non-`full` DS view
  modes of unpublished `EntityPublishedInterface` entities.
- **`hook_contextual_links_view_alter`** — unsets the `block-configure` contextual link unless the
  user has permission `configure blocks from contextual links`.

## Permissions (`sector_utils.permissions.yml`)

- **`configure blocks from contextual links`** — "Access block configuration from contextual
  links". The only permission; consumed by the contextual-links hook above.

## Library (`sector_utils.libraries.yml`)

- **`admin`** — `css/layout.css` (component). No JS.

## Solution docs

- **Every hook, the permission, the field rewrites, and integration notes** →
  [api/hooks.md](api/hooks.md)

## Operate

- `drush en sector_utils -y`. No routes, config objects, config schema, services, or Drush. Most
  behavior is gated on the active admin theme being **Claro**; DS/entity_usage behaviors are gated
  on those modules being present.
