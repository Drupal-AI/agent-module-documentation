<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Delete — agent index

Adds bulk deletion of menu links to the **core menu edit form**: a per-row **Delete**
checkbox + a **Delete selected** button → a confirmation page that deletes the chosen
`menu_link_content` entities. UI-only. No config, no schema, no Drush, no new permission
(reuses core `administer menu`).

- **How the bulk-delete flow works, the route, permission, and how to delete menu links programmatically** →
  [configure/bulk-delete.md](configure/bulk-delete.md)

Key facts:
- Works by `hook_form_alter()` on `menu_edit_form`; a checkbox appears only on links where `$item->link->isDeletable()` (content links, not code-defined ones).
- Confirm route: `menu_delete.multiple_delete_confirm` → `/admin/structure/menu/manage/{menu}/menu-delete-items`, permission `administer menu`.
- Selected links are stashed in private tempstore `menu_delete_item_confirm` (per user), then deleted by UUID as `menu_link_content` entities.
- There is no Drush command in this version — deletion is via the UI (or core entity API in code).
