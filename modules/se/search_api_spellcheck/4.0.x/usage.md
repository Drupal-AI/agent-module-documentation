<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Spellcheck adds two Views **area** handlers that turn a search backend's spellcheck data into a Google-style "Did you mean:" link or a list of "keyword variations" on a Search API search page.

---

The module ships no configuration UI, no service, and no Drush command — it is purely two Views area plugins (`search_api_spellcheck_did_you_mean` and `search_api_spellcheck_suggestions`) that you drop into the **Header** or **Footer** of a Search API view. On the view's `query()` phase the handler checks that the query is a `SearchApiQuery` whose server `supportsFeature('search_api_spellcheck')` (Solr and any backend advertising that feature), and if so sets a `search_api_spellcheck` query option carrying the search keys plus `count` (max suggestions per term) and `collate` (let the backend build one corrected phrase). At render time it reads the `search_api_spellcheck` extra data off the result set: the "Did you mean" handler emits a single best-guess link (preferring the backend's `collation`, else swapping each mis-spelled token for its top suggestion), while the "Suggestions" handler enumerates the combinatorial keyword variations as a bulleted list of links. Each link re-runs the same view with the corrected phrase placed in the exposed fulltext filter's parameter. Output is themeable via the `search_api_spellcheck_did_you_mean` and `search_api_spellcheck_suggestions` theme hooks (templates `search-api-spellcheck-did-you-mean.html.twig` / `search-api-spellcheck-suggestions.html.twig`). Because everything hinges on backend-provided spellcheck data, the feature is inert on a backend (e.g. the core Database server) that does not support `search_api_spellcheck`.

---

- Show a Google-style "Did you mean: <corrected phrase>?" link above search results when a query looks mis-spelled.
- Offer a bulleted list of alternative keyword spellings ("Spellcheck keyword variations:") under a search results view.
- Correct a Solr-backed site search so "jawa class lording" suggests "java class loading".
- Add the "Did you mean" area to a Search API view's **Header** so it appears before the results.
- Add the "Suggestions" area to a Search API view's **Footer** to list variations after the results.
- Limit how many suggestions the backend returns per term via the `search_api_spellcheck_count` option.
- Only surface the "Did you mean" prompt when the view returns **no** results (the `search_api_spellcheck_hide_on_result` option).
- Always show the correction, even on non-empty result sets, by turning `hide_on_result` off.
- Use Solr's collation feature (`search_api_spellcheck_collate`) to build one corrected phrase instead of per-token swaps.
- Give each suggestion as a clickable link that re-runs the search with the corrected keywords pre-filled.
- Improve zero-result recovery on an e-commerce catalogue search so shoppers still find products.
- Reduce bounce on a knowledge-base search by proposing spellings when the query misses.
- Provide multilingual spellcheck suggestions from a Solr core configured with the right dictionary.
- Theme the "Did you mean" prompt with a custom Twig template to match a site's search UI.
- Wrap the suggestions list in custom markup by overriding `search-api-spellcheck-suggestions.html.twig`.
- Feed the corrected keywords back into an exposed `SearchApiFulltext` filter automatically.
- Add spellcheck to an existing Search API + Solr search page without writing any code.
- Combine both handlers on one view — a single best guess in the header and full variations in the footer.
- Keep the current page's other query parameters (facets, sort) intact when a user clicks a suggestion.
- Gate the correction UI behind Views access on the search display like any other area.
- Ship the spellcheck wiring as exported view config for repeatable deployment.
- Prototype spellcheck behaviour on a staging Solr index before enabling it in production.
- Detect an incompatible fulltext parse mode early (the handler throws if keys are not an array).
