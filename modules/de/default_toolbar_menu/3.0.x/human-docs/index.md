# Default Toolbar Menu — manual setup guide

**Default Toolbar Menu** (`default_toolbar_menu`) lets you decide which admin
toolbar menu each user *role* sees, and switches users to their assigned menu
automatically when they log in. It builds on the contributed
[Toolbar Menu](https://www.drupal.org/project/toolbar_menu) module, which lets
you expose any Drupal menu inside the admin toolbar.

On its own, Toolbar Menu can show several toolbar menus at once. Default Toolbar
Menu adds the missing piece: a **role → menu mapping**, so an editor role sees a
slim editorial menu while a developer role sees a fuller one, without every user
being shown every menu. This is handy for tidying up toolbar clutter and giving
each kind of user a navigation set that matches what they actually do.

The switching is applied at **login**. When a user logs in, the module resolves
their roles against your mapping and remembers the chosen menu for them; the
toolbar then activates that menu on the pages they view. Because the choice is
recorded at login, changing a role's mapping takes effect for a user on their
**next** login. Note that the *administrator* role cannot be assigned a default
menu — administrators keep core's standard Manage menu. The mapping is stored in
configuration, so it can be exported and deployed with the rest of your site
config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Toolbar Menu dependency).
2. [Configuration](configuration/index.md) — create toolbar menus, grant the
   right permissions, and map each role to a menu.

## Where it lives in the admin menu

Its settings form is at **Configuration → User interface → Default Toolbar
Menu** (`/admin/config/user-interface/toolbar_menu/setting`), gated by the
**set default toolbar menu for roles** permission.
