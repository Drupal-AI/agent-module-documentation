<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Edit Content Type Tab (edit_content_type_tab) — agent index

Adds a local task **tab on node canonical pages** that redirects to that node's **content type
edit form** (`/admin/structure/types/manage/{type}`). Package `Development`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.2.x (the 8.x-2.x branch). **No dependencies**
beyond Drupal core; no config, no permissions of its own, no schema, no submodules, no Drush.

- **The route, controller, local task, service, and access gating** →
  [routes/tab.md](routes/tab.md)

## What it actually is (verified in source)

- **One route** `edit_content_type_tab.editor` (`edit_content_type_tab.routing.yml`):
  path `/node/{node}/edit_content_type_tab`, controller
  `EditController::editLink` (`src/Controller/EditController.php`), requirement
  `_permission: 'administer content types'`.
- **One local task** `edit_content_type_tab.editor` (`edit_content_type_tab.links.task.yml`):
  `base_route: entity.node.canonical`, weight 15, dynamic title via plugin class
  `EditTab` (`src/Plugin/Menu/EditTab.php`) → label `Edit '<Type Name>' type`.
- **One service** `edit_content_type_tab.request_service` → class `RequestService`
  (`src/RequestService.php`), a trivial request getter/setter used by `EditTab` to read the
  `node` route attribute.

## Mechanism

- `editLink(int $node)` loads the node with `entityTypeManager()->getStorage('node')->load($node)`,
  reads `$loadedNode->getType()`, builds `Url::fromUri('base://admin/structure/types/manage/' . $type)`,
  adds `?destination=node/{nid}`, and returns a `RedirectResponse`.
- It is a **navigation shortcut only**: it redirects to the core content-type management form. It
  does **not** re-bundle/convert the node and writes no data.

## Access & security posture

- Route + tab are gated by the core **`administer content types`** permission — the same permission
  core requires for the `/admin/structure/types/manage/{type}` form the tab links to. Only site
  builders/admins see or reach it. No config to harden.
