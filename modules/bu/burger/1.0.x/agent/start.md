<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burger Menu (burger) — agent index

A single **block plugin** that renders a chosen Drupal menu as a fullscreen, slide-in
"hamburger" navigation overlay. Package `Custom`. Depends only on core **`block`**. Core
requirement `^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The block, its five settings, install/uninstall behaviour, template and library** →
  [blocks/burger-menu-block.md](blocks/burger-menu-block.md)

## What it actually is

- One block plugin: `BurgerMenuBlock` (id **`burger_menu_block`**, admin label *"Burger
  Menu"*, category *"Navigation"*) in `src/Plugin/Block/BurgerMenuBlock.php`, extending
  core `BlockBase` and implementing `ContainerFactoryPluginInterface`.
- One theme hook `burger_block` (`burger_theme()` in `burger.module`) →
  `templates/burger-block.html.twig`.
- One asset library **`burger/burger`** (`burger.libraries.yml`): `css/burger.css` +
  `js/burger.js`, depends on `core/drupal`.
- `hook_install`/`hook_uninstall` (`burger.install`) auto-place / remove one block for the
  default theme.
- **No** routing, **no** permissions, **no** services, **no** config entities, **no**
  config/schema, **no** hooks beyond `hook_theme`, **no** Drush. Configuration is entirely
  block-instance settings edited on the core Block layout form (`administer blocks`).

## Mechanism (from source)

- Injects `menu.link_tree` and `entity_type.manager` via `create()`.
- `build()` loads the configured menu with `MenuTreeParameters` (`setMaxDepth(1)`,
  `onlyEnabledLinks()`), runs the `checkAccess` + `generateIndexAndSort` manipulators, then
  flattens each element to `title` / `url` (`getUrlObject()->toString()`) / `active`
  (`inActiveTrail`). Resolves `brand_url` (`<front>` → `Url::fromRoute('<front>')`, else the
  raw configured path). Returns a `#theme => 'burger_block'` render array cached on contexts
  `route`, `user.roles` and tag `config:system.menu.<menu_name>`.
- `blockForm()`/`blockSubmit()` expose and persist the five settings (see solution doc).
- `js/burger.js` (`Drupal.behaviors.burgerMenu`, using `once`) toggles the `open` class on
  `body`, `.b-container` and `.b-nav` when `.b-menu` is clicked; CSS animates the overlay.

## Settings (`defaultConfiguration()`)

`menu_name` (`main`), `brand_label` (`''`), `brand_url` (`<front>`), `color_primary`
(`#2196f3`), `color_text` (`#ffffff`). Details in
[blocks/burger-menu-block.md](blocks/burger-menu-block.md).
