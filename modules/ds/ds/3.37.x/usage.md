Display Suite gives site builders full control over how any entity type is displayed, arranging fields into configurable region-based layouts without writing Twig templates.

---

Display Suite (DS) extends core's "Manage display" screens so that each entity type, bundle, and view mode can be assigned a multi-region layout (one, two, three, or four columns, stacked variants, or a custom Layout API layout). Fields are then dragged into regions and rendered through configurable field templates that control the wrapping HTML, label placement, and CSS classes. Beyond real entity fields, DS lets you add virtual "custom fields" — token fields, Twig fields, block fields, code fields, and copy fields — directly to a display. It builds on Drupal's Layout Discovery/Layout API, so its layouts are ordinary layout plugins reusable elsewhere. Developers extend it with `DsField` and `DsFieldTemplate` plugins and a large set of alter hooks. Optional submodules add per-node view-mode switching (`ds_switch_view_mode`), extra display features (`ds_extras`), and Devel integration (`ds_devel`). Everything is stored as exportable configuration on the entity view display, so displays deploy cleanly between environments. It is a long-standing, widely used alternative to hand-maintained templates and to Layout Builder for structured entity output.

---

- Apply a two-column layout to the full node display of an article.
- Give a content type a stacked header/left/right/footer layout.
- Move the title, body, and image fields into different regions of a display.
- Configure a compact teaser view mode with its own layout.
- Add a custom Twig field that renders computed markup inline with entity fields.
- Add a token field like `[node:author]` without creating a real field.
- Embed a reusable block (e.g. a menu or view) into an entity's display as a block field.
- Copy an existing field's output into another region with a copy field.
- Wrap a field in custom HTML tags and CSS classes via a field template.
- Hide field labels or place them inline/above using field label options.
- Add custom CSS classes to layout regions from the UI.
- Expose entity displays as Views row plugins to render full entities in a view.
- Switch which view mode a specific node uses from the node edit form (ds_switch_view_mode).
- Build a landing-page-style node display with several columns and grouped fields.
- Standardize card layouts across multiple content types.
- Provide a print-friendly view mode with a minimal single-column layout.
- Reset a field's markup to bare output using the reset field template.
- Create a new reusable DsField plugin for a computed value in code.
- Define a custom field template plugin to enforce house-style markup.
- Alter available fields or templates globally with `hook_ds_fields_info_alter`.
- Add classes to regions programmatically via `hook_ds_classes_alter`.
- Change the rendered view mode conditionally in a view with `hook_ds_views_view_mode_alter`.
- Deploy entity display layouts between dev and production as configuration.
- Combine with Field Group to nest fields inside tabs or accordions within a layout.
- Give user profiles a multi-column layout with avatar and account details separated.
- Render taxonomy term pages with a structured multi-region display.
