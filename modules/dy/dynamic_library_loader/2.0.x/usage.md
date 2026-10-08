<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Library Loader conditionally attaches Drupal asset libraries to entities and views from a configurable admin UI, so per-component CSS/JS aggregates with the rest of the page.

---

Dynamic Library Loader lets a site administrator map an asset library (a `theme_or_module/library_name` reference) to a rendering context — a content type, a specific node ID, a taxonomy vocabulary, a paragraph type, a specific paragraph ID, a custom block type, or a view (optionally a view:display). Mappings are grouped into named, individually enable/disable-able "entries", each holding any number of rows, and are stored entirely in the `dynamic_library_loader.settings` config object (no custom database tables since the 2.x line; an `update_1003` hook migrates legacy tables into config). At render time the module's `hook_preprocess_*` and `hook_views_pre_render()` implementations look up the matching mappings and push the referenced library into `#attached['library']`, so the library is picked up during normal Drupal asset aggregation instead of being attached late from a Twig template. The module additionally ships a service provider that swaps Drupal core's CSS and JS collection renderers for subclasses that append the site's `system.css_js_query_string` cache-busting token to every local (non-external) stylesheet and script URL. It has no module dependencies (the old Paragraphs dependency was dropped), provides no permissions of its own (all admin routes require core's `administer site configuration`), and supports Drupal 10, 11, and 12.

---

- Attach a component-specific CSS/JS library to every node of a given content type (e.g. `article`) without editing that node type's Twig template.
- Load a library only on one specific node by its node ID, or on a comma-separated list of node IDs.
- Attach a library to all taxonomy term pages of a given vocabulary (e.g. `tags`).
- Load paragraph-specific styling/scripts whenever a paragraph of a given type (e.g. `image_gallery`) is rendered.
- Target a single paragraph, or several, by paragraph ID.
- Attach a library to a custom block content type (e.g. `custom_block`) wherever that block renders.
- Load a library on a specific view by its machine name, or scope it to a single display with the `view_id:display_id` form (e.g. `my_view:block_1`).
- Ensure per-component CSS aggregates with global CSS so styles are not applied after the main aggregate, avoiding flashes of unstyled or mis-rendered content.
- Group related mappings into a named entry (e.g. "Gallery assets") and toggle the whole group on or off with a single Enabled checkbox.
- Temporarily disable a set of library attachments (e.g. while debugging) without deleting the configuration.
- Manage all mappings from one screen at Configuration > Development > Dynamic Library Loader.
- Add or remove mapping rows dynamically via AJAX while editing an entry.
- Export/import library-to-entity mappings between environments as part of normal Drupal configuration sync (the settings live in config).
- Migrate an existing pre-2.x install's database-stored mappings into configuration automatically by running database updates (`update_1003`).
- Force browser cache invalidation of local CSS/JS by having every aggregated asset URL carry the core cache-busting query string.
- Replace ad-hoc `{{ attach_library() }}` calls scattered across templates with a single, centrally managed configuration.
- Keep third-party/library loading declarative and reviewable in config rather than buried in theme code.
- Deliver interactive-widget assets (sliders, galleries, players) only on the pages that actually contain the widget, reducing global asset weight.
- Roll library mappings forward across sites/environments using configuration management workflows.
