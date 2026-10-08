<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `view` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_view -y`.

## What it installs (config/install)
- `paragraphs.paragraphs_type.view` — the bundle.
- `field.storage.paragraph.field_view` (`viewsreference`, target_type `view`) +
  `field.field.paragraph.view.field_view` (required, label 'View'). Field settings enable plugin types
  default/page/block/attachment/feed and the `argument` + `title` viewsreference settings; no views are
  pre-selected (`preselect_views` all 0), so any view is selectable.
- `field.field.paragraph.view.field_settings` — shared settings field.
- View display: `field_view` rendered by **`viewsreference_formatter`** (label hidden, wrapped with fences
  div); `field_settings` and preview placeholder hidden; Layout Builder disabled.

## Access behavior
The viewsreference formatter executes and renders the chosen view display. The view's configured access
plugin (permission/role/etc.) is checked at render time against the current user, so embedding a
restricted view does not bypass that view's access — an unauthorized visitor sees nothing. The optional
`argument` is author-configured (stored on the paragraph), not taken from the request.
