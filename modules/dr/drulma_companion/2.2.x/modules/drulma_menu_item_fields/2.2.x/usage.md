<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drulma Companion Menu Item Fields makes the Menu Item Fields module work with the Drulma theme's Bulma navbar by adding Bulma classes to field-bearing menu links.

---

This submodule of Drulma Companion is glue between the contrib **Menu Item Fields** module (which lets menu links render field content) and the **Drulma** theme's Bulma navbar. It implements `hook_preprocess_menu__bulma_navbar()`, delegates to Menu Item Fields' own field-content preprocessing, and then attaches a `#pre_render` trusted callback plus a small CSS library (`navbar-adjust`) to each menu item that carries field content, so the rendered links get the Bulma `navbar-item` class and a Drulma adjustment class. It depends on `menu_item_fields`, has no config, no permissions, and no UI.

---

- Render menu links that carry field content correctly inside a Drulma/Bulma navbar.
- Add the Bulma `navbar-item` class to field-based menu links automatically.
- Add the `navbar-drulma-adjust` class (and load `css/navbar-adjust.css`) to align field menu links in the navbar.
- Reuse Menu Item Fields' field-content preprocessing within the Bulma navbar theme hook.
- Enable alongside Drulma Companion when using the Menu Item Fields module.
- Keep navbar menu markup themable while still styling field menu links.
- Apply only to items rendered through the `menu__bulma_navbar` suggestion (the navbar-with-branding block).
