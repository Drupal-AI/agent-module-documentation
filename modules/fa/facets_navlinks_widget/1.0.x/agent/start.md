<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Navigation Links Widget (facets_navlinks_widget) — agent index

Registers one **Facets widget plugin**, `navlinks` ("List of navigation links"), that renders a facet's
results as a list of real navigation links wrapped in `<nav>`, with an optional reset ("Show all") link.
Unlike Facets core's "List of links" widget (active link toggles/clears itself), this keeps the active
item as a followable link. Package `Search`. License GPL-2.0-or-later. Version 1.0.1. Core `^10.1 || ^11`.

## Dependencies

- `facets:facets` — provides the `@FacetsWidget` plugin type, `WidgetPluginBase`, `Result`, the URL
  processor manager (`plugin.manager.facets.url_processor`), the URL generator
  (`facets.utility.url_generator`), and `facets_preprocess_facets_item_list()`. Composer
  `drupal/facets:^3.0`.

## What it provides (from source)

- **One facets widget plugin**: `Drupal\facets_navlinks_widget\Plugin\facets\widget\NavLinksWidget`
  (id `navlinks`, label *List of navigation links*), extending Facets' `WidgetPluginBase`. Adds three
  per-facet config keys (`show_reset_link`, `reset_text`, `hide_reset_when_no_selection`) and a reset
  link. → [plugins/navlinks-widget.md](plugins/navlinks-widget.md)
- **Two theme hooks** (`facets_navlinks_widget.module`, `hook_theme()`): `facets_item_list_navlinks`
  and `facets_result_item_navlinks`, each with a shipped Twig template under `templates/`. Preprocess
  delegates to Facets' `facets_preprocess_facets_item_list()`. → [theming/templates.md](theming/templates.md)
- **hook_help** for `help.page.facets_navlinks_widget` (static About text).

## What it does NOT provide

No routes, controllers, permissions, forms of its own, services, config objects, **config schema**,
`config/install`, entities, libraries or Drush. `configure` is null — the widget is chosen and configured
per facet on the standard Facets edit form (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`); the three settings live inside each facet config entity's `widget.config`.
Purely a display widget with no access-control role.

## Install / operate

1. `composer require drupal/facets_navlinks_widget` (pulls `drupal/facets`).
2. `drush en facets_navlinks_widget -y`.
3. Edit a facet, set its **Widget** to *List of navigation links*, optionally enable the reset link and
   set its text, save, and place/verify the facet block.
