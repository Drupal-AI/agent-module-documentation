# Views integration

`search_api_fusion_views_data()` (in `search_api_fusion.views.inc`) registers two Views **area** handlers;
`search_api_fusion_theme()` (in the `.module`) registers their templates.

## Area: spellcheck — `search_api_fusion_spellcheck`

Class `Plugin\views\area\FusionSpellcheck`. Reads `spellcheck.suggestions` from the result set's
`search_api_solr_response` extra data, picks the highest-frequency suggested word per term, rebuilds the query
string (whole-word `preg_replace`), and renders a **"Did you mean: <link> ?"** via theme
`search_api_fusion_spellcheck`. Returns nothing if there is no suggestion or the rebuilt text equals the
original query. Relies on `search_api_spellcheck` having requested spellcheck on the query.

## Area: landing pages — `search_api_fusion_landing_pages`

Class `Plugin\views\area\FusionLandingPages`. Reads `fusion.landing-pages` (promoted results, formatted
`url$$$title`) from the same extra data and renders them as a `<ul>` via theme
`search_api_fusion_landing_pages`. When click signals are enabled the pre-extracted variant
(`landing-pages-extracted`) also carries a `ping` URL per landing page.

Add either area as a **header/footer** on a Search-API-backed view.

## Field: `search_api` (override)

Class `Plugin\views\field\SearchApiFusionStandard` re-registers the Views field plugin id **`search_api`** —
the same id as `search_api`'s own `SearchApiStandard` — extending it only to append the `ping` attribute (the
click-signal URL set by the event subscriber) to each item link's URL. Because it reuses the id it overrides
the standard handler for Search API views.

## Theme hooks

| Theme | Template | Variables |
|---|---|---|
| `search_api_fusion_spellcheck` | `templates/search-api-fusion-spellcheck.html.twig` | `label`, `link` |
| `search_api_fusion_landing_pages` | `templates/search-api-fusion-landing-pages.html.twig` | `landing_pages` |
