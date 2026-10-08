# Facets Reset Button — agent index

Provides one block that renders a single "Reset filters" link back to the current path
with the query string (active facet parameters) removed. Depends on `facets`. No settings
form (`configure` null), no permissions, no config schema, no Drush. Uncacheable by design.

- **Placing the block, how the link/JS work, template & class names, caveats** →
  [configure/block.md](configure/block.md)

Key facts:
- Block plugin id `facets_reset_button`, admin_label "Facets Reset Button block", category "Facets".
- `build()` returns `#theme => facets_reset_button` with `#link` = current path minus query string.
- Template `templates/facets-reset-button.html.twig` → `<a class="facets-reset-link" href="{{ link }}">Reset filters</a>`.
- JS `facets_reset_button/facets_reset_button` (depends on `core/jquery`) shows the link only when an
  `input.facets-checkbox[checked]` exists, else hides it.
- `getCacheMaxAge()` returns 0.
