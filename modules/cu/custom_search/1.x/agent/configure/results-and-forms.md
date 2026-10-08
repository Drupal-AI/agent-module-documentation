# Customizing core search results & forms

Besides the block, Custom Search alters the **core Search** settings and results pages via
`hook_form_alter()` and seeds per-search-page settings at install.

## Per-search-page results config

On install (`custom_search_install()`), for every core `node_search` search page the module
writes an entry into the config object **`custom_search.settings.results`**, keyed by the
**search page id** (e.g. `node_search`). Each entry controls:

- `path` — the search page path.
- `search` (bool) — show the search form on the results page.
- `advanced` — the advanced/refine form: `visibility`, `collapsible`, `collapsed`, allowed
  `types` (content types), `criteria`, `languages`.
- `info` — which per-result info (author, type, date, …) is displayed.
- `filter` — a results filter: `position`, `label`, `any` text.

Inspect/edit it with drush:

```
drush config:get custom_search.settings.results
drush config:get custom_search.settings.results node_search
```

New content types and languages are auto-added to these settings via
`hook_entity_bundle_create()` / `hook_configurable_language_create()`.

## Where you configure it in the UI

There is **no dedicated module settings route** (`configure` is null). The options are injected
into the existing **Search pages** settings form (Configuration → Search and metadata → Search
pages → edit a page) by `custom_search_form_alter()`, and into the search block form. So to
change the advanced form, allowed types, displayed info, etc., edit the relevant **search
page**.

## Search API

If you use Search API, a custom search block (or search page settings) can target a **Search
API page** (`searchapi.page` in the block settings) so the query runs against Search API
instead of core search.

## Notes

- The module provides templates + a CSS/JS library for an optional popup search box.
- It defines config schema but no permissions and no Drush commands.
