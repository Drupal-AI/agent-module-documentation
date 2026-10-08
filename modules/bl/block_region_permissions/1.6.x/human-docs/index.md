# Block Region Permissions — manual setup guide

**Block Region Permissions** (`block_region_permissions`) breaks Drupal's
all‑or‑nothing block administration into one permission *per theme region*. Out
of the box, core gates the entire **Block layout** page behind a single
permission — "Administer blocks" — which lets whoever holds it place, move,
configure, and delete blocks in every region of every theme. This module lets
you hand a role the keys to just the Content and Sidebar regions, say, while
keeping the Header, Footer, and admin regions off‑limits.

It works by reading each enabled theme's regions and generating a permission for
every one — machine name `administer {theme} {region}`, titled
"Administer: *Theme* - *Region*" (for example "Administer: Olivero - Header").
New regions and newly enabled themes get their permissions automatically, so
there is nothing to configure. Enforcement is real, not just cosmetic: the module
hides block rows and region options a user cannot administer, and it adds
server‑side access checks to the block edit and delete routes so a crafted URL is
denied too. It has no settings form, no dependencies beyond core's **Block**
module, and applies the moment you enable it and grant the permissions.

One important caveat: core's "Administer blocks" permission is still required to
reach the Block layout page at all, and on its own it exposes a few block pages
this module does not manage (enable/disable, the place‑block library). To lock
those down as well, the project recommends pairing it with
[Block Content Permissions](https://www.drupal.org/project/block_content_permissions).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. Everything happens on the standard permissions screen
at **People → Permissions** (`/admin/people/permissions`), and the restrictions
take effect on **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions**. Search for permissions named
   "Administer: *Theme* - *Region*" — there is one for every region of every
   enabled theme.
3. For the role you want to delegate to, tick the specific regions it may manage
   (for example "Administer: Olivero - Content" and "Administer: Olivero - First
   sidebar"), and leave the rest unchecked.
4. Because core still guards the page itself, also grant that role the core
   **"Administer blocks"** permission — without it they cannot reach Block layout
   at all. The module then filters the page down to the regions you allowed.
5. Save permissions. On the Block layout page, that role now sees and can edit
   blocks only in the regions you granted; region drop‑downs on block forms are
   likewise limited, and direct URLs to edit or delete a block in a forbidden
   region are denied.

You can also grant these permissions from the command line, e.g.
`drush role:perm:add editor 'administer olivero content'` (remember to also grant
`'administer blocks'`).

For the strongest lock‑down, add
[Block Content Permissions](https://www.drupal.org/project/block_content_permissions)
so the remaining block pages that "Administer blocks" exposes are restricted too.
