Views Fieldsets adds a "Global: Fieldset" Views field that wraps other fields in a `<fieldset>`, `<details>`, or `<div>`, letting you visually group (and nest) fields in a Views field-based display.

---

The module registers a single Views field handler (id `fieldset`, shown as "Global: Fieldset" / "Views: Fieldset") via `hook_views_data()`. You add one or more of these fields to a Views display, then drag other fields underneath them in the field Rearrange screen — the module patches the Rearrange form with tabledrag parent/depth handling so fields become children of a fieldset and fieldsets can nest inside each other. Each fieldset field has options for wrapper type (details/fieldset/div), a token-aware legend, comma-separated token-aware CSS classes, and collapsible/collapsed toggles. At render time `hook_preprocess_views_view_fields()` swaps each fieldset handler for a `RowFieldset` object that moves its child fields inside and themes them through the `views_fieldsets_fieldset`, `views_fieldsets_details`, or `views_fieldsets_div` theme hooks (Twig templates). A fieldset is only output when at least one child has non-empty content. Legends and classes support Views row tokens (e.g. `{{ title }}`). Wrapper types are extensible through `hook_views_fieldsets_wrapper_types_alter()`. The module works with any field-based Views display and requires only Views core.

---

- Group related Views fields (e.g. address parts, contact details) inside a single `<fieldset>` with a legend.
- Render a collapsible `<details>`/`<summary>` disclosure widget around a set of Views fields.
- Wrap Views fields in a plain `<div>` with custom classes for CSS styling or JS hooks.
- Nest fieldsets inside fieldsets to build multi-level grouped card layouts in a Views row.
- Add a per-row heading/legend built from field tokens, e.g. a legend of `{{ title }}`.
- Apply dynamic, token-driven CSS classes to a group wrapper (e.g. `status-{{ field_status }}`).
- Make a group collapsible and default it to collapsed to keep long rows compact.
- Build accordion-style content teasers where each row's secondary fields hide behind a summary.
- Hide an entire group automatically when all its child fields are empty (no empty wrappers).
- Create a semantic form-like `<fieldset>`/`<legend>` structure for accessible field grouping.
- Separate "primary" and "meta" fields into distinct visual boxes within one Views row.
- Produce print- or export-friendly boxed field groups without writing a custom Views style plugin.
- Add multiple independent fieldsets to one display, each grouping a different subset of fields.
- Register a custom wrapper type (e.g. a Bootstrap card or modal) via `hook_views_fieldsets_wrapper_types_alter()`.
- Override fieldset markup per view, per display, or per field id using granular theme hook suggestions.
- Theme a fieldset only on a specific display (e.g. `views-fieldsets-fieldset--page.html.twig`).
- Style the Views UI Rearrange screen so fieldsets and nesting depth are visually indicated (admin CSS).
- Wrap fields for a paragraphs-based listing view using the module's extra paragraph theme suggestions.
- Group fields in a table-less "Unformatted list" or "Grid" Views display for card UIs.
- Add a token-labeled `<details>` panel per search-result row.
- Build a definition-list-like layout by combining `<div>` wrappers and classes.
- Keep field configuration entirely in the view's config (no separate config entity to manage).
- Reorganize an existing view into grouped sections without changing the underlying query.
- Provide collapsible admin/report views where operators expand only the rows they need.
