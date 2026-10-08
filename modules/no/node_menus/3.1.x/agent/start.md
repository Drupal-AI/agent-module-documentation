<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Menus — agent index

Lets you configure **which menus are available for placing nodes**, scoped **per content type and per
language**. On a translatable content type you enable "Language menus" and pick, for each language, the menus a
node link may go into plus a default parent item; the node form then offers only language-appropriate parent
options instead of one combined dropdown. Version **3.1.x** (dev). Core `^11.2 || ^12`.

Depends on core `content_translation`, `menu_ui`, `node`, `language`. Site-structure/content-editing — affects
node menu-placement options, not access. No permissions, no routes, no config schema shipped. Menu placement
still goes through core menu_ui's own access gating.

## How it works

- `src/Hook/NodeMenusHooks.php` (OO hooks, `#[Hook]` attributes) is the whole module.
- `form_node_type_form_alter`: adds the **Language menu settings** fieldset under *Additional settings* — an
  "Enable language menus" checkbox and, per language, a checkboxes list of available menus and a default
  "Parent item" select. Saved into the node type's third-party settings (`node_menus.enabled`,
  `node_menus.languages[<langcode>]` = `available_menus` + `parent`) via a static entity builder.
- `form_node_form_alter` (ordered after `menu_ui`): only acts when `$form['menu']` already exists (so menu_ui
  decided the fieldset is shown), the node is translatable, and the content type has language menus enabled.
  It swaps the core menu parent `select` for a language-scoped one, or — when the language selector is visible
  — adds one parent selector per language wrapped in `#states` keyed on `langcode`, syncing the chosen value
  back into `menu[menu_parent]` in a static validate callback.
- `js/node_menus.admin.js` (library `node_menus/admin`): on the node type form, POSTs the checked menus to the
  core `admin/structure/menu/parents` endpoint and rebuilds the default-parent options live.
- `hook_node_menus_available_menus_alter(&$available_menus, &$form, $context)` — see `agent/hooks/hooks.md`.

## Solution docs

- `agent/configure/language-menus.md` — enabling and configuring per-language menus on a content type.
- `agent/hooks/hooks.md` — the `hook_node_menus_available_menus_alter` extension point and implemented hooks.
