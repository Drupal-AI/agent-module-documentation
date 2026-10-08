<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Entity Pager (custom_entity_pager) — agent index

Developer module that exposes a Twig function to render a previous/next pager
between published nodes of a content type. No Views, no UI, no config, no block —
one direct DB query and a Twig call. Core-only (uses the `node` module).

## Dependencies
- Drupal core `^9 || ^10 || ^11`. No contrib dependencies, no Composer requirements.

## What it provides
- Twig function `custom_entity_pager_insert($content_type, $field_order = '', $title = TRUE, $inner_text = NULL)`
  registered by `Drupal\custom_entity_pager\TwigExtensions\PaginatorExtension` (service
  `custom_entity_pager.paginator_extension`, tagged `twig.extension`).
- Service `custom_entity_pager.main_service` = `Drupal\custom_entity_pager\Services\CustomEntityPager`
  (args `@database`, `@language_manager`) — builds the ordered node list and picks prev/next.
- Two theme hooks via `custom_entity_pager_theme()`: `paginate` and `paginate_with_titles`
  (templates `templates/paginate.html.twig`, `templates/paginate-with-titles.html.twig`).
- No routes, no permissions, no config objects, no config schema, no Drush commands, no submodules.

## How it works (brief)
- `PaginatorExtension::customEntityPagerInsert()` reads the `node` route parameter; returns FALSE
  if there is no node in the current route. Otherwise calls the service and renders `#theme`
  `paginate` (or `paginate_with_titles` when `$title` is TRUE).
- `CustomEntityPager::getElements()` selects `nid, title, status` from `node_field_data`, filtered
  to `type = $content_type`, current `langcode`, and `status = TRUE` (published only); optionally
  joins `node__<field>` and orders by `<field>_value`, else orders by `nid` ASC.
- `CustomEntityPager::getNextAndPrev()` finds the current nid in the ordered keys and returns the
  neighbours; if the current node is absent it returns the first node as `next`.

## Solution docs
- [agent/api/twig-function.md](api/twig-function.md) — the Twig function, its arguments, and templates.
- [agent/api/service.md](api/service.md) — the `CustomEntityPager` service and its query/ordering logic.
