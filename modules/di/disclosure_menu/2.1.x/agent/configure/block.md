# Disclosure Menu — block configuration

All configuration is per block instance (Block layout → *Place block* → "Disclosure menu" derivatives, one
per menu). No admin settings page and no config schema; settings live in the block config entity under
`settings`. Defaults are from `DisclosureMenuBlock::defaultConfiguration()`.

## Settings keys (with defaults)

Core menu block keys still apply (`level`, `depth`, `expand_all_items`). Added keys:

| Key | Default | Meaning |
|---|---|---|
| `submenu_disclosure_levels` | `-1` | How many menu levels get submenu toggle buttons. `-1`=unlimited, `0`=none, `1`–`9`=count. Hidden when depth is 1. |
| `disclosure_button_include_chevron` | `1` | Insert a chevron icon in submenu toggles (`0`/`1`). |
| `disclosure_button_include_label` | `0` | `0`=no visible label, `1`=custom text label on submenu toggles. |
| `disclosure_button_label` | `More [menu-link:title] pages` | Label text; supports `menu-link` tokens. |
| `menu_disclosure` | `0` | `1` adds one extra button that toggles the whole menu. |
| `menu_disclosure_button_include_label` | `1` | Visible label on the full-menu toggle (`0`/`1`). |
| `menu_disclosure_button_label` | `Open [menu:name]` | Full-menu toggle label; supports `menu` tokens. |
| `include_default_js` | `1` | Attach the toggle JS (`disclosure_menu/menu`). Without it the buttons don't work. |
| `include_hover_js` | `0` | Also open submenus on hover (only when `include_default_js`). Adds `hover` class + `style-hover` CSS. |
| `resolve_hover_click` | `keyboard_only` | Hover+click conflict: `keyboard_only` (button reacts to keyboard only), `only_open` (click never closes), `no_change`. |
| `hover_show_delay` | `150` | ms before showing submenu on hover. |
| `hover_hide_delay` | `250` | ms before hiding submenu after pointer leaves. |
| `include_css` | `horizontal` | Bundled styles: `0`=none, `horizontal`, `vertical` (adds the matching class + CSS library). |

## Runtime wiring (`build()`)

- `#theme` set to `menu__disclosure`; a unique DOM id is generated with `Html::getUniqueId('disclosure-menu')`.
- When `include_default_js`: attaches library `disclosure_menu/menu` and
  `drupalSettings.disclosureMenu[<id>] = ['id' => <id>]`; if hover also on, adds `hover`, `resolveHoverClick`,
  `hoverShowDelay`, `hoverHideDelay` to that settings object and the `style-hover` library.
- `include_css` of `horizontal`/`vertical` adds the class + `style-horizontal`/`style-vertical` CSS library.
- Submenu disclosure `#` vars are only passed when `depth !== 1`.

## Token labels

Button labels are rendered through Token (dependency `token`), so `disclosure_button_label` accepts
`[menu-link:title]` and `menu_disclosure_button_label` accepts `[menu:name]`. A `token_tree_link` helper is
shown under each label field in the block form.
