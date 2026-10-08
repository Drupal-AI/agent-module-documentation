<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Semantic Views provides a Views **style** plugin and **row** plugin that let a site builder control the exact HTML element and attributes used for a view's wrapper, list, rows, and each field — all from the Views UI, without writing a template.

---

The module adds two Views plugins: the style plugin `semanticviews_style` ("Semantic Views Style", an alternative to "Unformatted list") and the row plugin `semanticviews_row` ("Semantic Views Row"). In the style plugin you set the element type and attributes for the **grouping title** (default `h3`), the **list** wrapper (none/`ul`/`ol`/`dl`/`div`), and each **row** (default `div`), plus row **striping classes** (default `odd even`), a **first** and **last** class, and a "first/last every nth" interval useful for grid layouts. The row plugin lets you set, per field, the field's element type + attributes and the label's element type + attributes, and a "skip empty fields" toggle. Attributes are entered one per line in a simple `attribute|value` mini-syntax (a bare line becomes both key and value); values support Views token replacement plus a `{{ row_index }}` token for the zero-based row number. All settings are stored inside the view's display configuration (schemas `views.style.semanticviews_style` and `views.row.semanticviews_row`) — the module itself has no settings page, routes, permissions, or Drush commands, and requires only core Views. Output is rendered through two Twig templates (`semanticviews-style.html.twig`, `semanticviews-row.html.twig`) whose preprocessors turn the stored options into `Attribute` objects. It is a pure markup-control tool: it changes the HTML a view emits, not the data it selects.

---

- Wrap a view's rows in `<article>` elements instead of the default `<div>`.
- Render a view as a real `<ul>`/`<ol>` list with `<li>` rows.
- Output a definition list (`<dl>`) from a view.
- Add a custom class or ARIA attribute to every row of a view from the UI.
- Give each field its own semantic element (e.g. `<time>`, `<address>`) via the row plugin.
- Change a field label's element from `<label>` to `<span>` or `<dt>`.
- Add striping classes (`odd`/`even`) to alternate rows for zebra styling.
- Add a `first` class to the first row and `last` class to the last row of a pager set.
- Add `first`/`last` classes every N rows for CSS grid gutters (first/last every nth).
- Insert the zero-based row number into an attribute using the `{{ row_index }}` token.
- Use Views field tokens inside row attributes (e.g. a data-attribute from a field value).
- Set the grouping title's element (default `h3`) and attributes when grouping a view.
- Produce accessible, semantic markup for a listing without a custom theme.
- Skip empty fields entirely so no wrapper markup is emitted for blank values.
- Add a wrapper element + class around the list for styling hooks.
- Match a design system's markup expectations for cards/tiles from the Views UI.
- Add microdata/schema.org attributes to rows or fields via the attributes textarea.
- Remove default Views field wrappers by choosing a bare element type.
- Build a table-like or grid layout by controlling row element + first/last classes.
- Override per-field "Style settings" globally from the row plugin.
- Give editors a no-code way to adjust view markup for CSS.
- Add `role`/`aria-*` attributes to a list for accessibility compliance.
- Configure different markup per display (page vs block) of the same view.
