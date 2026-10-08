<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Kit Block (decoupled_kit_block) — agent index

Submodule of **Decoupled Kit**. Adds a JSON:API resource that returns the blocks (plus breadcrumb)
that would render for a given front-end path/theme/regions. Package **Decoupled Kit**. Version
**2.0.7** (doc dir `2.x`). Core `^10 || ^11 || ^12`. GPL-2.0-or-later.

- **Dependencies:** `decoupled_kit` (base service), core `block`.
- **Parent project:** [decoupled_kit](../../../2.x/agent/start.md).

## What it provides

- **JSON:API resource** `Drupal\decoupled_kit_block\Resource\Blocks` (extends `jsonapi_resources`
  `EntityResourceBase`). Route `decoupled_kit.block` at `%jsonapi%/decoupled_kit/blocks`
  (GET, `_access: TRUE`, `_jsonapi_resource_types: ['block--block']`). See
  [api/blocks.md](api/blocks.md).
- **Hooks** via `Drupal\decoupled_kit_block\Hook\DecoupledKitBlockHooks` (autowired service):
  - `help` (attribute + `#[LegacyHook]` wrapper).
  - `system_breadcrumb_alter` → delegates to
    `Drupal\decoupled_kit_block\Resolver\BreadcrumbAlter::alterBreadcrumb()`, which rebuilds a
    breadcrumb trail when the current breadcrumb contains a stray "Jsonapi" link (i.e. it was built
    during a JSON:API request), walking parent paths via the base `decoupled_kit` service.
- No config, no schema, no permissions, no Drush, no plugin types.

## Solution docs

- [api/blocks.md](api/blocks.md) — the Blocks resource: request contract, visibility filtering,
  breadcrumb injection, response shape, and the breadcrumb-alter hook.
