# Disclosure Menu — agent index

Accessible dropdown menu block. Extends core `SystemMenuBlock` (same per-menu deriver) and adds
disclosure toggle buttons for submenus, plus optional hover navigation and bundled horizontal/vertical
CSS. No global config page (`configure` null), no permissions, no Drush. Requires contrib `token` +
`twig_tweak`. Config is entirely per block instance.

- **Block settings: every config key, JS/drupalSettings, token labels** → [configure/block.md](configure/block.md)
- **Theme hook `menu__disclosure`, template variables, libraries** → [theming/templates.md](theming/templates.md)

Key facts:
- Block plugin id `disclosure_menu`, `deriver = SystemMenuBlock` → one block per menu, category "Disclosure Menu".
- Renders via `#theme = 'menu__disclosure'`; attaches library `disclosure_menu/menu` and per-instance
  `drupalSettings.disclosureMenu[<uniqueId>]`.
- JS: `js/disclosure-menu.js` toggles `button.menu__submenu-toggle` targets by `aria-controls`, sets
  `aria-expanded`, closes on focus-out/blur; hover mode adds pointerover/out with show/hide delays.
