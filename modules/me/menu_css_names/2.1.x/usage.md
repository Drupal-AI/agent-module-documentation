<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu CSS Names adds a per-item CSS class to Drupal menu links, derived from each link's title, so menu items can be styled individually.

---

Core menu markup does not always give you a stable, per-item hook for CSS, so styling one specific menu item — a highlighted **Sign up**, a coloured section link, a CSS-sprite icon — is awkward. Once enabled (it depends on `menu_ui`), Menu CSS Names implements `hook_preprocess_menu` and appends a class to every rendered menu item, including nested child items. The class is built from the link title: it is transliterated to ASCII, stripped of tags, lowercased, and every character that is not a letter, digit, underscore or hyphen becomes a hyphen — so **Product Information** becomes `product-information` and you write `li.product-information { … }`. Regular menus are processed automatically; a small settings form at `/admin/config/menu_css_names` (permission *administer menu_css_names configuration*) has two checkboxes — **Include classes for Local actions** and **Include classes for Local Tasks** — both on by default, that also add the same class to admin tabs and action buttons. There is no separate library, JS or CSS to load; the class simply appears in the menu markup for your theme's CSS to target. Because the class follows the current title, it changes if an editor renames the link, so confirm class stability if your CSS depends on a specific name.

---

- Add a CSS class to every menu link.
- Style one specific menu item.
- Target menu items individually in CSS.
- Highlight a single menu link (e.g. a call-to-action).
- Apply CSS-sprite icons per menu item.
- Style nested / child menu items.
- Predict a link's class from its title (Product Information → product-information).
- Add classes to admin local tasks (tabs).
- Add classes to admin local actions (buttons).
- Turn the local-tasks class output off.
- Turn the local-actions class output off.
- Restrict who can change the settings via the dedicated permission.
- Enable the module and clear caches to start classing menus.
- Style a section link differently from the rest of a menu.
- Keep menu styling in the theme's CSS rather than templates.
- Reproduce the D7 "Menu CSS Names" behavior on Drupal 10/11.
- Check class stability before relying on it after editors rename links.
- Reset the two toggles to defaults via the shipped update hook.
- Configure per-item styling without writing a preprocess hook yourself.
- Combine per-item classes with CSS sprite techniques.
