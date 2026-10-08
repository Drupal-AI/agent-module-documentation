<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Mega Menu (advanced_mega_menu) — agent index

A **grid-based mega-menu builder**. For opted-in menus, a visual "canvas" layout builder fills each
top-level menu item with **rows → columns → blocks** (Views displays, Block Content entities, or
theme/system blocks). Package `Megamenu`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

- No hard module dependencies declared in `.info.yml`. **Functionally requires** core **Views**
  (embedding View blocks; `Views::getAllViews()` in the builder) and, for the REST endpoint, core
  **REST + Serialization**. `block` / `block_content` are used when those block sources are chosen.

## Solution docs

- **Install, the two config objects/forms, enabled menus, submenu icons** →
  [config/settings.md](config/settings.md)
- **The layout-builder entity, forms, canvas, rendering services & templates** →
  [menu/builder.md](menu/builder.md)
- **The REST resource for decoupled front-ends** → [api/rest.md](api/rest.md)

## What it provides (from source)

- **Config entity** `megamenu_content` (`src/Entity/MegaMenuContent.php`, config prefix
  `megamenu_content`, id key = `form_id` = the menu-link UUID, also stores `menu_id`, `label`,
  `rows`, `display_settings`, `status`). `admin_permission = administer menus`. List builder
  `MegaMenuContentListBuilder`.
- **Permission** (`advanced_mega_menu.permissions.yml`): `administer advanced mega menu`
  (`restrict access: true`) — gates every route below.
- **Routes** (`advanced_mega_menu.routing.yml`), all `_permission: administer advanced mega menu`:
  - `advanced_mega_menu.action` `/admin/structure/menu/manage/{menu_id}/{menu_link_content}` →
    `AdvancedMegaMenuController::action` (loads/creates the entity, renders the builder form).
  - `advanced_mega_menu.toggle` `/admin/structure/menu/{menu_id}/mega-menu/{action}` →
    `AdvancedMegaMenuController::toggle` (adds/removes the menu from `enabled_menus`).
  - `advanced_mega_menu.megamenu_content.settings` `/admin/structure/advanced-mega-menu/settings`
    → `MegaMenuContentSettingsForm` (the `configure` route).
  - `advanced_mega_menu.megamenu_content.collection` `/admin/structure/advanced-mega-menu/list`
    (entity list), `advanced_mega_menu.main_index` (Structure landing),
    `entity.megamenu_content.delete_form` (delete confirm).
- **Services** (`advanced_mega_menu.services.yml`): `advanced_mega_menu.menu_link_helper`
  (`Menu\MenuLinkHelper`), `advanced_mega_menu.block_renderer` (`Service\MegaMenuBlockRenderer`),
  `advanced_mega_menu.mega_menu_row_builder` (`Service\MegaMenuRowBuilder`).
- **REST resource** `advanced_mega_menu_resource`
  (`src/Plugin/rest/resource/MegaMenuResource.php`): `GET /api/advanced-mega-menu/{menu_id}/{plugin_id}`.
- **Ajax command** `ScrollToCommand` (`command: megaMenuScrollTo`), driven by `js/advanced-mega-menu-form.js`.
- **Config object** `advanced_mega_menu.settings` (`enabled_menus`, `disable_assets`, `submenu_icon`);
  schema in `config/schema/advanced_mega_menu.schema.yml`; install defaults in `config/install/`.
- **Hooks** (`advanced_mega_menu.module`): `hook_form_menu_edit_form_alter` (adds the gear/new-tab
  builder links to each menu row), `hook_entity_operation_alter` (Enable/Disable Mega Menu menu
  operation), `hook_preprocess_menu` + `hook_theme_suggestions_menu_alter` (swap in the mega template),
  `hook_theme` (`advanced_mega_menu`, `menu__advanced_mega_menu`).
- **Templates** (`templates/`): `menu--advanced-mega-menu.html.twig` (recursive menu macro),
  `advanced-mega-menu.html.twig` (row/column/block panel).
- **Libraries**: `advanced_mega_menu` (front-end CSS/JS), `advanced_mega_menu_form`(+`.admin`) (builder UI).

No Drush commands. No submodules. No plugin types defined.
