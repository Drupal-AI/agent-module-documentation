<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FAPI Collapsible (fapi_collapsible) — agent index

Provides ONE custom Form API render element, **`#type => 'collapsible'`** — a fieldset-like
container whose body can be expanded/collapsed, driven by a Twig template + jQuery behavior instead
of core's `details`. Package `Fields`. License GPL-2.0-or-later. Version 2.0.x (from `2.0.3`).
Core `^8 || ^9 || ^10 || ^11`. Used purely from PHP/Twig by developers — no admin UI.

## Dependencies

- Core only. Asset library `fapi_collapsible/collapsible` depends on `core/jquery`,
  `core/jquery.once`, `core/drupal`. No Composer requirements, no module dependencies.
- Optional companion: **Entity List** (`drupal/entity_list`) — render filters as collapsibles.

## What it provides (from source)

- **One render element**: `Drupal\fapi_collapsible\Element\Collapsible` (`@RenderElement("collapsible")`,
  `src/Element/Collapsible.php`), extending core `Fieldset`. `getInfo()` adds `#theme_wrappers =
  ['collapsible']`, a process callback `processCollapsible()`, and defaults `#expanded = FALSE`,
  `#name = 'field'`, `#id_collapsible = ''`, `#description = ''`, `#description_attributes = []`.
  `processCollapsible()` attaches the `fapi_collapsible/collapsible` library.
  → [elements/collapsible.md](elements/collapsible.md)
- **One theme hook** `collapsible` (`fapi_collapsible_theme()` in `.module`, render element `element`)
  with template `templates/collapsible.html.twig`, plus `fapi_collapsible_preprocess_collapsible()`
  mapping `#children/#name/#title/#id_collapsible/#expanded/#description/#description_attributes`
  into variables and computing `close = !#expanded`. → [elements/collapsible.md](elements/collapsible.md)
- **One asset library** `collapsible` (`fapi_collapsible.libraries.yml`) = `js/collapsible.js`, a
  `Drupal.behaviors.collapsible` jQuery toggle. → [elements/collapsible.md](elements/collapsible.md)

## What it does NOT provide

No routes, controllers, permissions, forms, services, entities, config objects, **no config schema**,
no `config/install`, no `.install`, no Drush, no plugin types, no submodules. `configure` is null —
there is nothing to configure; the element is used from code. No external HTTP calls or credentials.

## Install / operate

1. `composer require drupal/fapi_collapsible` then `drush en fapi_collapsible -y`.
2. In a form/render array set `'#type' => 'collapsible'`, add `#title`, optionally `#expanded`,
   `#description`, `#name`, `#id_collapsible`, and nest child elements under it.
3. Optionally override the `collapsible` template in your theme; drive accordion/auto-close behavior
   with the `data-collapsible-rel` / `data-collapsible-close` attributes (see the solution doc).
