# Reset Facets Button block

The module's entire feature is one block. There is no admin settings form.

## Place the block
- Block plugin id: `facets_reset_button` (admin label "Facets Reset Button block", block category
  "Facets").
- Place it via *Structure → Block layout* (or a `block` config entity) in the region that holds your
  facet blocks — typically the search sidebar of a Search API + Facets page.
- Use core block **visibility conditions** (e.g. request path) to show it only on search pages.

## What it renders
`ResetFacetsBlock::build()`:
- Reads the current request, takes `getPathInfo()`, and strips the **entire query string** from it
  (`str_replace(query_string, "", path)`), yielding a bare path with no facet parameters.
- Returns:
  ```php
  [
    '#theme' => 'facets_reset_button',
    '#link'  => $path,            // current path, query string removed
    '#attributes' => ['class' => ['facets-reset-button', 'js-facet-block-id-' . $pluginId]],
  ]
  ```
- Template `templates/facets-reset-button.html.twig`:
  ```twig
  {{ attach_library('facets_reset_button/facets_reset_button') }}
  <a class="facets-reset-link" href="{{ link }}">{{ 'Reset filters'|trans }}</a>
  ```
  Note the `#attributes` set in `build()` are not printed by this default template — override the
  template if you need them on the markup.

## JS show/hide behavior
Library `facets_reset_button/facets_reset_button` (js `js/facets_reset_button.js`, depends on
`core/jquery`). On attach it looks for `input[checked='checked'].facets-checkbox`; if any exist it
`.show()`s `.facets-reset-button a.facets-reset-link`, otherwise `.hide()`s it. So the reset link is
only visible when at least one **checkbox** facet is active.

## Caching
`getCacheMaxAge()` returns `0` — the block is never cached (facet blocks must always match live
search results). Enable BigPipe so it renders after the main results, like other facet blocks.

## Caveats / assumptions
- The reset works by dropping the URL query string, so it only clears facets that live in **query
  parameters** (the common Search API facets "query string" URL processor). Facets encoded into the
  URL **path** (pretty-path/`facets_pretty_paths`) are not stripped.
- The JS visibility toggle keys off the `facets-checkbox` class, i.e. checkbox-widget facets.
- Customize the label by translating the "Reset filters" string; customize markup by overriding
  `facets-reset-button.html.twig` in your theme.
