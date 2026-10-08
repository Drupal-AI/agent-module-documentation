CKEditor Layouts adds a CKEditor 5 "Insert layout" toolbar button that lets editors drop multi-region layouts — defined through Drupal core's Layout API (Layout Discovery) — directly into WYSIWYG body content as nested `<div>` structures.

---

The module is a single CKEditor 5 plugin (`Drupal\ckeditor_layouts\Plugin\CKEditor5Plugin\Layouts`) with a matching JavaScript plugin (`drupalLayouts`) built into `js/build/drupalLayouts.js`. You enable it per text format on the CKEditor 5 toolbar (the `configure` route is the Text formats overview, `filter.admin_overview`); its settings tab exposes an "Enabled layouts" checklist so you can limit which of the site's registered layout plugins are offered in that editor. It reads all core Layout API definitions via `plugin.manager.core.layout` (the internal `layout_builder_blank` is excluded), renders each layout's theme template (with every region present so editors can fill any region) and its icon, and passes them to the browser as `drupalLayouts.layouts`. It then parses each layout's markup and auto-computes the allowed tags/attributes, feeding them into CKEditor 5's General HTML Support (`htmlSupport.allow` / `allowEmpty`) so the layout's `<div class>` wrappers survive filtering. Layout CSS is aggregated at runtime by `hook_library_info_build()` (each layout library's CSS plus the module's `layouts.css`) so the regions look right inside the editor. The text format must allow the layout's markup — practically `<div class>` — so with the "Limit allowed HTML tags" filter you add `<div class>`, and front-end theme CSS must style the layout classes for the output to render as columns. The module defines no permissions, services, Drush commands, hooks, or content entities; only a config schema for the plugin's `enabled_layouts` setting.

---

- Let editors insert a two-column (or any core) layout inside a rich-text body field.
- Add multi-region page-building structure to node body content without Layout Builder.
- Restrict which layouts are available in a given text format (e.g. only 1-col and 2-col).
- Offer different layout sets to different editorial roles by using different text formats.
- Provide equal-width column blocks in WYSIWYG marketing copy.
- Use custom layouts you define with the core Layout API (a `*.layouts.yml` plugin) inside CKEditor.
- Ensure layout `<div class>` wrappers survive text-format filtering via auto-configured GHS.
- Preview layouts with proper spacing inside the editor (layout CSS auto-loaded into the editor).
- Keep body markup portable as plain `<div>` structures rather than Layout Builder sections.
- Add a call-to-action band with side-by-side regions within an article body.
- Build simple landing-page sections editors can rearrange as normal WYSIWYG content.
- Standardise column structures across a site's rich-text content.
- Combine with the "Limit allowed HTML tags" filter by allowing `<div class>` for layout output.
- Style layout regions in the front-end theme by targeting the layout's CSS classes.
- Give editors a visual layout picker (icon + label) rather than hand-writing grid markup.
- Exclude experimental/internal layouts by not enabling them in the plugin settings.
- Provide responsive column layouts (via the layout definition's own CSS/library).
- Author reusable content blocks with predictable region markup for downstream processing.
