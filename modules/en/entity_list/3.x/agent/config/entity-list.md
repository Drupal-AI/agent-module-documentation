<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entity, handlers, routes, permissions

## The `entity_list` config entity

`src/Entity/EntityList.php` — `@ConfigEntityType(id="entity_list")`, `config_prefix="entity_list"`,
`admin_permission="administer entity list"`. Interface `EntityListInterface`.

- `config_export`: `id`, `label`, `query`, `display`, `filter`, `sortableFilter`, `step`.
- `entity_keys`: `id`, `label`, `uuid`.
- Handlers: `view_builder` = `EntityListViewBuilder`, `list_builder` = `EntityListListBuilder`,
  forms `add`/`edit` = `Form\EntityListForm`, `delete` = `Form\EntityListDeleteForm`,
  `route_provider["html"]` = `EntityListHtmlRouteProvider`, `access` =
  `Access\EntityListAccessControlHandler`.
- `links`: canonical `/admin/structure/entity_list/{entity_list}`, add
  `/admin/structure/entity_list/add`, edit `.../{entity_list}/edit`, delete `.../{entity_list}/delete`,
  collection `/admin/structure/entity_list`.

Key methods:
- `getEntityListQueryPluginId($default='')` / `getEntityListQueryPlugin($default='')` — read
  `query.plugin` and instantiate via `plugin.manager.entity_list_query` with `['entity'=>$this,
  'settings'=>$this->get('query')]`.
- `getEntityListDisplayPluginId()` / `getEntityListDisplayPlugin()` — same for `display.plugin` via
  `plugin.manager.entity_list_display`.
- `setHost()/getHost()` — a non-persisted runtime host entity used by the contextual query
  (set by the reference field formatter).
- `setStep()/getStep()` — the creation wizard step; `getEntityListIndex()` locates the config name.

The stored config is: `query` (a mapping — plugin id + query settings), `display` (plugin id +
layout/layout_items settings), `filter` and `sortableFilter` (exposed/contextual filter layouts),
and `step`.

## Config schema

`config/schema/entity_list.schema.yml` — type `entity_list.entity_list.*` (`config_entity`) with
`id`, `label`, `step`, `uuid`, and open `mapping` types for `query`, `display`, `filter`. (The
`sortableFilter` key from `config_export` is not separately typed in the shipped schema.)

## Handlers

- `EntityListListBuilder` — admin collection list builder (`src/EntityListListBuilder.php`).
- `EntityListHtmlRouteProvider` extends core `AdminHtmlRouteProvider`; it returns the parent's
  routes unchanged, so canonical/add/edit/delete/collection routes are the standard admin entity
  routes gated by `_entity_access`/`admin_permission`.
- `Form\EntityListForm` builds the multi-step wizard (query → display → extra tabs); `EntityListDeleteForm`
  is the standard delete confirm form.

## Access & permissions

`entity_list.permissions.yml` defines two permissions:
- `view entity list` — view a list.
- `administer entity list` — build/administer lists (the entity `admin_permission`).

`Access\EntityListAccessControlHandler::checkAccess()`: for the `view` operation returns
`parent::checkAccess()` OR-ed with `allowedIfHasPermission('view entity list')`; for any other
operation OR-ed with `allowedIfHasPermission('administer entity list')`.

`entity_list.install` — `hook_install()` grants **`view entity list` to the Anonymous and
Authenticated roles by default** (so newly created lists are viewable by everyone unless the grant
is revoked). `hook_update_8001()` sets `step = finish` on all existing `entity_list.*` configs.

## Filter management routes

`entity_list.routing.yml` (all require `_permission: 'administer entity list'`), handled by
`Controller\EntityListFilterController`:
- `entity_list.filters_list` `/admin/entity_list/filters/list` → `listEntityListFilter()` (AJAX
  table of addable filters, driven by query params `type`, `bundles`, `entity_type_id`, `filters_used`…).
- `entity_list.filters_add` `/admin/entity_list/filters/add` → `addFilter()` (returns the
  `EntityListFilterParametersForm`).
- `entity_list.filters_remove` `/admin/entity_list/filters/remove` → `removeFilter()` (loads the
  list, unsets the chosen `filters_exposed`/`sortable_filters_exposed` layout item, saves, redirects).

Menu/action links: `entity_list.links.menu.yml` (collection + add under *Structure*),
`entity_list.links.action.yml` (Add action on the collection).
