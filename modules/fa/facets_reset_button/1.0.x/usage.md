Adds a "Reset Facets Button" block that renders a single "Reset filters" link pointing at the current page with all query-string facet filters stripped off, so a visitor can clear every active facet at once.

---

The module is tiny: it defines one block plugin (`facets_reset_button`, category *Facets*) and a theme hook. The block's `build()` reads the current request, takes the path, and removes the entire query string to produce a bare path used as the link `href`; the link text is the translatable string "Reset filters". Output is rendered by `templates/facets-reset-button.html.twig` and wrapped with classes `facets-reset-button` and `js-facet-block-id-<plugin_id>` plus an inner `a.facets-reset-link`. A small jQuery behavior (`js/facets_reset_button.js`) shows the link only when at least one checkbox facet (`input.facets-checkbox[checked]`) is active and hides it otherwise. The block sets `getCacheMaxAge()` to 0 (uncacheable) because facet blocks must always match live search results. There is no settings form, no config schema, no permissions and no Drush — all setup is done by placing the block and (optionally) overriding the Twig template. It depends on the Facets module and is intended for a Search API facets page whose facets are applied via URL query parameters.

---

- Give visitors a one-click "Reset filters" / "Clear all" control on a faceted search page.
- Clear every active facet at once instead of unchecking them one by one.
- Place the reset link inside a facets sidebar region alongside the individual facet blocks.
- Show the reset link only when at least one checkbox facet is currently selected.
- Hide the reset control automatically when no facets are active (via the bundled JS behavior).
- Return the user to the unfiltered search results by linking to the current path with the query string removed.
- Style the reset control using the `facets-reset-button` / `facets-reset-link` CSS classes.
- Override `facets-reset-button.html.twig` in your theme to change the link markup or wrapper.
- Translate or change the "Reset filters" label via Drupal's string translation.
- Restrict the block's visibility to specific search pages using core block visibility conditions.
- Pair with a Search API + Facets listing that stores active filters in URL query parameters.
- Provide an accessible, always-fresh (uncacheable) reset affordance that matches live results.
- Use with BigPipe so the reset block renders after the main search results, like other facet blocks.
- Add the reset link to a Views-based search page that exposes Facets checkboxes.
- Offer a lightweight alternative to a custom "clear filters" theme snippet.
- Target the block with a specific `js-facet-block-id-*` class when scripting custom facet UX.
