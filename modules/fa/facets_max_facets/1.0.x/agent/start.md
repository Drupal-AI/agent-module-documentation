<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Max Facets (facets_max_facets) — agent index

**Enforces a site-wide maximum number of active facets** in Search API faceted search, with per-facet opt-in.
Once a request already carries the maximum number of active facet selections, the processor stops offering new
facet options (keeping only branches that lead to active selections so filters can still be removed) and shows a
configurable warning message. Package `Search`. License GPL-2.0-or-later. Version **1.0.0-beta1** (pre-release).
Core `^10 || ^11`.

## Dependencies

- `facets:facets` — provides the `FacetsProcessor` plugin type, `FacetInterface`, `ResultInterface`,
  `ProcessorPluginBase` and `BuildProcessorInterface` that this module extends. No `composer.json` ships;
  the dependency is declared in `facets_max_facets.info.yml`.

## What it provides (from source)

- **One Facets processor**: `Drupal\facets_max_facets\Plugin\facets\processor\RespectGlobalMaxFacets`
  (id `respect_global_max_facets`, build stage, weight 100). Caps displayed facets per request.
  → [plugins/respect-global-max-facets.md](plugins/respect-global-max-facets.md)
- **One settings form + route**: `Drupal\facets_max_facets\Form\SettingsForm` at
  `facets_max_facets.settings` (`/admin/config/search/facets/max-facets`), gated by `administer facets`.
  Edits the `facets_max_facets.settings` config object. → [config/settings.md](config/settings.md)
- **Config**: `config/install/facets_max_facets.settings.yml` (defaults `max_active_facets: 5`,
  a default `limit_message`) + `config/schema/facets_max_facets.schema.yml`.
- **Admin menu link**: `facets_max_facets.settings` under `system.admin_config_search`
  (`facets_max_facets.links.menu.yml`).

## What it does NOT provide

No permissions of its own (reuses core Facets' `administer facets`), no Drush, no services, no entities,
no controllers, no plugin types, no libraries, no `.module`/`.install` files, no HTTP/external-API calls.

## Install / operate

1. `composer require drupal/facets_max_facets` (pulls `drupal/facets`), then `drush en facets_max_facets -y`.
2. At `/admin/config/search/facets/max-facets` set **Maximum active facets** (0 = disabled) and the message.
3. On each facet's edit form, enable the **Respect global max facets** processor to opt that facet into the cap.
