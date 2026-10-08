<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Parent Link Search makes the often-huge "Parent link" select dropdown on menu-link forms searchable: it injects a small text field and Highlight button that find, highlight and jump to matching options while keeping the menu hierarchy intact.

The module is a single `hook_form_alter` that, whenever a form contains `$form['menu']['link']['menu_parent']`, renders a textfield (`#id` `search_parent_link`) plus a Highlight button into that element's `#description` and attaches the `parent_link_search/parent_link_search` library (JS + CSS) that performs the client-side search and highlighting. There is no configuration, no route, no permission, and no server-side processing — it purely enhances the admin editing experience. Unlike select2-based alternatives it needs no third-party library and preserves parent/child structure so you can still see ancestors of a match.

Operational notes: it activates automatically on any form exposing the standard `menu_parent` element (menu link add/edit, and the menu settings on node forms). The highlight colour is not currently adjustable.
---
Add a searchable highlight box to the menu-link Parent select dropdown so large menus are navigable.
---
- Search the Parent link dropdown by typing into the injected field.
- Click Highlight to jump to the first matching menu option.
- Keep menu hierarchy visible while searching (unlike select2).
- Use it on the menu link add form.
- Use it on the menu link edit form.
- Use it in the Menu settings section of a node edit form.
- Enable the module with no configuration required.
- Avoid adding a third-party JS library (none needed).
- Find deeply nested menu items in very large menus quickly.
- Locate a parent item without scrolling the entire select list.
- Rely on automatic activation wherever `menu_parent` appears.
- Attach the bundled JS/CSS only on forms that have the menu element.
- Highlight matches inline via the `parent_link_found` marker span.
- Improve editor UX on sites with hundreds of menu links.
- Uninstall cleanly — it adds no data, config or schema.
- Pair with core Menu UI (no extra dependencies).
- Note the highlight colour is fixed (not configurable).
