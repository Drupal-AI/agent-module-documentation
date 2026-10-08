<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar inspector — context_active_inspector

The whole module is one `.module` file plus a permission, a CSS library, and an icon. It contributes a Toolbar tray
that lists the Context contexts active on the current request.

## Install / enable

Requires core `toolbar` and the contrib `context` module (composer: `drupal/context:^5.0@RC`).

```
composer require drupal/context_active_inspector
drush en context_active_inspector -y
```

Then grant the permission `access context active inspector` to the roles that should see the inspector (Admin > People
> Permissions, or `drush role:perm:add <role> 'access context active inspector'`). Without it the toolbar item is not
rendered at all.

## Permission (`context_active_inspector.permissions.yml`)

- `access context active inspector` — title "Access context active inspector". This is the only access control the
  module defines; it gates the entire toolbar item. Grant it only to admin/developer roles, since the tray reveals the
  machine names and labels of configured contexts.

## Functions (`context_active_inspector.module`)

- `context_active_inspector_toolbar(): array` — implements `hook_toolbar`.
  - Sets `#cache['contexts'] = ['user.permissions']` on its item.
  - Returns early (item with only cache metadata) if the current user lacks `access context active inspector`.
  - Otherwise builds a `#type: toolbar_item` (weight 999) with a `tab` link (icon class
    `toolbar-icon-context-active`, routed to `<none>`) and a `tray` whose `content` is a `#theme: item_list` of the
    active-context links. Adds CSS class `cai-empty` on the wrapper when there are no active contexts. Attaches the
    `context_active_inspector/toolbar` library.
- `context_active_get_context_list(): array` — helper (not a hook).
  - Calls `\Drupal::service('context.manager')->getActiveContexts()`.
  - For each active context builds a `#type: link` titled with `$item->getLabel()`, `title` attribute = `$item->id()`.
  - Link URL is `$item->toUrl()` when `context_ui` is enabled, else `Url::fromRoute('<nolink>')`.
  - Returns `[]` when nothing is active; the toolbar hook then substitutes a single "No contexts" `<nolink>` entry.
- `context_active_inspector_hook_info(): array` — implements `hook_hook_info`, declaring the hook group
  `context_active_inspector_commands` (group `context_active_inspector`). No code in this module invokes that hook; it
  is an extension point only, so implementations placed in a `MODULE.context_active_inspector.inc` file are recognized.

## Library & assets

- `context_active_inspector.libraries.yml` defines `toolbar`: CSS `css/context_active_inspector.css`, depends on
  `toolbar/toolbar`.
- The CSS sets the toolbar tab icon from an inlined `data:` SVG (`--cai--tab-icon`) and includes fixes for the Gin and
  Gin Toolbar themes (including dark mode). `logo.png` is the project logo. No JS ships.

## Notes for agents

- There is no settings route, config form, or config object — `configure` is null and there is no `config/` directory.
- "Active" means Context's own evaluation for the current request; the inspector reflects `context.manager` state and
  adds nothing to how contexts are evaluated.
