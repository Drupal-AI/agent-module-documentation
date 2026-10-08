<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Toolbar Content reshapes the content-facing parts of the Admin Toolbar: it expands the "Content" menu into a per-content-type tree with Add and Recent-items links, and adds top-level Categories, Media, Menus and Webform-submissions menus, all toggleable per area.

---

Admin Toolbar (with its `admin_toolbar_tools` submodule) turns Drupal's toolbar into full drop-downs but leaves content administration as a single filtered "Content" link. This module rebuilds those content areas through a set of `AdminToolbarContent` plugins — one per area, each switchable in config at `/admin/config/user-interface/admin-toolbar-content` (permission `administer site configuration`). The `content` plugin gives every content type its own entry (filtered listing, an "Add new" link, and a configurable number of "Recent items" that link to the edit form, canonical view, or Layout Builder), and can hide types by permission or by absence from the `content` view's type filter. The `categories` plugin splits taxonomy into a content-editor-friendly "Categories" menu (terms) separate from Structure (vocabularies); `media` adds a "Media" menu that can jump straight to the Media Library plus a Files link; `menus` lists all menus; `webform` lists webforms and links to their submissions; and `drupal` adds account links under the Drupal icon. Items can be grouped into nested collections via `hook_admin_toolbar_content_collections`, and per-content-type views named `content_<type>` are automatically substituted for the core content view to give each type custom exposed filters. Recent-item links are resolved per viewer with an access-checked query, and every generated link inherits the access of its target route. Requires both `admin_toolbar` and `admin_toolbar_tools`; core `^10.2 || ^11`.

---

- Give each content type its own toolbar entry instead of one generic "Content" link.
- Jump from the toolbar straight to a content type's filtered listing.
- Add a node of a specific type in one click via the per-type "Add new" link.
- Show the last N edited nodes of each type as "Recent items" for fast re-editing.
- Point recent-item links at the canonical view instead of the edit form.
- Send recent-item links into Layout Builder for layout-heavy sites.
- Cap or disable recent items (set to 0) to keep the menu light on large sites.
- Hide content types an editor has no administrative permission on.
- Hide content types missing from the content view's exposed type filter.
- Strip non-content items out of the Content menu for a cleaner editor view.
- Split taxonomy so editors manage terms under "Categories" while vocabularies stay in Structure.
- Add an "Add new term" shortcut per vocabulary from the toolbar.
- Add a top-level "Media" menu that opens the Media Library directly.
- Reach the Files overview from the Media menu.
- List every media type with a per-type "Add" link.
- List all menus with direct edit links from a "Menus" toolbar item.
- List webforms and jump to each form's submission results.
- Add "My account" / "Edit my account" links under the Drupal icon.
- Group content types (or other items) into named, nested collections.
- Push grouped collections to the top or bottom of a menu, or hide empty ones.
- Give each content type a custom listing by creating a `content_<type>` view.
- Turn the generic "Add content" button on /admin/content into "Add <type>".
- Extend the toolbar from another module by writing an `AdminToolbarContent` plugin.
- Tailor the admin toolbar to an editorial workflow without the Shortcut module.
- Pair with the Gin admin theme for a polished content-admin toolbar.
