<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Add Content Page (custom_add_content) — agent index

Overrides the core `/node/add` page so it renders a **configurable menu** (`custom-add-content-page`)
instead of the alphabetical content-type list — order, group, hide and describe creation links.
Version **2.1.1** (version-dir `2.1.x`). Core `^8.7.7 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
No declared dependencies (uses core **node** and **menu_link_content** at runtime).

- **Install/uninstall behavior, the menu, config, renderer, routes and hooks** →
  [config/settings.md](config/settings.md)

## What it actually is

- A **route subscriber** `Routing\CustomAddContentRouteSubscriber` (`custom_add_content.services.yml`,
  tag `event_subscriber`) that, in `alterRoutes()`, repoints the `node.add_page` route's `_controller`
  to `Controller\CustomAddContentController::addPage`. **Route access is unchanged** — only the
  controller swaps.
- A **controller** `Controller\CustomAddContentController` extends core `NodeController`. `addPage()`
  loads the `custom-add-content-page` menu tree, applies the `checkAccess` + `generateIndexAndSort`
  manipulators, then renders it either with the **core renderer** (config `= 0`) or via the module's
  **`custom_add_content_page_add`** theme/Twig template (config `= 1`, the default).
- A **config form** `Form\AddContentConfigurationForm` (route `custom_add_content.config` at
  `admin/config/user-interface/custom_node_add`, permission **`administer site configuration`**),
  editing config object **`custom_add_content.config`**, key `custom_add_content_renderer` (0 = core,
  1 = custom). Menu link at `custom_add_content.links.menu.yml`.
- **`.install`**: `hook_install` creates the `custom-add-content-page` menu + one `menu_link_content`
  per existing node type, and sets module weight 15; `hook_uninstall` deletes the menu.
- **`.module`**: `hook_form_alter` on `node_type_add_form` / `node_type_delete_form` adds/removes the
  matching menu link when a content type is created/deleted; `hook_theme` registers
  `custom_add_content_page_add`.
- Ships a **Twig template** (`templates/custom-add-content-page-add.html.twig`, theme-overridable) and
  a CSS **library** `custom_add_content/custom_add_content` (`libraries/custom_add_content.css`).

## Provides

- Entities created at runtime: one `menu` config entity (`custom-add-content-page`) and per-type
  `menu_link_content` entities. **No** custom entity types, plugin types, permissions, Drush commands,
  or config schema.

## Notes

- **No `config/schema/`** — the `custom_add_content.config` object (install default `= 1`) has no
  schema; strict config-schema tooling may flag it. It stores only an integer 0/1 from the admin
  select, so it saves and works regardless.
- Ordering/hiding a menu link is **presentation, not permission**: `/node/add/<type>` still works for
  anyone holding the create permission. The rendered tree is access-checked, so users only see links
  to types they may create.
