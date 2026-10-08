# Configuration

Page Menu Reorder needs two things set up: the **permission** that lets an editor
see and use the reorder tab, and the module's **settings form** for any options it
exposes.

## Grant the reorder permission

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the Page Menu Reorder permission and tick it for the roles that should be
   allowed to reorder menu links.
3. Save.

Because reordering navigation is normally part of menu administration — a
privileged task — grant this permission only to trusted editors. Its whole point
is to let those editors reorder links **without** giving them full access to the
global menu admin page.

## Open the settings form

The module provides a settings form at the config route
`page_menu_reorder.admin_settings`. Open it as a user with the **Administer site
configuration** permission to review the available options.

Out of the box the module works with the primary **Main navigation** menu. Save
any changes with **Save configuration**.

## Using it day to day

Once the permission is granted, editors visit a page that has menu links and use
the **Reorder menu** tab that appears there: drag the items into the order you
want and save. The change is applied to the menu immediately.
