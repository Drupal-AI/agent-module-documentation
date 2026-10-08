<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entitylogic — developer API

## Plugin IDs
`entity_type` · `entity_type.bundle` · either with `:selector`. `selectPluginId()` tries most-specific → type+selector → `_fallback` selector.

## The `entitylogic()` function (`entitylogic.module`)
- `entitylogic()` → the `EntityLogicManager`.
- `entitylogic($entity, $selector=null)` → wrap an entity.
- `entitylogic('node.article', $id)` → load that ID and wrap.
- `entitylogic('node.article', [$id1,$id2])` → array of wrapped instances.
- `entitylogic('node.article', null)` → empty instance (no entity yet).

## Manager methods
- `wrapEntity($entity, $selector, $config, $fallback)` — UUID+plugin static-cached.
- `wrapEntityNoCache(...)` — uncached variant.
- `wrapNew($input, $values, …)` — create entity then wrap.
- `wrapEmpty($input, …)` — instance without an entity.
- `provideWrap($input, array $filter, …)` — get-or-create by field filter (query uses `accessCheck(FALSE)`; enforce access yourself).
- `getLogicClass($input, …)` — the resolved class name.
- `resetCache($entity=null)` — clear the static instance cache.

## Templates & Views
- Twig: `{{ entitylogic(node).myMethod() }}` (function registered by `EntityLogicTwigExtension`).
- Views: add the `MethodCall` field (`Plugin/views/field/MethodCall.php`) to render a logic method's return.

## Scaffolding
`drush generate` → choose the EntityLogic generator (`src/Generators/EntityLogicGenerator.php`, template `entitylogic.php.twig`).

## UI submodule
Enable `entitylogic_ui` for a read-only report of registered logic classes at `/admin/reports/entitylogic` (permission `entitylogic_ui view list`).
