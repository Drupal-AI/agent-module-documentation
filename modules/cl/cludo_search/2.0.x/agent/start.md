<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cludo Search (cludo_search) — agent index

A **client-side** integration of the [Cludo](https://www.cludo.com/) hosted (SaaS) site-search
widget. The module does **not** query Cludo from the server — it renders a search form and empty
result containers, pushes two **public** identifiers (`customerId`, `engineId`) into
`drupalSettings`, and loads Cludo's browser JS bundle, which does all searching and result
rendering in the visitor's browser. There is **no private API key** in this module. Version
**2.0.0**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Package `Cludo Search`.
(Community project; not sponsored or supported by Cludo.)

> Note: this module has **no server-side Cludo API call, no private credential, and no local search
> index**. Earlier descriptions calling `customerId`/`engineId` "API credentials to store as
> secrets" are inaccurate — both are public widget IDs that appear in page source by design.

## Dependencies

- Drupal modules: **none** beyond core (`.info.yml` lists no `dependencies`). Attaches
  `core/jquery` + `core/drupalSettings` via its library.
- No Composer requirements (no `composer.json`), no PHP library.
- Runtime: loads Cludo's external CSS/JS from `customer.cludo.com` / `api.cludo.com` in the browser.

## What it provides (from source)

- **Settings form** `SettingsForm` (`cludo_search_config_settings`) at
  `/admin/config/search/cludo_search/settings` — stores `cludo_search.settings` config: `customerId`,
  `engineId`, `search_page` (path), and four display toggles. Route `cludo_search.settings`
  (`_permission: administer cludo search`).
- **Search page form** `CludoSearch` (`cludo_search_search_form`) at route `cludo_search.search`
  (default path `/csearch`, `_permission: access cludo search content`) — renders the full search
  form + empty result containers and attaches the Cludo library + `drupalSettings`.
- **Block** `cludo_search` (`Plugin/Block/CludoSearchBlock`, category "Cludo Search") rendering
  `CludoSearchBlockForm` (`cludo_search_block_search_form`) — a placeable search-input block that
  redirects to the search page with the typed query in a URL fragment (`?cludoquery=…`).
- **RouteSubscriber** (`cludo_search.route_subscriber`, service arg `@config.factory`) — dynamically
  re-paths `cludo_search.search` from `/csearch` to the configured `search_page`.
- **Library** `cludo_search/cludo-customer` (`.libraries.yml`) — Cludo's external `cludo-search.min.css`
  + `search-script.min.js` (+ legacy IE9 `xdomain.js`) plus local `js/cludo_search.js` / `css/cludo_search.css`.
- **Theme hooks / templates** — `cludo_search_search_form`, `cludo_search_block_form`,
  `cludo_search_results`, `cludo_search_result` (4 Twig templates). The results-page templates emit
  empty `<div>` scaffolding that Cludo's JS fills.
- **Permissions** (`.permissions.yml`): `administer cludo search` (restrict access TRUE),
  `access cludo search content` (restrict access FALSE — grantable to anonymous, intentional for a
  public search page). **Menu link** `cludo_search.settings`. **`hook_help`** for the help/settings pages.
- No `.install`, no update hooks, no Drush commands, no config schema file shipped (config is
  free-form via the settings form).

## How the pieces connect

1. Admin enters `customerId` / `engineId` / `search_page` in `SettingsForm`; `RouteSubscriber` moves
   the search route to `search_page` on config save (`router.builder` rebuild).
2. A visitor uses the block form (anywhere) or the search-page form; the block form redirects to the
   search page with `#?cludoquery=<terms>`.
3. On the search page, the module attaches `cludo_search/cludo-customer` and writes
   `drupalSettings.cludo_search.cludo_searchJS = {customerId, engineId, searchUrl, …toggles}`.
4. `js/cludo_search.js` reads those settings, constructs `new Cludo(cludoSettings)` and calls
   `.init()` — from here Cludo's browser script performs the query against Cludo's API and injects
   results into the `.search-results` / `.search-result-count` / `.search-did-you-mean` divs.

## Solution docs

- **Settings form, config keys & defaults, dynamic route re-pathing** → [config/settings.md](config/settings.md)
- **Search forms, block, `drupalSettings` payload, the Cludo JS handoff, templates** →
  [search/integration.md](search/integration.md)
