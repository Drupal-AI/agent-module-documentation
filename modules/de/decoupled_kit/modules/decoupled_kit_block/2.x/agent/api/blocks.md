<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks JSON:API resource

Class `Drupal\decoupled_kit_block\Resource\Blocks` (extends `jsonapi_resources`
`EntityResourceBase`, implements `ContainerInjectionInterface`). Route `decoupled_kit.block`
(`decoupled_kit_block.routing.yml`):

```yaml
decoupled_kit.block:
  path: '%jsonapi%/decoupled_kit/blocks'
  defaults:
    _jsonapi_resource: Drupal\decoupled_kit_block\Resource\Blocks
    _jsonapi_resource_types: ['block--block']
  requirements:
    _access: 'TRUE'
```

Constructor injects `decoupled_kit`, `theme.manager`, `path.matcher`, `breadcrumb`, `current_user`.

## Request contract

- `current_path` (required, via `decoupledKit->checkPath()`); `/` is mapped to `<front>`.
- `current_theme` (optional; defaults to the active theme's name).
- `selected_regions` (optional, comma-separated region machine names; intersected with the theme's
  visible regions).

Region list comes from `theme_handler->getTheme($theme)->listVisibleRegions()`
(`DeprecationHelper::backwardsCompatibleCall` falls back to `system_region_list()` before 11.4).

## Processing (`process()` → `getBlocks()`)

1. For each visible region, query `block` config entities with `accessCheck(TRUE)`,
   `theme = $theme`, `region = $region`, `status = 1`, sorted by `weight`; load and merge them.
2. Filter each block through `blockVisibleForPage()`, which re-implements the standard visibility
   conditions:
   - **request_path** — `pathMatcher->matchPath()` against `pages`, honoring `negate`.
   - **user_role** — intersection of the condition's `roles` with `currentUser->getRoles()`,
     honoring `negate`.
   - **node_type / entity_bundle:node** — resolves the path's entity via the base service and
     checks `getType()` against `bundles`, honoring `negate`.
   All three must pass.
3. For the `system_breadcrumb_block`, it computes the page breadcrumb with `getBreadcrumb($path)`
   and stores it under a `breadcrumb` key inside that block's `settings`.
4. Before responding, `process()` clones each block and clears `visibility` (`set('visibility', [])`)
   so visibility metadata is not exposed, then returns
   `createCollectionDataFromEntities($clean_blocks, TRUE)` as the JSON:API collection.

## `getBreadcrumb($path)`

Uses `decoupledKit->getRouteMatchFromPath()` + `breadcrumbManager->build()`. Because breadcrumbs
built inside a JSON:API request contain a stray "Jsonapi" link, it locates that link and rebuilds
the list (drops everything up to/including it, re-orders, keeps the root), then maps each link to
`['text' => ..., 'url' => ...->toString()]`.

## Breadcrumb-alter hook

`Drupal\decoupled_kit_block\Resolver\BreadcrumbAlter::alterBreadcrumb()` (invoked from
`hook_system_breadcrumb_alter`) only acts when the current breadcrumb contains a "Jsonapi" link. It
walks up the path segments, resolves each parent to an entity/view via the base service, derives a
title (`entity.*` → entity label; `view.*.*` → the view's title when `access()` allows), and adds
those links to the breadcrumb.

## Operating it

```bash
curl 'https://SITE/jsonapi/decoupled_kit/blocks?current_path=/about&current_theme=olivero&selected_regions=header,content'
```

Returns a `block--block` JSON:API collection of the blocks that would render on that page, in region
+ weight order, with the breadcrumb attached to the system breadcrumb block.
