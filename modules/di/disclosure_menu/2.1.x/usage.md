Disclosure Menu provides an accessible alternative to Drupal's core menu block: submenus are toggled by dedicated "disclosure" buttons (with ARIA labels and `aria-expanded` state) instead of forcing keyboard users to tab through every link.

---

The module ships a single block plugin (`disclosure_menu`) that extends core's `SystemMenuBlock` and uses the same menu/level deriver, so you place one block per menu just like the core menu block. Its block configuration form adds four groups of settings on top of the core menu depth/level options: submenu disclosure (how many levels get toggle buttons, chevron icon, optional custom button label with `menu-link` token support), full-menu disclosure (an extra button that toggles the whole menu), JavaScript behaviour (default toggle JS, optional hover navigation with show/hide delays and a hover-vs-click conflict resolution mode), and bundled CSS styles (none / horizontal / vertical). The block renders through a custom `menu__disclosure` theme hook and attaches `disclosure_menu/menu` JS plus optional style libraries; per-instance settings are passed to the browser via `drupalSettings.disclosureMenu[<id>]`. The JavaScript (`js/disclosure-menu.js`) wires each `button.menu__submenu-toggle` to open/close its `aria-controls` target, closes menus on focus-out/blur for keyboard users, and (when hover mode is on) shows/hides submenus on pointer over/out with configurable delays. Requires the Token and Twig Tweak contrib modules. There is no global settings page (`configure` is null) and the module defines no permissions or Drush commands.

---

- Replace a core menu block with an accessible dropdown menu that has keyboard-operable submenu toggles.
- Give keyboard users a choice to enter a submenu instead of tabbing through every child link.
- Expose submenu state to assistive tech via `aria-expanded` and ARIA labels on each toggle button.
- Render a horizontal dropdown navigation bar using the bundled horizontal CSS.
- Render a vertical (sidebar-style) dropdown menu using the bundled vertical CSS.
- Provide your own theme's CSS by choosing "No default styles" and styling `.menu__disclosure`.
- Limit disclosure buttons to a set number of menu levels (e.g. only the top level).
- Add a chevron icon to each submenu disclosure button.
- Add custom visible label text to submenu buttons, templated with the `[menu-link:title]` token.
- Add a single button that toggles the entire menu open/closed (e.g. a mobile "menu" button).
- Give the full-menu toggle a custom label using the `[menu:name]` token.
- Enable hover navigation so submenus open when the pointer hovers the parent item.
- Tune how long to wait before opening a submenu on hover (show delay).
- Tune how long to wait before closing a submenu after the pointer leaves (hide delay).
- Resolve hover-vs-click conflicts by making the button keyboard-only, open-only, or unchanged.
- Disable the bundled JavaScript entirely to supply your own toggling behaviour.
- Reuse core menu block settings (menu levels, depth, expand-all) alongside the disclosure options.
- Build a multi-level mega-menu where each branch can be independently disclosed.
- Auto-close a submenu once the user tabs past its last link (focus-out handling).
- Place multiple disclosure menu blocks (main menu, footer, account) each with independent settings.
