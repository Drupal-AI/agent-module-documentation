<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Item Fields makes the `menu_link_content` entity type fieldable, so you can attach fields (images, descriptions, options…) to custom menu links and render menus with view modes.

---

Core menu links (`menu_link_content`) are entities but core exposes no field UI or renderable view modes for them. This module turns them into a fully fieldable, displayable entity type: it makes the base fields (link, title, description, weight, enabled, expanded) display-configurable, registers a `menu_link_content` theme hook + template, and — via `hook_preprocess_menu()` — renders each `menu_link_content` item in the menu tree through the entity view builder using a chosen **view mode**. Rendering is delivered by a block plugin, **"Menu with fields"** (plugin id `menu_item_fields`, derived per menu like the core system menu block), whose settings pick the **view mode** and an optional **view-mode-override field** (a field on the menu link that names a per-item view mode, e.g. `mega`). It also supports per-menu **form modes**: enable a form mode on `menu_link_content` whose machine name matches the menu's name (dashes → underscores) and `hook_entity_form_mode_alter()` will use it when editing links in that menu. The companion **Menu Item Fields UI** submodule adds the actual Field UI (Manage fields / form &amp; view displays) for menu links. To render extra fields you provide `menu.html.twig` (this module ships one that themes lacking their own will inherit). No settings page, permission, or Drush command; config entities created for menu links automatically depend on this module.

---

- Add an image/icon field to menu links and show it in a mega menu.
- Attach a short description field to top-level menu items and render it under the link.
- Build a mega menu where each menu item renders a block of fields via a view mode.
- Give menu links a "subtitle" field displayed alongside the title.
- Render a menu with a specific view mode using the "Menu with fields" block.
- Let individual menu items override the view mode via a dedicated field (e.g. `mega`).
- Create per-menu form modes so the Main menu and Footer menu edit different fields.
- Configure `rel` and `target` attributes on menu-item link formatters.
- Add more link attributes to menu items with the Link Attributes module.
- Sort menu link fields on the Manage form/display screens (via the UI submodule).
- Attach a boolean "featured" field to promote certain menu items.
- Add a taxonomy-reference field to categorize menu items.
- Theme menu items richly by overriding `menu.html.twig` / `menu-link-content.html.twig`.
- Show different view modes per menu (e.g. compact footer, expanded main nav).
- Keep menu-item fields in config and content, deployable like any entity.
- Provide an "open in new tab" option field on marketing menu links.
- Add a CTA-style menu item with button text and icon fields.
- Render menu links as cards in a navigation region.
- Reuse the same fieldable menu structure across multiple blocks/regions.
- Disable the UI submodule in production (like Field UI) after building fields.
- Migrate a 1.x `menu__field_content` theme to the 2.x `menu.html.twig` approach.
- Localize per-item menu fields alongside the menu link translation.
- Attach a background-color/options field to style individual menu items.
