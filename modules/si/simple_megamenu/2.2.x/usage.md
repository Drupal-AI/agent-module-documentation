Simple Mega Menu adds a fieldable, revisionable, translatable "Simple mega menu" content entity that you attach to individual menu link items, so a menu link can render a rich, themed mega-menu panel (built from fields and view modes) instead of a plain dropdown.

---

The module defines a content entity type `simple_mega_menu` with a config-entity bundle type `simple_mega_menu_type` (managed just like content types: create bundles, add fields, configure form/view displays). Each bundle declares which menus it applies to via its `targetMenu` config (a list of menu machine names). On the *Menu link content* edit form for any link in a targeted menu, the module adds a `Simple Mega Menu` entity-autocomplete field (`hook_form_menu_link_content_form_alter`); the chosen mega-menu entity id is saved onto the menu link's `options` as the attribute `data-simple-mega-menu`. Rendering is driven from Twig: the module registers two functions via a Twig extension — `has_megamenu(url)` (does this link's Url carry a mega menu?) and `view_megamenu(url, view_mode)` (render the attached entity in a given view mode). It ships two view modes, **before** and **after**, and a default `menu--simple-megamenu.html.twig` that themers override. A helper service `simple_megamenu.helper` resolves which bundles target a menu (`getMegaMenuTypeWhichTargetMenu`, `menuIsTargetedByMegaMenuType`) and loads entities; `hook_preprocess_block`/`hook_theme_suggestions_*` ensure targeted menus render through the default menu theme with extra suggestions so your mega-menu markup slots in. The entity is revisionable and translatable, so mega-menu content has full revision history and multilingual support. There is no global settings page (`configure: null`); configuration is per bundle (its target menus + fields) and per menu link (which entity is attached). The bundled `simple_megamenu_example` submodule ships a ready-made `megamenu` bundle with example fields to copy from.

---

- Attach a rich mega-menu panel to a top-level primary-navigation link.
- Build a mega menu with images, links and text fields instead of a plain dropdown.
- Create different mega-menu bundles (e.g. "products", "resources") with different fields.
- Restrict a mega-menu bundle to only the Main navigation menu via its target menus.
- Render a mega menu in a "before" region and different content in an "after" region using the two view modes.
- Give editors a WYSIWYG-style mega-menu builder using ordinary Drupal fields.
- Reuse one mega-menu entity across multiple menu links.
- Keep revision history of mega-menu content and roll back changes.
- Translate mega-menu content per language on a multilingual site.
- Add a promotional banner field to a mega menu shown under a menu item.
- Theme the mega menu by overriding menu--simple-megamenu.html.twig.
- Conditionally render a mega menu in a custom menu template with has_megamenu(url).
- Render an attached mega menu anywhere in Twig with view_megamenu(url, 'after').
- Configure the fields shown per mega-menu bundle via Manage fields/display.
- Let content authors pick which mega-menu entity a link uses from an autocomplete.
- Provide megamenus for a secondary/footer menu by targeting that menu.
- Add a custom view mode to a mega-menu bundle for a specific layout.
- Start from the example submodule's "megamenu" bundle and adapt it.
- Control publish/unpublish state of a mega menu independently of the link.
- Manage all mega-menu entities from the admin content listing.
- Gate who can create/edit/delete mega menus using the module's permissions.
- Build language-specific mega-menu navigation for an international site.
- Present grouped category links with icons under a navigation item.
- Override the mega-menu markup per bundle using theme suggestions.
