<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Vanilla Javascript Tabs (VVJT) adds a Views style plugin that renders any View's rows as an accessible tab group — top, bottom, left, or right placement — using plain JavaScript instead of jQuery or a bundled tabs library.

---

Views has no tab format of its own, so sites reach for a contrib tabs/accordion module and typically inherit jQuery, a third-party plugin, and that plugin's accessibility record along with it. VVJT takes the other route: vanilla JavaScript, no framework, no bundled library, and accessibility treated as a requirement — the W3C ARIA APG tab pattern with keyboard operation (Left/Right arrows, Home, End, Enter/Space, automatic activation on arrow), correct `role="tab"`/`role="tabpanel"`/`aria-selected`/`aria-controls` wiring, focus management, and reduced-motion handling.

Under the hood it is a Views style plugin (`views_vvjt`, class `Drupal\vvjt\Plugin\views\style\Tabs`) that renders a `<vvjt-tabs>` custom element. Each View row supplies one tab: the row template splits the rendered fields on a `<div class="vvjt-separator"></div>` marker, so the **first field becomes the tab button** and the **remaining fields become that tab's pane**. The View must use the *Fields* row style (the plugin enforces it and validates for it). In 2.x it builds on the shared `vvj_core` module (installed automatically by composer), which holds the base style plugin (`VvjStylePluginBase`), the token resolver, and the JavaScript `ElementBase`, so the whole VVJ family can be mixed on one site without duplicating the foundation. Options cover tab position, seven animation presets (none / opacity / zoom / four slide directions), button and pane background colors with a disable toggle, wrap-vs-scroll for overflowing tabs, max width/height, a vertical-to-horizontal collapse breakpoint (576/768/992/1200/1400 px), an optional CSS library, and shareable per-tab deep links (`#tabs-{identifier}-{n}`). It also exposes a `Drupal.vvjt.*` JavaScript API and `[vvjt:FIELD]` Views tokens for header/footer/empty text.

Two constraints to plan around: core `^11.3 || ^12` (no Drupal 10 path) and **PHP 8.3+** — both deliberately forward-looking for contrib. Because it is only the rendering layer, everything Views already offers — filters, sorts, contextual arguments, pagers, caching, access — behaves normally, and it carries no routes, controllers, permissions, or admin config page of its own.

---

- Render Views results as an accessible tab group.
- Replace a jQuery-based tabs or accordion module.
- Avoid pulling a third-party JavaScript library onto the page.
- Meet keyboard accessibility requirements (ARIA APG) for tabbed content.
- Give screen-reader users correct `role="tab"`/`tabpanel` state.
- Build tabs from a filtered content listing (first field = tab label, rest = pane).
- Drive the tabs from taxonomy- or reference-filtered results.
- Use contextual filters to vary tab content per page.
- Combine the tabs with a Views pager, sorts, and access checks.
- Place tabs at the top, right, bottom, or left of the pane.
- Show vertical tabs that collapse to horizontal below a chosen breakpoint.
- Animate pane transitions (opacity, zoom, or a slide direction).
- Set button and pane background colors, or disable both.
- Wrap overflowing tab buttons instead of auto-scrolling them.
- Provide shareable deep links to individual tabs (`#tabs-products-3`).
- Drive the tabs programmatically from site JS via `Drupal.vvjt.*`.
- Inject first-row field values into Views header/footer text with `[vvjt:field]` tokens.
- Respect users' reduced-motion preference automatically.
- Mix multiple VVJ formats (carousel, slideshow, accordion…) on one site without duplication.
- Theme the tabs with the site's own CSS (stable `.vvjt-*` classes).
- Reduce front-end payload on a content-heavy page.
- Plan a Drupal 11.3+ / PHP 8.3 front-end stack.
- Retire an unmaintained or inaccessible tabs module.
- Upgrade a 1.x VVJT install with API/class/library/CSS names preserved.
- Start from the shipped `vvjt_example` reference view.
