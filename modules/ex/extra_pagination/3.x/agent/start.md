<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Pagination (extra_pagination) — agent index

Zero-config display module that **overrides the core `pager` theme hook** to add an extra set of "jump" page
links between the last visible page number and the final page (for SEO / reaching any page in 3-4 clicks).
Package **User Interface**. License GPL-2.0-or-later. Version **3.0.0** (version-dir `3.x`).
Core `^8.8 || ^9 || ^10 || ^11`.

## Dependencies

None. Only requires `drupal/core` (Composer `^8.8 || ^9 || ^10 || ^11`). No contrib module deps, no PHP
library, no library_dependencies.

## What it provides (from source)

- **`extra_pagination.module`** — three procedural hooks:
  - `extra_pagination_help()` (`hook_help`) — help text on `help.page.extra_pagination`.
  - `extra_pagination_theme_registry_alter()` — repoints the existing `pager` theme hook's `path` to this
    module's `templates/` dir, so its `pager.html.twig` renders every pager. It does **not** implement
    `hook_theme`; it overrides core's `pager` hook.
  - `extra_pagination_preprocess_pager()` (`template_preprocess_pager`) — rebuilds `variables['items']`
    (first/previous/numbered pages/next/last), `variables['ellipses']`, `variables['current']`, then appends
    the extra jump links via `pager_extra_pages()`.
- **`includes/pager.inc`** — `pager_extra_pages($pager_last, $pager_max, $route_parameters, $parameters, $element)`
  builds the extra items in base-10 intervals (widening after 10 steps).
- **`templates/pager.html.twig`** — the override template; adds an `items.extra` loop after `items.pages`.

Details → [theme/pager-override.md](theme/pager-override.md).

## What it does NOT provide

No routes, no controllers, no permissions, no forms, no settings form, no config objects, **no config schema**,
no `config/install`, no entities, no services, no plugins, no Drush, no JS/CSS libraries. `configure` is null.
It reads only the core pager render array (route, parameters, quantity) — no request-data sink, no outbound HTTP,
no credentials. No security-relevant surface of its own.

## Install / operate

1. `composer require drupal/extra_pagination`.
2. `drush en extra_pagination -y`, then `drush cr` (theme registry).
3. No configuration. Extra pager items appear automatically on paged listings with enough pages.
4. Uninstall to restore the core pager.
