<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flag Block (flag_block) — agent index

Renders a **Flag module flag/unflag link as a block** for the content entity on the current route.
Version **2.0.1**. License GPL-2.0-or-later. Core requirement `^8.8 || ^9 || ^10 || ^11`.
Depends on core **`block`** and contrib **`flag`** (this doc is about flag_block, not Flag core).

- **The one block plugin — settings, render logic, entity resolution, how to place it** →
  [plugins/flag_block.md](plugins/flag_block.md)

## What it actually is

- One block plugin: `FlagBlock` (id **`flag_block`**, admin label *"Flag block"*, category *"Flag"*),
  in `src/Plugin/Block/FlagBlock.php`, extending core `BlockBase` and implementing
  `ContainerFactoryPluginInterface`.
- `flag_block.module` is **empty** (no hooks). No routes, no permissions, no services of its own,
  no Drush, no config schema/install files, no submodules. The whole module is the one block class.
- It does **not** implement its own flag/unflag action; it delegates to Flag core's
  `flag.link_builder` service, so the link keeps Flag's access model and CSRF-protected flow.

## Mechanism (from source)

- Injects `flag` (`FlagServiceInterface`), `flag.link_builder` (`FlagLinkBuilderInterface`) and
  `current_route_match`.
- `blockForm()` — a required **select** `flag_block_settings` populated from
  `flag->getAllFlags()`, plus an optional **`view_mode`** textfield. `blockSubmit()` saves both to
  block config.
- `build()` — resolves the route entity via `getRouteEntity()`; if `checkBlockRender()` passes,
  calls `flagLinkBuilder->build(flaggableEntityTypeId, entity->id(), flagId, viewMode)` and returns
  `['flag' => $build]`; returns **NULL** (no output) when there is no matching entity.
- `checkBlockRender()` returns FALSE unless the flag's **flaggable entity type** equals the route
  entity's type, and (when the flag has bundles) the entity's bundle is in the flag's bundles.
- `getRouteEntity()` scans the route's `parameters` option for one typed `entity:*`, and returns it
  only if it is a `ContentEntityInterface` with a **`canonical`** link template.
- `getCacheMaxAge()` returns **0** — the block is not cached (reflects live per-user flag state).

## Configuration (block plugin config, no dedicated form)

Configured per block placement on **Block layout** (`/admin/structure/block`): `flag_block_settings`
(the chosen flag id) and `view_mode` (optional Flag view mode). No module settings route
(`configure` is null). Details in [plugins/flag_block.md](plugins/flag_block.md).
