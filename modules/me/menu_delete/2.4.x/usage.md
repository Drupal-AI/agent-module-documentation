<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Delete adds a per-row "Delete" checkbox and a "Delete selected" button to the core menu edit form, letting an administrator remove many menu links from a menu in one confirmed action instead of deleting them one at a time.

---

The module is UI-only and tiny: a single `hook_form_alter()` targets the core `menu_edit_form`, appends a **Delete** column with a checkbox on every menu link that is deletable (`$item->link->isDeletable()` — i.e. content menu links, not module-provided ones), and adds a **Delete selected** submit button. On submit it collects the checked links into the private tempstore (`menu_delete_item_confirm`, keyed by the current user id) and redirects to a confirmation form at `/admin/structure/menu/manage/{menu}/menu-delete-items` (route `menu_delete.multiple_delete_confirm`, gated by the core `administer menu` permission). The confirm form (`MenuDeleteItem`, a `ConfirmFormBase`) lists the selected link titles; on confirm it loads each `menu_link_content` entity by UUID via the entity repository and deletes it, then reports how many were removed and returns to the menu edit page. There is no configuration, no settings, no schema, no Drush command, and no new permission — it reuses core's `administer menu`. Only content (`menu_link_content`) links can be selected; links defined in code/`*.links.menu.yml` are not deletable and get no checkbox.

---

- Delete dozens of stale menu links from a menu in a single confirmed action.
- Clean up an imported/migrated menu that has many unwanted links.
- Bulk-remove old campaign or seasonal links from the main navigation.
- Trim a footer menu down to a handful of links without deleting each individually.
- Remove all custom links from a menu before repopulating it.
- Let editors with "administer menu" prune menus without developer help.
- Delete a contiguous batch of links after a site restructure.
- Quickly empty a test/scratch menu of its content links.
- Reduce clicks when decommissioning a section of the site (many links at once).
- Select only the specific links to delete via per-row checkboxes, leaving others intact.
- Review a confirmation list of link titles before committing the deletion.
- Avoid accidental deletion of code-defined links (they are never selectable).
- Bulk-delete links whose target content was already removed.
- Housekeep a mega-menu that accumulated redundant entries.
- Remove duplicate menu links created by repeated imports.
- Clear out a menu's content links prior to deleting the menu itself.
- Speed up editorial workflows that periodically refresh navigation.
- Delete selected links from any menu managed under Structure → Menus.
- Get a per-user-safe flow (selection stored in private tempstore) so concurrent admins don't collide.
- Confirm the count of deleted items via the on-screen status message.
