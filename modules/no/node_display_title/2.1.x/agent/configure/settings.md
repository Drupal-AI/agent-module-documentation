<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Node Display Title

## Enable display titles per content type
Route: `node_display_title.settings` · Path: `/admin/config/content/display-title-settings`
Permission: `manage display title field settings`.
Tick the content types that should expose the **Display title** field and save.
Enabled bundles are stored in config `node_display_title.settings:bundles`.

## Permissions
- `manage display title field settings` — access the settings form.
- `access display title field` — edit the display title on any node form.
- `access {bundle} display title field` — per-bundle grant (from `NodeDisplayTitlePermissions::permissions`).

The `display_title` element appears on the node form only when **both** the user holds one of
those permissions **and** the node's bundle is enabled in settings.

## Runtime behaviour
- `display_title` is a string base field (max 255) added to every node via
  `hook_entity_base_field_info`, but only surfaced on the form for enabled bundles.
- The node entity class is `NodeDisplayTitle`; `getTitle()`/`label()` return the display
  title on non-admin routes when set.
- `hook_node_load` copies `display_title` → `title` on front-end routes, except on the
  node's own `/edit` and `/delete` forms (which keep the real admin title).

## Notes
- Leave a node's display title empty to fall back to the normal title.
- Admin routes always show the real title, so editors can still find content.
