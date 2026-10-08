# Search box block + `/search` results page

The search UI is two pieces: a **block** with a text field that redirects to **`/search`**, where
Google's CSE widget renders the results client-side.

## Block
- Plugin: `Drupal\simple_gse_search\Plugin\Block\GSESearchFormBlock` (implements `ContainerFactoryPluginInterface`).
- Annotation: id `simple_gse_search_block`, admin_label "Simple GSE Search Block", category "Search".
- `build()` returns the `SearchForm` via the injected `form_builder` service. `getCacheContexts()` → `['url']`.
- No block-specific settings form. Place it like any block (Block layout UI, or block config / `placeBlock`).

## SearchForm
- Class `Drupal\simple_gse_search\Form\SearchForm` (extends `FormBase`), form id `simple_gse_search_form`.

| Element | Type | Notes |
|---|---|---|
| `s` | textfield | placeholder "Search site...", class `SearchForm-input`; `#default_value` = current `?s=` query param; `#theme_wrappers` emptied, `#size` NULL |
| `submit` | submit | value "go", class `SearchForm-submit` |

- Form wrapper gets class `SearchForm`.
- `submitForm()` calls `setRedirectUrl(Url::fromRoute('simple_gse_search.search_page', [], ['query' => ['s' => <value>]]))` → sends the user to `/search?s=<query>`.

## Results page
- Route `simple_gse_search.search_page` → `/search`, title "Search results".
- Permission `access gse search page`.
- Controller `SearchPage::displaySearchResults` renders `<gcse:searchresults-only queryParameterName="s" linktarget="_parent">` and attaches the `simple_gse_search/search` library + `drupalSettings.simple_gse_search.cx`. Google's client-side `cse.js` fills the element from the `s` query param. See [configure/settings.md](../configure/settings.md) for the embed detail.

## Gotcha
- `/search` is core Search's default path. `hook_install` (warning message) and `hook_requirements` (runtime warning) fire when the core `search` module is enabled — uninstall core Search or the two routes collide.
