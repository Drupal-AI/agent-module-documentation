# Imce Multiple Roles Folders — manual setup guide

**Imce Multiple Roles Folders** (`imce_multiple_roles_folders`) changes one small
but important detail of how the [IMCE](https://www.drupal.org/project/imce) file
browser decides which folders a person may see. Out of the box, IMCE resolves a
user's folder access from a single IMCE profile. This module makes that resolution
**additive**: when a user has more than one role, it *merges* the folder
permissions granted by each of their roles, so the user gets the combined (union)
set of folders that all of their roles allow — not just one role's folders.

That is the whole feature. There is no settings form and nothing to click through
after enabling it. It simply hooks into IMCE's access model and does the merging
automatically. All of the actual folder rules still live in IMCE itself, under its
role/profile configuration.

Because access becomes a union, it is worth thinking about it as a mild security
consideration when you design your IMCE profiles: a multi-role user can reach *any*
folder that *any* of their roles can reach. Make sure no single role grants access
to a folder you would not want a broadly-roled user (for example an editor who also
holds a second role) to open.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside IMCE.

There is **no configuration page** for this module. It has no settings form of its
own; all folder rules are configured in IMCE. See "How to use it" below.

## Where it lives in the admin menu

This module adds no admin page. You manage everything from IMCE's own screens at
**Configuration → Media → IMCE File Manager** (`/admin/config/media/imce`), where
you assign IMCE profiles to roles and define each profile's folders.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In **IMCE File Manager** settings, create the IMCE profiles you need and assign
   them to roles, defining the folders each profile may browse.
3. From then on, any user with multiple roles automatically receives the union of
   the folders their roles' profiles allow — no extra step is required.

Keep the union behavior in mind: review your profiles so that combining two roles
never opens a folder you intended to keep restricted.
