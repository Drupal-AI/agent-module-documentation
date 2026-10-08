<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks: derived per-group menu blocks

`src/Plugin/Block/OgMenuBlock.php` (`@Block id="ogmenu_block"`, category "OG Menus") with deriver
`src/Plugin/Derivative/OgMenuBlock.php`.

## Derivation

`OgMenuBlock` (deriver) iterates every `ogmenu` config entity and produces one derivative block per
menu (`ogmenu:{menu_id}`), skipping any whose instances are not group content
(`Og::isGroupContent('ogmenu_instance', ...)`). Each derivative's admin label is the `ogmenu` label
and it carries a config dependency on that `ogmenu`.

## Context and rendering

- Context definition: `"og" = @ContextDefinition("entity", ...)` — the block requires an Organic
  Group entity in context, resolved by OG's context system (`OgContext`).
- `getOgMenuInstance()` loads the `ogmenu_instance` for `{derivative menu id + current group}` via
  `loadByProperties([type, OG audience field])`; returns NULL if none.
- `getMenuName()` → `ogmenu-{instance_id}`. `build()` loads that menu tree, runs core
  `checkAccess` + `generateIndexAndSort` manipulators, and renders it.
- If the group has **no** instance yet, `build()` adds an "Add menu" local-action link to
  `entity.ogmenu_instance.create` (with the group's entity type + id), guarded by
  `accessManager->checkNamedRoute(...)` — i.e. by the create permission.
- Theme hook becomes `menu__og__{menu_name}`; contextual link `ogmenu` points at the instance.

## Caching

- `getCacheContexts()` adds `route.menu_active_trails:ogmenu-{id}` and **`og_group_context`** — the
  block varies by the active group. Confirm this context is active so one group is not served
  another group's cached menu.
- `getCacheTags()` adds the menu name as a tag.

## README block names

The README refers to "OG Menu : single" / "OG Menu : multiple" blocks (first-available vs.
all-available group menus). In this 2.0.x code the block plugin is the single derived `ogmenu_block`
per menu; treat the README's single/multiple naming as historical.
