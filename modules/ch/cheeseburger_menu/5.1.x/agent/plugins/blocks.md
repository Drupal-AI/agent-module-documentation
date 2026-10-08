<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Plugins provided

The module defines no new plugin *type* / manager. It implements existing core plugin types:

## Block plugins
- **`cheeseburger_menu`** — `src/Plugin/Block/CheeseburgerMenuBlock.php`, category "Menus".
  `build()` loops `settings['menus']`, calling `CheeseburgerMenuService::buildMenu()` for
  `menu_type: menu` and `::buildMenuFromVocabulary()` for `menu_type: taxonomy_vocabulary`,
  producing a `#theme => 'cheeseburger_menu'` render array. Attaches
  `cheeseburger_menu/cheeseburger_menu.css` / `.js` when `default_css` / `default_js` are on.
  Adds cache tags `cheeseburger_<menu_type>:<id>` (+ `config:system.menu.<id>` or
  `taxonomy_term_list:<id>`) and, when `track_active_trail` is on, cache contexts
  `route.menu_active_trails:<id>` / `route.taxonomy_term_tree:<id>`. Implements
  `calculateDependencies()`/`onDependencyRemoval()` so placed menus/vocabs become config deps.
- **`cheeseburger_menu_trigger`** — `src/Plugin/Block/CheeseburgerMenuTrigger.php`. Renders the
  open/close button for a referenced menu block (`block_to_trigger`), optionally limited to
  `breakpoints` / `custom_media_query` (uses `breakpoint.manager` when present).

## Menu link plugin (language switch)
`cheeseburger_menu.links.menu.yml` defines `language_switch_links` using
`Plugin\Menu\LanguageSwitchMenuLink` with `Plugin\Deriver\LanguageSwitchLinksDeriver` — exposes
per-language switch links you can add into an aggregated menu.

## Cache context service
`cache_context.route.taxonomy_term_tree` (`src/Cache/TaxonomyTermTreeCacheContext.php`) — a
custom cache context keyed by the current route's taxonomy term tree, registered in
`cheeseburger_menu.services.yml` alongside `cheeseburger_menu.service`
(`CheeseburgerMenuService`, the tree-building service).

To render a menu programmatically, call the `cheeseburger_menu.service` methods
(`buildMenu()`, `buildMenuFromVocabulary()`) which return `CheeseburgerMenu` objects.
