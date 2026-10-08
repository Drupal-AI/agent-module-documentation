Translatable Menu Link Uri makes a menu-link-content item's destination translatable per language, so one menu link can point to a different (external) URL in each language.

---

Drupal's core `menu_link_content` entity is translatable for its title, but its built-in `link` field is not — every translation shares the same URL. This module adds a second base field, `link_override` (a translatable, revisionable `link` field labelled "Translatable External Link Override"), to the `menu_link_content` entity via `hook_entity_base_field_info()`. On the menu link edit form it alters `menu_link_content_form` so the original `link` field shows only when editing the default language, while the `link_override` field shows only when editing a translation — giving each language its own destination. At render time a `preprocess_menu` (and `preprocess_menu_levels` for Menu Item Extras) hook runs the `translatable_menu_link_uri.link_processor` service (`LinkIterator`), which walks the menu tree, loads the current translation's `link_override` value, and swaps it into the rendered menu item's URL. The override is intended for **external / off-site links** only — the field description warns not to use it for internal Drupal links. If the Token module is enabled, external override URLs are token-replaced and the field shows token help. It depends on `menu_link_content` and `content_translation`, has no admin settings form of its own, and works once you enable translation for menu links.

---

- Point a menu link to a different external URL in each site language (e.g. English vs. French landing page).
- Translate the destination of a menu link, not just its title.
- Link a menu item to a language-specific marketing or campaign site per translation.
- Send visitors to region-specific external partners depending on the interface language.
- Override a menu link's off-site target for one translation while leaving others unchanged.
- Provide localized documentation or help URLs behind a single shared menu label.
- Route to language-specific social media or store pages from one menu entry.
- Keep one menu structure while giving each language its own external destinations.
- Add per-language external links to a custom menu (main, footer, or otherwise).
- Translate footer links that point to localized legal/privacy pages hosted externally.
- Use Token replacement inside a per-language external override URL (with the Token module).
- Insert localized query parameters or campaign tokens into translated external links.
- Edit the canonical URL on the default-language form and the override URL on each translation form.
- Support translated menu links inside menus rendered by the Menu Item Extras module (nested/child links).
- Preserve link options (attributes, etc.) from the base link while overriding the URL per language.
- Give editors a clear, separate field for the translated destination so they don't touch the source link.
- Migrate legacy multilingual menus where each language needed its own hard-coded external URL.
- Localize "Buy now" / "Contact" style menu buttons to different external endpoints per language.
- Fall back to the original link when a translation leaves the override empty.
- Enable it on an existing site: turn on content translation for `menu_link_content`, then translate links.
- Combine with the core Menu UI to manage multilingual menus without custom code.
- Point the same navigation item at different external subdomains per locale.
- Call the `translatable_menu_link_uri.link_processor` service to process a menu item's URL in custom preprocess code.
- Track which language a menu link resolves to since the override respects the current translation context.
