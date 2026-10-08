# Menu Per Role — manual setup guide

**Menu Per Role** (`menu_per_role`) lets you control the **visibility of
individual menu links** based on a user's roles. Once enabled, editing a menu link
shows a new fieldset where you can say which roles may see the link, or which roles
should have it hidden. It's the classic tool for menus like a "My account" block
that should only appear for logged-in users, or a "New here? Register" menu that
should vanish once someone signs in.

One thing to be crystal clear about: this module changes **only the visibility of
menu links**, not access to the pages they point to. Hiding a link does not
protect its destination — a user who knows or guesses the URL can still reach it.
If you need to actually restrict a page, use node access or permissions on the
target instead. In fact the module's own documentation notes that many sites don't
really need it: core already hides a menu link when the current user can't access
its target route. Menu Per Role earns its place for the cases core doesn't cover —
external links (always considered accessible), and menus you want to hide even
though their targets remain reachable.

A second limitation: Menu Per Role only acts on **content menu links**
(`menu_link_content` entities — the ones you add and edit in the menu UI). Links
defined in code (via `*.links.menu.yml`) or by Views cannot be managed by this
module. It depends on core's **Menu Link Content** module and has **no
submodules**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set permissions.
2. [Configuration](configuration/index.md) — the global settings and the per-link
   role fields where the actual restriction happens.

## Where it lives in the admin menu

Menu Per Role's global settings form is at **Configuration → System → Menu Per
Role** (`/admin/config/system/menu_per_role`, route `menu_per_role.settings`),
gated by the **Administer Menu Per Role settings** permission. The real work,
though, happens on **each menu link's own edit form**, where the role fields
appear.

## How to use it

Edit a menu link as usual (from **Structure → Menus**, or from a node's menu
settings). You'll see one or two fieldsets of role checkboxes — "Roles able to see
the menu link" and/or "Roles not able to see the menu link." Tick the roles you
want, save, and the link's visibility in the menu tree updates accordingly.
