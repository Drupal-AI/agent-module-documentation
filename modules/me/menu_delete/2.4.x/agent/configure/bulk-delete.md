<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk-deleting menu links

Menu Delete has **no settings**. It only adds a bulk-delete flow to the core menu edit form.

## The UI flow

1. Go to **Structure → Menus** and click **Edit menu** on a menu
   (`/admin/structure/menu/manage/{menu}`). This is core's `menu_edit_form`.
2. Menu Delete adds a **Delete** column: a checkbox on every **deletable** link. A link is
   deletable when `$item->link->isDeletable()` is TRUE — that means **content menu links**
   (`menu_link_content` entities). Links defined in code (`*.links.menu.yml`) are not
   deletable and show no checkbox.
3. Tick the links to remove, then click **Delete selected**.
4. You are redirected to the confirm form at
   `/admin/structure/menu/manage/{menu}/menu-delete-items`
   (route `menu_delete.multiple_delete_confirm`, permission **`administer menu`**), which
   lists the selected link titles.
5. Click **Delete**. Each selected link is loaded by UUID and deleted; a status message
   reports "Deleted N menu items." and you return to the menu edit page.

## Under the hood

- `hook_form_alter()` on `menu_edit_form` injects the checkboxes and the `Delete selected`
  button (submit handler `menu_delete_edit_form_submit`).
- The submit handler writes the chosen items into **private tempstore**
  `menu_delete_item_confirm`, keyed by the current user id, then redirects to the confirm
  route. (So two admins pruning at once don't clobber each other.)
- `MenuDeleteItem` (a `ConfirmFormBase`) reads that tempstore, and on confirm does
  `entityRepository->loadEntityByUuid('menu_link_content', $uuid)->delete()` per item.

## Deleting menu links in code / scripting

Menu Delete adds **no API or Drush command**; programmatic deletion is plain core entity
work on `menu_link_content`:

```php
// Delete all content links in a given menu (e.g. 'main').
$ids = \Drupal::entityTypeManager()->getStorage('menu_link_content')
  ->getQuery()->accessCheck(FALSE)
  ->condition('menu_name', 'main')
  ->execute();
$storage = \Drupal::entityTypeManager()->getStorage('menu_link_content');
$storage->delete($storage->loadMultiple($ids));
```

Only `menu_link_content` links can be deleted this way (matching what the module's checkbox
offers); core-defined links live in the router, not this storage.
