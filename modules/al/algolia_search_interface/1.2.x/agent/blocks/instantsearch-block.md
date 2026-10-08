<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Instant Search Block, template & front-end library

## Block plugin
`src/Plugin/Block/InstantSearchBlock.php` — annotated `@Block(id = "instantsearch_block", admin_label =
"Instant Search Block", category = "Instant Search Block")`, extends `BlockBase`. `build()` returns:
```
[ '#theme' => 'instantsearchblock',
  '#attached' => [ 'library' => 'algolia_search_interface/algolia-javascript' ] ]
```
No block config form, no access override — place it via *Structure › Block layout* and use core block
visibility for placement. It carries no cacheability metadata of its own (the interactive UI is client-side).

## Theme template
`templates/instantsearchblock.html.twig` (registered by `hook_theme` → `instantsearchblock`):
```
<div class="instantsearch">
  <div id="searchbox" class="angolia-searchbox"></div>
  <div id="hits"></div>
  <div id="pagination"></div>
</div>
```
The three container IDs (`#searchbox`, `#hits`, `#pagination`) are the mount points the JS binds to. Override
the template in a theme to change markup, but keep the IDs (or fork the JS too). Note the IDs are page-global,
so only one block instance is meaningful per page.

## Library
`algolia_search_interface.libraries.yml`, library `algolia-javascript`:
- JS (external, CDN jsdelivr): `algoliasearch@4/dist/algoliasearch-lite.umd.js`, `instantsearch.js@4`; then
  local `js/algolia.js` (`preprocess: false`).
- CSS (external, CDN): `instantsearch.css@7/themes/algolia-min.css`.
- `dependencies: [ core/drupalSettings ]`.

## Front-end wiring (`js/algolia.js`)
Reads `drupalSettings.algolia.config` (`indexname`, `appId`, `apiKey`, `template`, `pagination`). If
`indexname && appId && apiKey && template` are all present it:
1. `const search = instantsearch({ indexName: indexname, searchClient: algoliasearch(appId, apiKey) })`.
2. Adds two widgets: `searchBox` (container `#searchbox`) and `hits` (container `#hits`) with
   `templates: { item: template }` — each Algolia hit is rendered through the admin-configured template.
3. If `pagination` is truthy and `!= 0`, adds `pagination` widget (container `#pagination`). Page size is set
   in the Algolia dashboard, not here.
4. `search.start()`. If any required setting is missing it `throw "Algolia settings missing"`.

## Extending
- Add widgets (refinementList, sortBy, stats, configure) by overriding/replacing the `algolia-javascript`
  library with your own JS that reads the same `drupalSettings.algolia.config`.
- The hit `template` uses Mustache/Hogan syntax; `{{attribute}}` maps to fields in your Algolia records, and
  `{{#helpers.highlight}}{ "attribute": "name" }{{/helpers.highlight}}` renders Algolia highlighting.
