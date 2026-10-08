<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Admin Pages (comment_admin_pages) — agent index

Renders the core comment **edit** and **delete** forms in the **admin theme** instead of the
front-end theme, giving moderators a consistent back-end experience. Depends only on core
`comment`. Package `Comment`. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Installed **1.0.2** (version dir `1.0.x`).

## What it provides (from source)

The whole module is one route subscriber. There are **no** custom routes, controllers, forms,
permissions, config schema, hooks, `.module`/`.install`, or `composer.json`.

- **`comment_admin_pages.services.yml`** registers `comment_admin_pages.route_subscriber`
  (`Drupal\comment_admin_pages\Routing\RouteSubscriber`, constructed with `@entity_type.manager`,
  tagged `event_subscriber`).
- **`src/Routing/RouteSubscriber.php`** extends `RouteSubscriberBase` and, on `RoutingEvents::ALTER`,
  calls `$route->setOption('_admin_route', TRUE)` for exactly two core routes:
  `entity.comment.edit_form` (`/comment/{comment}/edit`) and
  `entity.comment.delete_form` (`/comment/{comment}/delete`). It touches nothing else.

## Behaviour

`_admin_route` = TRUE causes Drupal core to render those pages with the site's configured admin
theme **for users who hold core's `view the administration theme` permission**; other users still
see the front-end theme. This is a presentation-only change — it does **not** alter who may edit or
delete a comment. Access to the forms remains entirely governed by core comment access
(`administer comments` / per-comment access); this module adds no access checks of its own.

## Docs

- Prose overview + use cases → [../usage.md](../usage.md) (also `usage.md` sibling)
- Human setup guide → [../human-docs/index.md](../human-docs/index.md)

No `agent/` subdocs — the entire configurable/API surface is the single route option above.
