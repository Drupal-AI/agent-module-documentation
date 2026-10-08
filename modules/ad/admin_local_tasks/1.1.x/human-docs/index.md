# Admin Local Tasks — manual setup guide

**Admin Local Tasks** (`admin_local_tasks`) changes how Drupal's **local‑task tabs**
are displayed. Local tasks are the row of tabs you see at the top of entity pages —
*View*, *Edit*, *Delete*, and similar — and this module overrides their core styling
with a fixed presentation, so those tabs look consistent across your admin and
editorial screens.

It is purely a presentation adjustment for the local‑task tabs. It does not change the
tabs' behaviour or which tabs appear: the local tasks still reflect each user's own
permissions, so nobody gains access to anything they could not already reach. Think of
it as a small theming tweak for the tab strip.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has a small settings entry (`admin_local_tasks.settings`) for the tab style
and provides its own permission, so you can control which roles the restyling applies
to under **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. The fixed tab styling is applied to local‑task tabs automatically.
3. If you want to limit who sees the restyled tabs, adjust the module's permission on
   the **People → Permissions** page.

Because the change is cosmetic, the safest way to judge it is simply to open an entity
page (for example a node) and look at the *View / Edit / Delete* tab strip after
enabling.
