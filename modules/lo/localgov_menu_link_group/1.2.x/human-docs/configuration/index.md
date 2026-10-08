# Configuration

You configure this module by creating **menu link groups**. Each group is a small
config entity that says "make a new grouping link here, and move these existing links
under it."

## Open the group list

1. Log in as a user who can administer menus.
2. Go to **Structure → Menus → LocalGov menu link group**, or navigate directly to
   `/admin/structure/menu/localgov_menu_link_group`. You'll see the list of groups
   with **Add**, **Edit**, and **Delete** actions.

## Create a group, field by field

Click **Add** and fill in:

- **Group label** — the text shown on the new grouping link (for example
  "Site settings" or "Content tools").
- **Weight** — where the group sits relative to its siblings; lower weights sort
  higher.
- **Parent menu** — which menu the group belongs to (for example the *Admin* menu,
  or a front-end menu).
- **Parent menu link** — the existing menu link the group hangs beneath. Leave it at
  the top level, or nest the group under another link.
- **Child menu links** — the existing links to move under this group. Links are
  identified by their **plugin ID** (for example `system.admin_content`). Pick the
  links you want gathered here.

Save the group. The listed links are re-parented under your new grouping link, and
the menu is rebuilt straight away so you'll see the change immediately.

## How the automatic hiding works

The grouping link has no page of its own, so the module protects you from showing an
empty group: when a menu is rendered, it checks each of the group's children and, if
the current user cannot reach *any* of them, it drops the whole group from the
rendered menu. You don't configure this — it just happens. (Note that the filtering
happens at render time, so the group still exists in the underlying menu data; code
that reads the menu tree directly would need to filter for itself.)

## Editing, disabling, and deleting

- **Edit** a group to change its label, position, or child links — the menu rebuilds
  on save.
- **Disable** a group (via its status flag) to switch the grouping off temporarily
  without deleting it.
- **Delete** a group and its children return to their original parents.

## A note on performance

Saving a group rebuilds *all* menu links, which is not free on a large site. If you
are making several changes, edit groups deliberately rather than saving many in a
tight loop.

## Finding a link's plugin ID

Child links are referenced by plugin ID. If you're not sure of an ID, you can list
them all from the CLI:

```bash
drush php:eval 'print implode("\n", array_keys(\Drupal::service("plugin.manager.menu.link")->getDefinitions()));'
```
