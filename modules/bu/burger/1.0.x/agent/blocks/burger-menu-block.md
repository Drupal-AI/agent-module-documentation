<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burger Menu block (`burger_menu_block`)

The module's only feature. Class `Drupal\burger\Plugin\Block\BurgerMenuBlock`
(`src/Plugin/Block/BurgerMenuBlock.php`), a core `BlockBase` block, category *"Navigation"*.

## Install / enable

- `drush en burger` (or via the UI). Depends on core `block`.
- `hook_install()` (`burger.install`) auto-places one block instance in the **default theme**:
  it reads `system.theme:default`, picks the first present region from
  `['header', 'primary_menu', 'navigation', 'page_top']` (falls back to `content`), and creates
  a `block` config entity `id = <theme>_burger_menu`, plugin `burger_menu_block`, weight `-10`,
  status TRUE, label *"Burger Menu"* (`label_display` `0`), bound to the `main` menu. It is
  skipped if that block id already exists.
- `hook_uninstall()` deletes `<theme>_burger_menu`.
- Additional instances: place *Burger Menu* on **Structure → Block layout** like any block.
  Requires the core **`administer blocks`** permission (there is no module-specific permission).

## Settings (`defaultConfiguration()` / `blockForm()` / `blockSubmit()`)

Persisted in the block instance's `settings`; no separate config object or schema is shipped.

| Key | Form type | Default | Meaning |
|-----|-----------|---------|---------|
| `menu_name` | `select` (all menu entities, required) | `main` | Menu whose top-level links render. |
| `brand_label` | `textfield` | `''` | Text of the brand link beside the icon. |
| `brand_url` | `textfield` | `<front>` | `<front>` → front page, else an internal path. |
| `color_primary` | `color` | `#2196f3` | Overlay/button background (`--burger-primary`). |
| `color_text` | `color` | `#ffffff` | Link/icon colour (`--burger-text`). |

`blockForm()` builds the menu `select` from `entityTypeManager->getStorage('menu')
->loadMultiple()` (labels `asort`ed). `blockSubmit()` copies each `$form_state` value into
`$this->configuration`.

## Rendering (`build()`)

1. `MenuTreeParameters`: `setMaxDepth(1)` + `onlyEnabledLinks()` — only top-level, enabled links.
2. `menuLinkTree->load(menu_name, params)` then `transform()` with manipulators
   `menu.default_tree_manipulators:checkAccess` and `:generateIndexAndSort` — access is honored
   per viewing user.
3. Each element → `['title' => link->getTitle(), 'url' => link->getUrlObject()->toString(),
   'active' => element->inActiveTrail]`.
4. `brand_url`: `'<front>'` resolves via `Url::fromRoute('<front>')->toString()`; any other value
   is used as-is.
5. Returns `#theme => 'burger_block'` with `#menu_items`, `#brand_label`, `#brand_url`,
   `#color_primary`, `#color_text` and `#cache` = contexts `['route', 'user.roles']`, tags
   `['config:system.menu.' . menu_name]`.

## Theme, template & assets

- `burger_theme()` (`burger.module`) registers hook `burger_block` (vars `menu_items`,
  `brand_label`, `brand_url`, `color_primary`, `color_text`) → `templates/burger-block.html.twig`.
- The template `attach_library('burger/burger')`, emits a scoped `<style>` setting the two CSS
  custom properties, a `.b-nav` list of `<a class="b-link[ b-link--active]">` items, and a
  `.b-container` holding the three `.b-bun` icon lines plus the `.b-brand` link. All dynamic
  values (`item.url`, `item.title`, `brand_url`, `brand_label`, colours) print through Twig's
  auto-escaping.
- Library `burger/burger` (`burger.libraries.yml`): `css/burger.css` (theme CSS, all colours via
  `var(--burger-primary/-text)` with hard-coded fallbacks; slide-in/out keyframe animations) and
  `js/burger.js`.
- `js/burger.js`: `Drupal.behaviors.burgerMenu` uses `once('burger-menu', '.b-menu')`; on click of
  the icon it toggles class `open` on `body`, the closest `.b-container`, and `.b-nav`. CSS then
  fades the full-viewport `body:after` overlay in and slides `.b-nav li` from the left.

## Operating notes

- To change which menu is shown, edit the block's *Menu* setting; the render cache is tagged to
  that menu so edits to it invalidate automatically.
- Only **top-level** links appear (max depth 1); child links are not rendered.
- Colours are `#type => 'color'` inputs and drive CSS variables; no other theming hook is needed,
  but the template/library can be overridden in a theme for deeper changes.
