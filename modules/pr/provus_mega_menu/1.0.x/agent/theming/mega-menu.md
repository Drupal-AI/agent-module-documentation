<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mega menu theming, library, and the fields it reads

Provus Mega Menu is presentation-only. Everything it does is in three places.

## `hook_theme()` — the template

```php
provus_mega_menu_theme() => [
  'menu__extras' => [
    'template' => 'menu--extras',
    'base hook' => 'menu_item_extras',
  ],
];
```

`templates/menu--extras.html.twig` recursively renders the menu tree with Bootstrap classes
(`nav navbar-nav`, `dropdown-cor-menu level-N`, `dropdown-menu level-N`). It:
- calls `{{ attach_library('provus_mega_menu/main-nav') }}`;
- at **menu level 0** captures `item.content.field_provus_menu_callout_image` and
  `item.content.field_provus_menu_callout_link` from each top-level item;
- at **menu level 1** renders those captured values inside a
  `<div class="callout-container d-none d-lg-block">` (the right-hand callout panel);
- for child items renders `item.content.field_provus_menu_icon` and adds a `has_icon` class.

Because `base hook` is `menu_item_extras`, it overrides Menu Item Extras' menu output.

## Library `provus_mega_menu/main-nav`

`provus_mega_menu.libraries.yml`:
- CSS: `css/provus_mega_menu.css`
- JS: `js/main-navigation.js`, `js/main-nav-behavior.js`
- dependencies: `core/drupal`, `core/jquery`, `core/drupal.debounce`,
  `provus_base_theme/global-styling` (so it expects the Provus base theme to be present).

## `hook_form_alter()` — field visibility on menu items

`provus_mega_menu_form_alter()` acts on form id `menu_link_content_main_form` and uses
`#states` on three fields (the module does **not** create them — the Provus recipe attaches
them to menu link content):

| Field | Shown when | Purpose |
|---|---|---|
| `field_provus_menu_callout_image` | `menu_parent == 'main:'` (top level) | callout image on level-1 panel |
| `field_provus_menu_callout_link` | `menu_parent == 'main:'` (top level) | callout link on level-1 panel |
| `field_provus_menu_icon` | `menu_parent != 'main:'` (child) | icon on child links |

## Making it work

- Enable the module (pulls in `menu_item_extras`) and run inside the Provus base theme.
- Ensure the three fields exist on the relevant menu link content bundle (the `main` menu
  bundle for the callout/icon fields) — provided by the Provus recipe, or add them yourself
  as `FieldStorageConfig` + `FieldConfig` on entity type `menu_link_content`.
- There is nothing to configure in an admin form; styling/behavior come from the template,
  CSS and JS. No hooks, services, or plugins are exposed for reuse.
