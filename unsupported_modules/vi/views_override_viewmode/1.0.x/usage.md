<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
views_override_viewmode lets an individual Views block placement override the entity view mode that the underlying view display was configured with, so the same view can render its rows in different view modes per block instance.

---

The problem it solves is view-mode reuse: normally a view's "content" row format hard-codes one view mode (e.g. Teaser), so showing the same content as a "Card" elsewhere means cloning the display. This module swaps the Views block display plugin class (via `hook_views_plugins_display_alter`) for its own `Block` plugin that extends `ctools_views`' block display. When the display's row format is entity-based (`entity:{type}`) and the "Select view mode" allow-setting is enabled, each block instance gains a "View mode" select in its block configuration; `preBlockBuild()` then rewrites the row's `view_mode` option to the block's chosen mode before rendering. A `hook_config_schema_info_alter` adds the `entity_view_mode` key to the views block and block-display schemas so the override is captured in configuration management.

Operational/security notes: this is purely a Views/block display enhancement configured by site builders with "administer views" / block placement permissions — it defines no routes, no permissions, and no public/mutating endpoints. It requires `ctools_views` (it extends the CTools block display) plus core `views` and `block`. Typical setup: enable the module, on the view's block display enable "Select view mode" under the block settings allow-list, place the block, and pick the desired view mode in the block's configuration form.
---
- Render the same view as Teaser in one block and Card in another.
- Enable the "Select view mode" allow-setting on a block display.
- Pick a per-block view mode in the block configuration form.
- Avoid cloning a view display just to change its view mode.
- Override the row view mode only for entity-based row formats.
- Capture the per-block view mode in exported configuration.
- Reuse a single content view across multiple regions with distinct styling.
- Combine with CTools Views block overrides (items per page, etc.).
- Show full content in one placement and summaries in another.
- Keep the view's default view mode when no override is selected.
- Deploy view-mode overrides safely via config schema support.
- Let site builders vary presentation without touching the base view.
- Base the view-mode options on the view's base entity type.
- Fall back to the display's configured view mode as the default.
- Support node and other entity types for the override selector.
