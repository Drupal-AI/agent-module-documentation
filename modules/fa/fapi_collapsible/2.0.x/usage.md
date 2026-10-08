<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FAPI Collapsible provides a themeable `collapsible` Form API render element — a fieldset-like container whose body expands and collapses, driven by a Twig template and jQuery behavior rather than core's `details` element.
---
The module registers one custom render element, `#type => 'collapsible'` (class `Drupal\fapi_collapsible\Element\Collapsible`, which extends core's `Fieldset`). Its `getInfo()` adds a `collapsible` theme wrapper, a process callback that attaches the `fapi_collapsible/collapsible` asset library, and extra properties: `#expanded`, `#name`, `#id_collapsible`, `#description` and `#description_attributes`. `hook_theme()` declares the `collapsible` theme hook and `hook_preprocess_collapsible()` maps the element's `#children`, `#name`, `#title`, `#id_collapsible`, `#expanded`, `#description` and `#description_attributes` into template variables, computing a `close` flag from `#expanded`. The shipped template (`templates/collapsible.html.twig`) renders an accessible toggle `<button>` (with `aria-controls` / `aria-expanded`) plus a collapsible content region, and `js/collapsible.js` (a Drupal behavior over jQuery) toggles the region on click. It has no routes, permissions, forms, services, config objects or config schema — it is used purely from PHP/Twig by module and theme developers, so it is a small presentational building block rather than a point-and-click feature. The template supports mutually-exclusive "accordion" groups (via a `data-collapsible-rel` attribute) and optional auto-close when the visitor clicks outside the element (via `data-collapsible-close`), and it can be paired with the Entity List module to render filters as collapsible sections.
---
- Add a collapsible section to a custom form with `#type => 'collapsible'`.
- Give the section a header via `#title` (rendered inside the toggle button).
- Start a section open with `#expanded => TRUE`.
- Start a section collapsed with `#expanded => FALSE` (the default).
- Nest ordinary Form API elements (textfields, selects, etc.) inside a collapsible.
- Group unrelated form controls into independently toggleable blocks.
- Add an optional description under the header via `#description`.
- Attach custom attributes to that description via `#description_attributes`.
- Assign a stable DOM id fragment with `#id_collapsible` for JS/CSS targeting.
- Name a collapsible region with `#name` to get predictable `collapsible-<name>-*` CSS classes.
- Build accordion-like UIs by giving several collapsibles the same `data-collapsible-rel` so opening one closes the others.
- Auto-close a collapsible when the visitor clicks elsewhere via `data-collapsible-close="true"`.
- React to open/close in custom JS by listening for the `collapsible-open` / `collapsible-close` jQuery events.
- Render collapsible output outside of forms, in any render array, by using the element and its `#children`.
- Use it as an alternative to core `details`/`fieldset` when you do not want that element's semantics or default markup.
- Override the `collapsible` template in a theme to fully control the markup.
- Add theme-level template suggestions or preprocessing for per-context collapsible variants.
- Keep long configuration or settings forms manageable by collapsing rarely-used groups.
- Render Entity List filters as collapsible sections (recommended companion use).
- Provide accessible expand/collapse widgets (button with `aria-controls`/`aria-expanded`) without writing custom JS.
- Style collapsibles per region using the generated `collapsible-<name>` / `is-expanded` classes.
- Reuse a single collapsible pattern consistently across multiple custom forms and modules.
