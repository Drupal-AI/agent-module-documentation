<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DROWL Header Slides renders a per-page header/hero slideshow by resolving a "Slide" media entity referenced from the active menu trail (or a node/menu-item field) and displaying it, with an optional site-wide fallback slideshow.

---

DROWL Header Slides (package DROWL.de) turns the "slideshow" media type shipped by its sibling `drowl_media` stack into a header/hero banner that changes per page. It ships two Block plugins that walk the active menu trail of configured menus, find the nearest `menu_link_content` carrying a `field_slideshow_ref` (a reference to a slideshow media entity), and render that media in a "page width" (`full`) or "viewport width" view mode; a boolean `field_slideshow_inherit` on a menu item controls whether its slideshow cascades to child pages. It also adds `field_slideshow_ref` to `page` nodes for a per-node override, and ships three Views: a fallback slideshow block (published slideshow media), a node-field-driven "referenced slides" block, and an editor administration overview at `/admin/content/header-slides`. A settings form (`/admin/config/system/drowl-header-slides`) picks which menus are searched. The module itself only resolves and renders media; the actual carousel (Slick/Blazy, per-slide markup, links) is defined by the `drowl_media` slideshow media type it depends on. It requires the full DROWL media stack (`drowl_media`, `drowl_media_types`) plus `slick`, `fences`, `menu_item_extras`, `views_linkarea`, `media`, `media_library`, `views`, `block_content`, `taxonomy` and `language`.

---

- Show a different hero/header slideshow on each section of the site, driven by the main menu.
- Assign a slideshow to a top-level menu item and let all its child pages inherit it automatically.
- Override the inherited slideshow on a specific page node via its "Header Slideshow" field.
- Override a section slideshow on a single menu item without affecting siblings.
- Render the same slideshow at page (container) width in one region and full viewport width in another.
- Fall back to a generic site-wide slideshow when a page has no assigned header slideshow.
- Give editors a single overview screen listing all slideshow media and where they are used.
- Let editors jump from that overview to add a new slideshow, manage slides, or edit the menu.
- Search multiple menus (not just `main`) for header-slide assignments.
- Place the header slideshow as a normal block via Block layout in any theme region.
- Build a landing-page hero banner from a reusable "Slide" media library.
- Keep header imagery managed as media entities (reusable, translatable) rather than hard-coded blocks.
- Restrict who can change which menus are watched via a dedicated admin permission.
- Attach the DROWL media admin library so slideshow media preview correctly in the overview.
- Disable render-cache placeholdering on the slideshow blocks so an empty slideshow triggers the fallback.
- Provide language-aware slideshow references (fields are translatable).
- Theme the page-width menu slideshow block via the shipped `block--drowl-header-menu-slideshow-ref-block.html.twig` suggestion.
- Migrate an older DROWL Header Slides site forward (update hooks realign menus config and the admin view).
