# Menu Delete — manual setup guide

**Menu Delete** (`menu_delete`) solves a small but real annoyance: core Drupal
only lets you delete menu links one at a time. If you've imported a menu, run a
seasonal campaign, or restructured a section of the site, clearing out a pile of
old links means a lot of repetitive clicking. Menu Delete adds a **Delete**
checkbox to every deletable link on the menu edit form and a **Delete selected**
button, so you can tick as many as you like and remove them all in one confirmed
step.

The module is intentionally tiny and UI-only. It doesn't add settings, config, a
permission, or a Drush command — it simply reuses core's existing **Administer
menus and menu links** permission and hooks into the standard menu edit form.
Only *content* menu links (the ones editors create, stored as
`menu_link_content` entities) get a checkbox; links defined in code by modules
can't be deleted this way, so they're never selectable and stay safe.

When you click **Delete selected**, the module takes you to a confirmation page
listing the titles of everything you picked. Nothing is removed until you
confirm, and your selection is held per user, so two administrators tidying
menus at the same time won't step on each other.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Menu Delete adds no menu items and has no settings page. It works right on the
existing menu editing screens at **Structure → Menus**
(`/admin/structure/menu`) — the extra checkboxes and button appear when you edit
any menu.

## How to use it

1. Go to **Structure → Menus** and click **Edit menu** on the menu you want to
   tidy (`/admin/structure/menu/manage/{menu}`).
2. You'll see a new **Delete** column with a checkbox next to every content menu
   link. (Links that Drupal or a module defined in code don't get a checkbox and
   can't be bulk-deleted.)
3. Tick the links you want to remove.
4. Click **Delete selected**. You're taken to a confirmation page listing the
   titles of the links you chose.
5. Review the list and click **Delete** to confirm. Menu Delete removes each
   selected link and shows a message reporting how many were deleted, then
   returns you to the menu edit page.

You need the **Administer menus and menu links** permission (which
administrators have by default) — the same permission core requires for editing
menus, so if you can edit a menu you can bulk-delete its links.
