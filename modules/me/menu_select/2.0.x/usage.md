<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Select replaces the core "Parent item" drop-down on menu-link and node menu-settings forms with an expandable, clickable menu hierarchy plus an optional autocomplete search, making it practical to pick a parent on sites with large menus.

---

The module decorates core's `menu.parent_form_selector` service (`MenuSelectParentFormSelector` extends `MenuParentFormSelector`) so that everywhere Drupal renders the parent-item `<select>` — the node edit form's "Menu settings" section and the `/admin/structure/menu` link edit forms — it instead renders a custom `menu_select_tree` render element. That element builds a nested `item_list` of every menu and every link (respecting the same node-access/access/sort manipulators core uses), rendered as an expandable tree the editor navigates and clicks; a hidden `menu_parent_id` field stores the chosen `menu_name:plugin_id` value, so the value the form submits is identical to what core's select would have submitted. When `search_enabled` is on and the user holds the `use menu select search` permission, the element also shows an autocomplete textfield backed by the `menu_select.menu_select_autocomplete` route, which case-insensitively matches link titles across the offered menus up to the parent depth limit. The only configuration is a single boolean, `menu_select.settings:search_enabled`, edited at `/admin/config/content/menu_select`. Rendering is done as raw markup strings (not link objects) for speed on very large menus, and depth is bounded by core's existing parent-depth limit for the edited link. There is no new field type, formatter, or plugin type — it is purely a widget-level replacement of the parent selector.

---

- Replace the unwieldy flat "Parent item" drop-down on a node edit form with a browsable tree when a menu has hundreds of links.
- Let editors expand and collapse menu branches to find the right parent instead of scrolling a long `<select>`.
- Give editors a preview of a menu link's hierarchical position before saving.
- Add an autocomplete search box so editors can type a parent link's title and jump to it.
- Restrict the parent search feature to trusted roles via the `use menu select search` permission.
- Turn the search box off site-wide (tree only) by disabling `search_enabled` for a simpler UI.
- Improve the parent-selection UX on the `/admin/structure/menu/manage/*` link add/edit forms.
- Standardise parent selection across every menu on the site without touching each menu form.
- Pick a parent link that lives in a different menu than the one currently being edited (all offered menus are shown).
- Avoid a custom widget or theme override just to make the parent selector usable on big menus.
- Keep the submitted value format (`menu_name:menu_link_plugin_id`) identical to core so nothing downstream changes.
- Respect node access when listing candidate parent links, so editors only see links they may reach.
- Prevent a menu link from being offered as its own parent (the current link is excluded from the tree).
- Speed up parent selection on large menus by rendering links as plain markup rather than heavy render arrays.
- Configure the search toggle once at `/admin/config/content/menu_select` and deploy it via exported config.
- Grant the search permission only to editors and revoke it from anonymous/authenticated roles (it is `restrict access: true`).
- Provide a friendlier parent-picker for content teams unfamiliar with Drupal's menu machine names.
- Keep parent selection working within core's parent depth limit for the link being edited.
- Reuse the `menu_select.tree_builder` service programmatically to build a rendered, access-filtered menu tree in custom code.
- Offer editors the same access/sort behaviour as core's default parent select, just in a nicer widget.
- Reduce mis-parented links caused by editors guessing at truncated titles in a native select.
