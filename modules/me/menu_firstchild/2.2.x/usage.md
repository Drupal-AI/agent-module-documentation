<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Firstchild lets you create a parent menu link that has no path of its own and instead resolves, at render time, to the URL of its first viewable child menu item.

---

The module adds a **"First child"** checkbox to the `menu_link_content` add/edit form
(`hook_form_menu_link_content_form_alter`). When ticked, the link's path input is disabled and
its stored URI becomes `route:<none>`, and the flag is persisted in the menu link's **link-field
options** as `options['menu_firstchild']['enabled'] = TRUE`. At render time
`hook_preprocess_menu()` runs every item through the `menu_firstchild.menu_item_parser` service
(`MenuItemParser`), which — for enabled items — loads the item's child menu tree (access-checked
and sorted), takes the first viewable child (recursively, so a first child that is itself a
first-child link resolves deeper), and rewrites the parent item's `url` to that child's URL. It
also adds a `menu-firstchild` CSS class to the item and preserves any title attribute. If no
viewable child exists, the item falls back to `route:<none>` (an unlinked item). The module has
no configuration page, no permissions, no Drush commands, and no config schema; its only
persistent state is the per-link option. A single hook, `hook_menu_firstchild_item_alter()`,
lets other modules adjust the generated item.

---

- Create a top-level "Products" menu parent that opens its first product page when clicked.
- Build a dropdown menu whose hover-parent has no page of its own but still links somewhere useful.
- Avoid dead `<nolink>` parents by pointing them at their first child automatically.
- Make a section landing link always follow the first item in that section as content changes.
- Keep a parent link in sync with its children without manually updating its path.
- Link a mega-menu column heading to the first entry beneath it.
- Chain first-child links so a parent resolves through several levels to a real page.
- Respect access: the parent resolves only to children the current user may view.
- Add the `menu-firstchild` class to style first-child parents differently in a theme.
- Provide a routeless parent that gracefully becomes unlinked when it has no viewable children.
- Convert an existing pathless menu item into a first-child link by ticking one checkbox.
- Reorder children and have the parent's destination update automatically to the new first child.
- Use on any menu (main, footer, custom) since it acts on `menu_link_content` links.
- Preserve a custom title/tooltip on the parent while redirecting to the child URL.
- Alter the generated parent item (e.g. add a class or attribute) via `hook_menu_firstchild_item_alter()`.
- Simplify editorial workflows where editors add child pages but shouldn't maintain parent paths.
- Build breadcrumb-friendly navigation where parents point into their section.
- Support multilingual menus (the option is carried per translation-affected link).
- Replace custom preprocess code that manually rewrote parent menu URLs.
- Keep navigation working when a section's landing page is retired but children remain.
