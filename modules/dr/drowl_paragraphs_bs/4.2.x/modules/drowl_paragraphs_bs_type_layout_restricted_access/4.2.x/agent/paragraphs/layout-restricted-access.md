<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `layout_restricted_access` Paragraph type

## Install
`drush en drowl_paragraphs_bs_type_layout_restricted_access -y`.

## Purpose
A DROWL Bootstrap Layout Paragraphs layout that can be limited to selected roles. Restricting the layout
also hides all children nested inside it.

## How the restriction works
- `field.field.paragraph.layout_restricted_access.field_access_by_role` uses field type
  **`entity_access_by_role_field`** (contrib). Editors select roles + an allowed/forbidden access value;
  the module's help text: select Guest + Authenticated for public, only Authenticated for login-only,
  specific roles for member-only, and "if no role is selected, no one except the creator has access".
- Field settings enforce **only the `view` operation** (`view_unpublished`/`edit`/`delete` are off) and
  set `empty_roles_access_fallback: neutral`. Default value: `authenticated` = allowed.
- The access decision is made by the `entity_access_by_role_field` contrib module via the entity access
  system, so an unauthorized viewer never gets the paragraph rendered (server-side, not merely hidden).
  The correctness/edge-cases of that enforcement belong to `entity_access_by_role_field`, which this
  bundle simply configures.

## What it installs (config/install)
- `paragraphs.paragraphs_type.layout_restricted_access` — bundle with the Layout Paragraphs behavior
  (DROWL 1–6 column layouts) and a broad `ui_style_options` enabled-styles set.
- `field_access_by_role` (storage + field), plus shared `field_background_media`, `field_resp_imagestyle`,
  `field_settings`.
- Default view display renders `field_background_media` (view mode `viewport_width`) and hides the access,
  settings, responsive-image-style fields and the preview placeholder.
