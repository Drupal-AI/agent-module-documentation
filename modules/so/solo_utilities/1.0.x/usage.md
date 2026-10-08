Solo Utilities is a companion module for the Solo theme (by Flash Web Center) that adds site-building extras: conditional color-scheme libraries, per-block title visibility/tag control, and per-node custom width classes. Every feature is a no-op unless Solo (or a sub-theme of Solo) is the active front-end theme.

---

The module ships three loosely-coupled features, all guarded by `solo_utilities__is_solo_or_sub_in_hierarchy_active()`. (1) **Color Schemes Rules** — a `color_schemes_rule` config entity (managed at `/admin/config/solo_utilities/color-schemes-rules`) that pairs core Condition plugins (with an and/or conjunction and per-condition negate) with a predefined Solo color-scheme library; on every page the `solo_utilities.color_schemes_negotiator` service evaluates the enabled rules in order and returns the first matching library. (2) **Block title visibility/tag** — when the Solo theme setting `enable_block_title_visibility` is on, `hook_form_block_form_alter` replaces core's `label_display` checkbox with a three-way select (`visible` / `visually_hidden` / `none`) plus a heading-tag select (`h1`–`h6`/`div`), stored in the block's `settings` as `solo_block_title_visibility` / `solo_block_title_tag` and applied in `hook_preprocess_block`. (3) **Custom node widths** — when the Solo theme setting `enable_custom_node_width` is on, node forms get a "Custom Width" select (e.g. `sw-800`…`sw-2560`, `sw-100`); the choice is stored per node in a `node_width` content entity (DB table `solo_theme_node_width`). Access to the admin UI requires both the Solo theme active and one of the module's `*Color Schemes Rules` permissions (custom access check `solo_utilities.access_check`). A `BlockTitleVisibilityMigrator` service migrates/cleans legacy `label_display` values on enable/disable. There is no global `configure` route; feature toggles live in the Solo theme's settings form.

---

- Load a specific Solo color scheme only on the front page (URL/path condition) via a Color Schemes Rule.
- Apply an alternate color scheme to a section of the site using a request-path condition.
- Switch color schemes by content type using an entity-bundle condition.
- Combine multiple conditions with an AND conjunction so a scheme loads only when all match.
- Combine conditions with OR so a scheme loads when any one matches.
- Negate a condition so a scheme loads everywhere except a given path.
- Enable/disable individual color-scheme rules without deleting them.
- Order rules so the first matching one wins (single library returned per request).
- Hide a block's title from the accessibility tree entirely (`none`) rather than just visually.
- Render a block title for screen-readers only (`visually_hidden`).
- Keep a block title fully visible while changing its heading tag.
- Change a block title's HTML wrapper to `h2`–`h6` to fix heading hierarchy.
- Wrap a block title in a non-semantic `div` to avoid affecting the document outline.
- Migrate existing core `label_display` block settings into the module's richer visibility model on enable.
- Set a fixed max-width class (e.g. 1024px, 1280px, 100%) on an individual node.
- Remove a node's custom width by choosing "None" (deletes the stored `node_width` row).
- Give editors per-node layout width control without Layout Builder.
- Restrict who can manage color-scheme rules with granular view/create/edit/delete permissions.
- Automatically disable all module UI and features when a non-Solo theme is the default.
- Provide a foundation for future Solo theme utilities under one module.
