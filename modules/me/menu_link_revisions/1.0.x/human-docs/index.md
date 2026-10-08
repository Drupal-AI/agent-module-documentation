# Menu Link Revisions — manual setup guide

**Menu Link Revisions** (`menu_link_revisions`) brings Drupal's revision system to
menu links, giving them the same kind of history and rollback you already get with
node revisions. Every change to a menu link is tracked, so you can review who
changed what and revert to an earlier version when something goes wrong.

The problem it solves is menu governance. On a busy site, navigation gets edited
often — links renamed, moved, disabled — and a mistaken change can quietly break a
key part of the site's structure with no easy way to see what it used to be. With
this module you get a full revision history for each menu link, the ability to
revert to any previous version, and draft/published handling built on the existing
"enabled" field. It's aimed at content teams that need accountability and a safety
net around their navigation.

It depends on core's **Menu Link Content** and **Menu UI** modules and provides
granular permissions so you can control who may view and revert menu‑link
revisions. There's no central settings page; the revision controls appear on the
menu links themselves, much like the *Revisions* tab on a node.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. Revision handling appears on
the menu links themselves, described in "How to use it" below.

## How to use it

1. Go to **People → Permissions** (`/admin/people/permissions`) and grant the
   module's menu‑link revision permissions to the roles that should be able to view
   and revert revisions.
2. Edit menu links as you normally would at **Structure → Menus**
   (`/admin/structure/menu`). Each save records a new revision.
3. To review or roll back changes, use the link's revision history — where you can
   compare earlier versions and revert to any of them, just as you would with node
   revisions. Use the "enabled" state to keep draft versus published links.
