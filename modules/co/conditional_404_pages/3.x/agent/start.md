<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditional 404 Pages (conditional_404_pages) — agent index

Serves **different custom 404 (page-not-found) bodies by requested path**. Each
`conditional_404_page` **config entity** maps a core **`request_path`** condition to a **node**;
on a 404 the highest-weight matching record's node is rendered (still HTTP 404), else it falls back
to core's `system.site:page.404`. Version **3.0.0** (doc dir `3.x`). Core `^10 || ^11`.
License GPL-2.0-or-later. Package **404 Pages**. No composer deps, no declared module deps
(uses core `node`, `path_alias`, `system` condition plugin at runtime).

- **Config entity, the swap mechanism, form, routes, permission, schema** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Config entity** `conditional_404_page` (`src/Entity/Conditional404Page.php`,
  `@ConfigEntityType`): `admin_permission = "administer conditional 404 page configuration"`,
  `config_prefix = "conditional_404_page"`, `entity_keys` include `weight`. Exported keys:
  `id, label, page, pathCondition, status, weight`. Getters/setters in
  `Conditional404PageInterface`. Route provider `Conditional404PageHtmlRouteProvider` (extends
  core `AdminHtmlRouteProvider`, no customisation). List builder `Conditional404PageListBuilder`.
- **Decorator subscriber** `EventSubscriber/ConditionalPageExceptionHtmlSubscriber` **decorates
  `exception.custom_page_html`** (priority 10, `conditional_404_pages.services.yml`), extending
  core `CustomPageExceptionHtmlSubscriber`. Overrides `on404()` only.
- **Service** `conditional_404_pages.conditional_404_page_service`
  (`Conditional404PageService`): `getApplicableConfigEntities()` and `getConditional404Path()`.
- **Permission** `administer conditional 404 page configuration`
  (`conditional_404_pages.permissions.yml`) — the only permission.
- **Config schema** `config/schema/conditional_404_page.schema.yml` — `pathCondition` typed as
  `condition.plugin.request_path`.
- **UI**: collection at `/admin/structure/conditional_404_page` (menu link under
  *Structure*, `configure` route `entity.conditional_404_page.collection`); add/edit/delete forms.
  No `.module`, no `.install`, no Drush, no hooks, no JS/CSS.

## Mechanism (on a 404)

1. `on404()` calls `service->getApplicableConfigEntities()`: `loadByProperties(['status'=>TRUE])`,
   then for each entity feeds `entity->getPathCondition()` into one core `request_path` condition
   instance and keeps those where `->evaluate()` is TRUE.
2. If any match, `getConditional404Path()` sorts them by `getWeight()` **descending**, takes the
   first, reads its `getPage()` (a node id) and returns `path_alias.manager->getAliasByPath(
   '/node/'.$nid)`.
3. `makeSubrequestToCustomPath($event, $path, HTTP_NOT_FOUND)` (inherited core method) renders that
   path as a sub-request with the 404 status — so the **node's own view access is enforced** by core.
4. If **no** enabled entities exist at all, it falls back to `system.site:page.404`.

## Security / access posture (public, non-sensitive)

Config UI is gated by `administer conditional 404 page configuration`; delete is a confirm form.
The target is an admin-chosen node id rendered via a normal internal sub-request (no request-derived
redirect or path). Nothing here is a user-supplied render/redirect target. Keep 404 bodies free of
diagnostic detail as usual.
