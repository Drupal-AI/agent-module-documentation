<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Algolia Search Interface (algolia_search_interface) — agent index

Client-side **Algolia InstantSearch.js** search UI for Drupal, rendered as a placeable block. Version-dir
**1.2.x** (installed 1.2.0). Core `^10.1 || ^11 || ^12`. Package: Search. No Drupal module dependencies; no
composer.json. Requires an Algolia account (Application ID + Search-only API key). Does NOT index — pair with
`search_api_algolia` for indexing.

## What it provides
- **Route** `algolia.settings_form` → `/admin/algolia/configurations` (`_form: AlgoliaSettingsForm`), gated by
  permission `administer configurations`. Admin menu link under *Configuration › Search* (`links.menu.yml`).
- **Form** `Drupal\algolia_search_interface\Form\AlgoliaSettingsForm` (id `algoliasettings_form`) — fields
  `indexname`, `appId`, `apiKey`, `template`, `pagination`; saved to **Drupal State** key `algolia_settings`
  (NOT config — there is no config/install or config/schema).
- **Block plugin** `Drupal\algolia_search_interface\Plugin\Block\InstantSearchBlock` (id `instantsearch_block`,
  category "Instant Search Block") → renders theme `instantsearchblock` and attaches library
  `algolia_search_interface/algolia-javascript`.
- **Hook service** `Drupal\algolia_search_interface\Hook\AlgoliaSearchInterfaceHooks` (autowired, OOP
  `#[Hook]` + `#[LegacyHook]` shims in the `.module`): `hook_preprocess_html` attaches the State values to
  `drupalSettings.algolia.config.*` on every HTML page; `hook_theme` registers `instantsearchblock`.
- **Theme template** `templates/instantsearchblock.html.twig` — `#searchbox` / `#hits` / `#pagination` divs.
- **Library** `algolia-javascript` (`libraries.yml`): CDN `algoliasearch@4` + `instantsearch.js@4` + local
  `js/algolia.js`, CSS `instantsearch.css@7`; depends on `core/drupalSettings`.
- **Front-end** `js/algolia.js`: reads `drupalSettings.algolia.config`, builds `instantsearch()` with
  `algoliasearch(appId, apiKey)`, adds searchBox + hits (template as `item`) widgets, optional pagination.

## Solution docs
- [agent/config/settings.md](config/settings.md) — settings form, State storage, drupalSettings injection, keys.
- [agent/blocks/instantsearch-block.md](blocks/instantsearch-block.md) — block, template, library, JS widget wiring, overriding.

## Notes for agents
- Settings live in **State** (`\Drupal::state()->get('algolia_settings')`), not configuration — they do not
  export with `drush cex` and are not translatable. There is no `configure:` key in the `.info.yml`.
- The Algolia search client runs in the browser; enter the Algolia **Search-only (public) API key** in the
  `apiKey` field. Content visibility follows the Algolia index, not Drupal access.
- No PHP-side HTTP calls, no permissions defined by the module, no Drush commands.
