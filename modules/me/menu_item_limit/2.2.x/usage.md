<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Item Limit lets you cap how many links a given menu may contain: you set a per-menu maximum on the menu's edit form, and a validation constraint blocks creating a new menu link once that menu is full.

---

The module adds an *"Item Limitation"* text field to the core Menu UI menu edit form (`menu_edit_form`). The number you enter is saved into the `menu_item_limit.settings` config object under a key equal to the menu's machine name (e.g. `menu_item_limit.settings:main = 5`); `0` (or empty) means unlimited. Enforcement is done with an entity validation constraint: `hook_entity_type_alter()` adds a `MenuItemOverLimit` constraint to the `menu_link_content` entity type, and `MenuItemOverLimitValidator` runs on save. The validator only checks **new** items (`$entity->isNew()`); for a new `menu_link_content` in a limited menu it loads the menu's link tree, counts the items, and if the count is already `>= limit` it adds the violation *"New link cannot be added because the menu item limit has been reached."* There is no admin settings page of its own (`configure` is `null`), no permission, no Drush command, and no config schema — the only state is the per-menu integer in `menu_item_limit.settings`. Note the limit is enforced against `menu_link_content` entities (menu links you add through the UI/content), not against module-defined `menu.links.menu` items.

---

- Cap a "Main navigation" menu at, say, 7 top-level links so the header stays tidy.
- Prevent editors from adding more than a fixed number of items to a footer menu.
- Keep a curated "Featured" menu limited to a handful of promoted links.
- Enforce an editorial policy of "no more than N items" per menu without custom code.
- Limit a social-links menu to a fixed set so the design doesn't break.
- Set different caps per menu (e.g. main = 8, footer = 4) from each menu's edit form.
- Leave a menu unlimited by setting its limit to 0 while capping others.
- Stop a menu from growing unbounded when multiple editors can add links.
- Show editors a clear validation error when a menu is full instead of silently overflowing.
- Apply a hard limit to a menu that feeds a fixed-width mega-menu component.
- Constrain a language-specific menu to the same size as its source menu.
- Guard a "quick links" block menu against clutter.
- Deploy per-menu limits through configuration (`menu_item_limit.settings`) across environments.
- Combine with Menu UI permissions so limited editors also cannot exceed the item cap.
- Keep an accessibility-sensitive navigation short by enforcing a maximum item count.
- Protect a performance-sensitive menu render from too many links.
- Limit the number of promotional entries in a campaign menu.
- Enforce a maximum on a menu that is exposed as a REST/JSON:API resource.
- Prevent accidental bulk additions from blowing past a menu's intended size.
- Roll out a menu-size governance rule site-wide by setting limits on each managed menu.
- Cap a taxonomy- or content-driven menu that editors extend by hand.
- Ensure a mobile menu stays within a usable number of entries.
- Standardise menu sizes across a multisite by exporting the limit config.
- Allow raising or lowering a menu's cap later by editing one field on the menu.
