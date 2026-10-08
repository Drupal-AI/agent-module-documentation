<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search forms, block & the Cludo JS handoff

The module never talks to Cludo from PHP. It builds forms + empty containers, ships two public IDs
to the browser, and lets Cludo's JS bundle do the querying and rendering client-side.

## Search-page form — `CludoSearch` (`src/Form/CludoSearch.php`)

`FormBase`, form id `cludo_search_search_form`, served by route `cludo_search.search` (default
`/csearch`, re-pathed by `RouteSubscriber`; `_permission: access cludo search content`).

`buildForm()`:
- A `search_keys` textfield (+ prompt item + Search submit) in a `basic` container.
- `#theme = 'cludo_search_search_form'`, classes `search-form` / `search-cludo-search-search-form`.
- Attaches library `cludo_search/cludo-customer`.
- Builds `$search_url = \Drupal::request()->getSchemeAndHttpHost() . '/' . $settings['search_page']`
  and writes the **drupalSettings payload** (see below).

`submitForm()` is effectively **dead code** — it `urlencode()`s `search_keys` into a local variable
and never uses it (the actual search is driven by Cludo's JS reading the URL fragment / input).

## Block form — `CludoSearchBlockForm` (`src/Form/CludoSearchBlockForm.php`)

`FormBase`, form id `cludo_search_block_search_form`, `#theme = 'cludo_search_block_form'`. Just a
`search_keys` textfield + submit.

`submitForm()`:
- `unset($_GET['destination'])` so the redirect always lands on the search page.
- `urldecode()`s the typed terms, collects the current query string
  (`\Drupal::request()->query->all()`), builds `UrlHelper::buildQuery(['cludoquery' => $terms])`,
  and `setRedirect('cludo_search.search', [], ['query' => $query, 'fragment' => '?'.$cludo_fragment])`.
- Net effect: submitting the block form sends the visitor to the search page with the query in a
  fragment like `#?cludoquery=<terms>`; Cludo's JS reads it and runs the search.

## Block plugin — `CludoSearchBlock` (`src/Plugin/Block/CludoSearchBlock.php`)

`@Block(id = "cludo_search", admin_label = "Cludo Search block", category = "Cludo Search")`.
`build()` renders `CludoSearchBlockForm` via the form builder, attaches
`cludo_search/cludo-customer`, and adds the **same drupalSettings payload** so the widget works even
when the block is placed away from the search page.

## drupalSettings payload (shared by the search form and the block)

Both `CludoSearch::buildForm()` and `CludoSearchBlock::build()` write:

```php
$form['#attached']['drupalSettings']['cludo_search']['cludo_searchJS'] = [
  'customerId'          => $settings['customerId'],   // PUBLIC id
  'engineId'            => $settings['engineId'],      // PUBLIC id
  'searchUrl'           => $search_url,                // scheme+host + '/' + search_page
  'disableAutocomplete' => (bool) $settings['disable_autocomplete'],
  'hideResultsCount'    => (bool) $settings['hide_results_count'],
  'hideSearchDidYouMean'=> (bool) $settings['hide_did_you_mean'],
  'hideSearchFilters'   => (bool) $settings['hide_search_filters'],
];
```

These values appear in page source — that is expected: `customerId`/`engineId` are public widget
identifiers, and there is no private key involved.

## The Cludo JS handoff (`js/cludo_search.js`)

`Drupal.behaviors.CludoSearchBehavior.attach()` reads `drupalSettings.cludo_search.cludo_searchJS`,
adds `language: 'en'`, `type: 'inline'`, and `searchInputs: ['cludo-search-block-form',
'cludo-search-search-form', 'cludo-search-block-search-form']`, then
`CludoSearch = new Cludo(cludoSettings); CludoSearch.init();`. The `Cludo` constructor comes from
Cludo's external `search-script.min.js` (loaded by the library). From here all querying and result
rendering happens in the browser, against Cludo's API.

## Library (`cludo_search.libraries.yml`)

`cludo-customer` library:
- CSS: external `//customer.cludo.com/css/templates/v1.1/essentials/cludo-search.min.css` + local
  `css/cludo_search.css`.
- JS: legacy `//api.cludo.com/scripts/xdomain.js` (IE ≤ 9 CORS shim only), external
  `//customer.cludo.com/scripts/bundles/search-script.min.js`, local `js/cludo_search.js`.
- Dependencies: `core/jquery`, `core/drupalSettings`.

Protocol-relative `//` URLs mean the **browser** loads these over the page's scheme (HTTPS in
practice) — no server-side fetch, no TLS handling in module PHP.

## Templates & theme hooks (`cludo_search.module` `hook_theme` + `templates/`)

- `cludo-search-search-form.html.twig` / `cludo-search-block-form.html.twig` — render `{{ form }}`
  plus the empty result scaffold (`.search-result-count`, `.search-did-you-mean`, `.search-results`)
  that Cludo's JS populates. Their preprocessors (`template_preprocess_cludo_search_search_form` /
  `_block_form`) split the form's child elements into template variables.
- `cludo-search-results.html.twig` / `cludo-search-result.html.twig` and
  `template_preprocess_cludo_search_result()` are **legacy/dead** — leftovers from an old
  server-side result-rendering path that nothing in the current module invokes. The preprocessor
  still sanitizes (`Xss::filter($snippet/$title, ['b','strong'])`, `Html::escape($crawl_date)`),
  but no code path feeds it Cludo data today.
