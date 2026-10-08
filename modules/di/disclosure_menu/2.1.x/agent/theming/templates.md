# Disclosure Menu — theming

The block defines its own theme hooks and libraries (in `disclosure_menu.module` /
`disclosure_menu.libraries.yml`). Override the templates in your theme to change markup.

## Theme hooks

- `block__disclosure_menu` — block wrapper (`base hook: block`).
- `menu__disclosure` — the menu itself (`base hook: menu`). Extra variables passed from `build()`:
  `menu_name`, `items`, `menu_attributes`, `attributes`, `submenu_disclosure_levels`,
  `disclosure_button_include_chevron`, `disclosure_button_include_label`, `disclosure_button_label`,
  `menu_disclosure`, `menu_disclosure_button_include_label`, `menu_disclosure_button_label`, `id`.

Provide `templates/menu--disclosure.html.twig` in a theme to render the `<ul>`/`<li>` tree and the
`button.menu__submenu-toggle` elements. Each toggle must set `aria-controls="<submenu id>"` and the target
submenu must carry that id; the JS keys off those attributes (and `data-submenu-id` on the `li` for hover).

## Libraries (`disclosure_menu.libraries.yml`)

| Library | Contents |
|---|---|
| `disclosure_menu/menu` | `js/disclosure-menu.js` (deps: `core/drupal`, `core/drupalSettings`, `core/once`). |
| `disclosure_menu/style-horizontal` | `css/horizontal-menu.css` + `css/default-menu.css`. |
| `disclosure_menu/style-vertical` | `css/vertical-menu.css` + `css/default-menu.css`. |
| `disclosure_menu/style-hover` | `css/hover-menu.css`. |

## JS behaviour (`Drupal.behaviors.disclosure_menu`)

- Initializes full-menu toggles matching `nav > button.menu-toggle[aria-controls]`.
- For each menu id in `drupalSettings.disclosureMenu`, wires `button.menu__submenu-toggle` (via `once`):
  click toggles the `aria-controls` target, sets `aria-expanded`, and closes on `focusout`/`blur` when focus
  leaves both toggle and menu (keyboard-friendly).
- `resolveHoverClick`: `only_open` → click only shows; `keyboard_only` → click ignored unless
  `event.detail === 0` (keyboard); otherwise plain toggle.
- Hover mode (`li[data-submenu-id]`): pointerover starts a show-timeout (`hoverShowDelay`), pointerout starts
  a hide-timeout (`hoverHideDelay`), each cancelling the other.
