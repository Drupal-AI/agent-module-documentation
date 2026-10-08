Menu Item Extras makes core's menu links fully fieldable — adding a body field, custom fields, and per-menu view modes to menu items — so you can build mega menus and rich navigation without extra content entities.

---

Core menu links (`menu_link_content`) only hold a title, URL, and description. Menu Item Extras upgrades them into first-class fieldable entities: it adds a default **body** field and a `view_mode` base field, and lets you attach any additional fields (images, text, entity references, blocks) through the normal Field UI on **Structure → Menu link content**. Each menu gets a **view modes settings** form (`/admin/structure/menu/manage/{menu}/view_modes_settings`) so different menus — or different levels within a menu — can render their links differently. Rendering is handled by dedicated templates (`menu-link-content.html.twig`, `menu--extras.html.twig`, `menu-levels.html.twig`) plus a rich set of theme-hook suggestions keyed by menu name, level, entity id, and view mode, giving themers granular control. A cache context and active-trail handling keep the enriched menus cacheable. The result is a native way to build mega menus, image-driven navigation, promotional menu blocks, and multi-column dropdowns using standard Drupal fields and view modes. A Drush command clears the extra data when uninstalling, and an optional `mie_demo_base` submodule ships a worked mega-menu example. Services expose the menu link tree with rendered content for use in custom code.

---

- Build a mega menu with images and descriptions on top-level items.
- Add a body/description field rendered beneath each menu link.
- Attach an image field to menu items for icon or thumbnail navigation.
- Add a "promo" reference field so a menu column features a piece of content.
- Give different menus different rendering via per-menu view modes.
- Render menu level 0 differently from deeper levels with level-based templates.
- Create multi-column dropdown navigation from a single menu.
- Add a subtitle/tagline field to primary navigation links.
- Use entity reference fields to pull teasers into a menu flyout.
- Theme individual menu items via `menu-link-content--{menu}--{view_mode}` suggestions.
- Add call-to-action buttons as fields on specific menu links.
- Build a footer menu with rich text blocks per column.
- Provide editors a WYSIWYG body on menu items (with the demo submodule's setup).
- Set a specific view mode per menu item from the link edit form.
- Style active-trail menu branches using the provided cache context.
- Expose menu link content fields to Views via the module's Views data/argument.
- Add a background-image field for banner-style menu panels.
- Create language-specific rich menu content on multilingual sites.
- Clear leftover menu extra-data before uninstalling via the Drush command.
- Render a menu tree with its field content programmatically via the tree handler service.
- Add a "featured product" image+link to a commerce site's main navigation.
- Build an accessible mega menu without a dedicated mega-menu contrib module.
- Provide per-item icons for an admin or utility navigation menu.
- Reuse standard field formatters/widgets to control how menu extras display.
