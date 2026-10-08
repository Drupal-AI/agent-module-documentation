<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prototype Select provides accessible, searchable enhancements to native `<select>` elements.

---

Prototype Select enhances native HTML `<select>` elements with an **accessible combobox** for
multi-select, a **search/filter box** for long option lists, and selected-value **chips**, while the
native select stays the form-value source (selected values, required validation, reset, and `change`
events are preserved). In 2.0.x the enhancement is driven by the module's own `PrototypeSelect`
JavaScript class — a native `<dialog>`-based popup with collision-aware flip placement, logical-property
offsets (RTL-aware), and CSS custom properties for theming. Selects are matched by a configurable CSS
selector (default `[data-prototype-select]`, which the module adds to selects when enabled) and can be
tuned globally on the config form or per-select via `data-prototype-select-*` attributes. It is in the
Prototype package and requires Drupal core `^11 || ^12`.

Use it to make dropdowns easier to use and more accessible. This is an **accessibility-positive** UI
feature: it enhances form select widgets and has no content model, entity, or access role. Configure it
at **Admin → Config → User interface → Prototype Select** (`/admin/config/user-interface/prototype_select`,
gated by `administer site configuration`). Choose whether it runs on admin pages, front-end pages, or
everywhere. 2.0.x is a major rewrite of the former select-a11y implementation; run database updates after
upgrading (update `20001` migrates the selector config and removes stale settings).

---

- Enhance native `<select>` elements without replacing the native control.
- Add an accessible combobox for multi-select fields.
- Add a search/filter box to long option lists.
- Enable search only when a select has at least N options (threshold).
- Disable the search box entirely (threshold `0`).
- Always show the search box (threshold `1`).
- Limit how many matching options render for performance (`max_shown_results`).
- Match within words, not only at the start, for search.
- Show selected-value chips for multi-selects.
- Hide selected-value chips for multi-selects.
- Make the selected option active when a single-select popup opens (focus selected).
- Target specific selects with a custom CSS selector.
- Exclude specific selects from enhancement with an exclusion selector.
- Run the enhancement only on admin pages.
- Run the enhancement only on front-end pages.
- Run the enhancement on every page.
- Override options per select with `data-prototype-select-*` attributes.
- Customize screen-reader and UI strings (help, placeholder, no-result, result count).
- Customize chip remove text and the multi-select trigger button text.
- Keep required validation, reset, and `change` events working via the native select.
- Theme the popup with CSS custom properties (viewport offsets, gap).
- Follow RTL direction automatically for popup placement.
- Instantiate `PrototypeSelect` directly in custom JavaScript and call `destroy()`.
- Upgrade from the 1.x select-a11y implementation and migrate selector config via update `20001`.
- Exercise enhanced and native examples on the bundled test-fixture page.
