# Menu Per Role — manual setup guide

**Menu Per Role** (`menu_per_role`) controls the visibility of individual menu
links by user role. It adds two role selectors — "Roles able to see the menu link"
and "Roles not able to see the menu link" — to menu links, so you can build a
single shared menu whose items appear differently to different audiences: show a
"Members area" link only to members, hide an "Admin dashboard" link from everyone
but staff, keep beta‑feature links visible only to testers.

Under the hood it adds two fields to content menu links and enforces them by
hooking into Drupal's menu access checking — when a link's rules don't match the
current user, the link is hidden. Leaving both selectors empty keeps a link's
default visibility, so it only ever *restricts* access, never grants it. A global
settings form lets you decide which of the two selectors editors see, whether the
fields appear on links that point to nodes (useful alongside Node Access modules),
and whether administrators bypass the checks on the front end and/or in the admin
area. Three permissions control access to the settings form and let specific
non‑admin roles bypass the restrictions separately for the front and admin
contexts. Everything is built to cache correctly per role and context.

One scope limit to know up front: Menu Per Role only affects **content menu
links** (the `menu_link_content` entities you create in the menu UI or a node's
menu settings). Links defined in configuration — for example by Views — or in a
module's `*.links.menu.yml` file cannot be managed by this module. It requires
only core's **Menu Link Content** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the base fields,
the access decorator, and cache contexts — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form, the
   per‑link role selectors, and the permissions.

## Where it lives in the admin menu

The global settings form is at **Configuration → System → Menu Per Role**
(`/admin/config/system/menu_per_role`). The actual per‑link restrictions are set
when you edit a menu link — under **Structure → Menus**, or on a node's menu
settings. Permissions are at **People → Permissions**.

## How to use it

Enable the module, then edit any menu link and use the "able to see" / "not able
to see" role selectors to restrict it. Adjust the global settings and permissions
to taste — see [Configuration](configuration/index.md) for the full walkthrough.
