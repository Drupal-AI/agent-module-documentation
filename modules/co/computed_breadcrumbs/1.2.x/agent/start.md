<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Computed Breadcrumbs (computed_breadcrumbs) — agent index

Adds a **computed `breadcrumbs` field to every content entity type**, so an entity's breadcrumb
trail can be read as data (JSON:API/REST, Views, code) instead of only appearing when a page is
rendered. Version **1.2.0**. Core `^10 || ^11`. Depends only on core **`link`**. License
GPL-2.0-or-later.

- **What the field is, how it is computed, and how to read it** →
  [api/computed-field.md](api/computed-field.md)
- **The settings form, config object, permission and route** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Base field**, not a plugin you attach: `computed_breadcrumbs_entity_base_field_info()`
  (`computed_breadcrumbs.module`) adds field `breadcrumbs` to every `ContentEntityTypeInterface`.
  Computed, unlimited cardinality, hidden by default, display-configurable on view.
- **Field type** `computed_breadcrumbs` — `Plugin/Field/FieldType/ComputedBreadcrumbsLinkItem`
  extends core `link`'s `LinkItem` (same constraints, `link_default` widget, `link` formatter).
  This is why the module depends on `link`.
- **Item list** `Field\ComputedBreadcrumbsItemList` (uses `ComputedItemListTrait`) does the work:
  it builds the trail on read via an **internal HTTP sub-request** to the entity's canonical path.
- **Event subscriber** `EventListener` (service `computed_breadcrumbs.event_listener`) swaps the
  controller of any request carrying a `computed_breadcrumbs` request attribute to
  `Controller\BreadcrumbsExtractor::extract`.
- `BreadcrumbsExtractor::extract()` asks the `breadcrumb` manager to build the trail for the
  current route and returns it inside a `Routing\BreadcrumbsResponse` (a plain `Response` holding
  the `Link[]`).
- Each resulting link becomes a link-field item `{uri, title}`; **absolute URLs by default**,
  relative when `computed_breadcrumbs.settings:use_relative_urls` is TRUE.

## Config / routes / permissions

- Config object **`computed_breadcrumbs.settings`** — one key `use_relative_urls` (bool, default
  FALSE). Schema in `config/schema/`, install default in `config/install/`.
- Settings form `Form\SettingsForm` at route **`computed_breadcrumbs.settings`**
  (`/admin/config/user-interface/computed-breadcrumbs`), menu link under *Configuration → User
  interface*, permission **`administer computed breadcrumbs`**.
- No Drush commands. No submodules. Provides the one field type and one config object.

## Read it in code

```php
$trail = $node->get('breadcrumbs')->getValue();
// => [['uri' => 'https://site/…', 'title' => '…'], …]
```
