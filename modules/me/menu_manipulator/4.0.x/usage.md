<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Manipulator improves Drupal menu rendering: it can filter each menu's links by the current interface language and render an icon per link, configured centrally at one settings page.

---

The module hooks core menu rendering (`hook_preprocess_menu`) and, for the menus you list, removes links that don't belong to the current language so a single menu can serve every language without per-language menu duplication. Language can be resolved either from a link's own `langcode`/menu_link_content translation or from an assigned entity — the module adds a **language selector to the menu link edit form** (`hook_form_menu_link_content_form_alter`) and stores the chosen language back on the link via an entity builder. A `MenuLinkTreeManipulators` service (`menu_manipulator.menu_tree_manipulators`) does the tree filtering (`filterTreeByCurrentLanguage`, `filterItemsByCurrentLanguage`) with an access check per link, and a helper `menu_manipulator_get_multilingual_menu()` builds a language-filtered render array for any menu. Separately it can preprocess menus to attach an icon per link from a configured icon list. Everything is driven by the `menu_manipulator.settings` config object (which menus are language-filtered, which are icon-enabled, whether to use the assigned entity's language, and the available-icons list), edited at *Configuration → User interface → Menu Manipulator* (`/admin/config/user-interface/menu-manipulator`, gated by `administer site configuration`). It depends on core's Language module.

---

- Serve one main menu that automatically shows only the current language's links.
- Avoid maintaining a separate menu per language by filtering links at render time.
- Filter the footer menu by language while leaving other menus untouched.
- Choose per menu which ones are language-filtered (`preprocess_menus_language_list`).
- Resolve a link's language from its own translation rather than a linked entity.
- Resolve a link's language from the entity it points to (`preprocess_menus_language_use_entity`).
- Assign a specific language to a menu link from the link edit form.
- Add an icon to each link in selected menus (`preprocess_menus_icon`).
- Maintain a central list of available icons for menu links (`menu_link_icon_list`).
- Render a language-filtered menu programmatically via `menu_manipulator_get_multilingual_menu()`.
- Reuse the tree manipulator service to filter a menu tree in custom code.
- Keep menu link access checks intact while filtering by language.
- Turn language filtering on or off globally with one setting.
- Provide multilingual navigation on a site that uses translated menu links.
- Show the account/tools menus in the visitor's language.
- Add flag/glyph icons to a top navigation menu without a custom theme.
- Configure everything from a single admin settings form.
- Export the menu-manipulator settings as config for deployment.
- Combine language filtering with icons on the same menu.
- Reduce editor confusion by hiding other-language links from the menu UI output.
- Support nested/child links being filtered along with their parents.
- Migrate a duplicated per-language menu setup to a single filtered menu.
