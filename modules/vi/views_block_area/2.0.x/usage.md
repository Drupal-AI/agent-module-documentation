<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Block Area exposes every (non-context-aware) block plugin as a Views area handler and a Views field handler, so you can render any block inside a view's header, footer, no-results area, or as a field.

---

The module adds two Views handlers via `hook_views_data()` (`views_block_area.views.inc`): a **Global: Block area** area handler (`views_block_area`, class `ViewsBlockArea`) usable in a display's header, footer, or "no results behavior", and a **Content block: Block field** field handler (`views_block_field`, class `ViewsBlockField`). Both share a service, `views_block_area.creation_helper` (`ViewsBlockCreationHelper`), which builds the option form and renders the chosen block. Handler options are `block_id` (the block plugin id to render), `block_title` (optional title override), `hide_label` (hide the block label), and — for the area handler and optionally the field — `empty` (render even when the view has no results). The block list offered in the settings form comes from the block plugin manager's sorted definitions, **excluding context-aware blocks** (any definition with a `context` key) because those need runtime context a view can't supply. At render time the helper instantiates the block, checks the current user's access, and renders it through the standard `block` theme; it returns nothing for broken blocks or a `block_content` derivative whose content entity no longer exists. There is no admin settings page or configure route — everything is configured per view in the Views UI, and stored in the view's display config as `views.area.views_block_area` / `views.field.views_block_field` handler settings.

---

- Show a site-wide call-to-action or promo block in the header of a listing view.
- Render a "powered by" or branding block in a view's footer.
- Display a custom (block_content) block above a view's results.
- Put a block into a view's "No results behavior" so an empty listing still shows helpful content.
- Add a menu block or search block as a field within a view row.
- Insert an ad or newsletter-signup block between a view's header and its rows.
- Reuse an existing site block inside a view without placing it in a region via Block Layout.
- Override a block's displayed title per view using the `block_title` option.
- Hide a block's label inside a view with the `hide_label` option.
- Force a block to render even when the view returns no results using the `empty` option.
- Embed a "recent comments" or "who's online" core block into a dashboard-style view.
- Compose a landing page as a view whose header/footer are arbitrary blocks.
- Show contextual help or instructional blocks at the top of an admin view.
- Add a social-sharing block as a field alongside each result row.
- Place a views-exposed-filter companion block in a view header.
- Build a footer of stacked blocks inside a single view display.
- Present a block only to users who have access to it (the helper checks block access per user).
- Keep block placement inside the view's configuration (exportable) instead of the global block layout.
- Select any non-context-aware block plugin from the sorted block list in the handler settings.
- Combine multiple block areas (header + footer + empty) in one view.
