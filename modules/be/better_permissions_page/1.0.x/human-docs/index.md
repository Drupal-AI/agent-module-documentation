# Better permissions page — manual setup guide

**Better permissions page** (`better_permissions_page`) replaces Drupal's core
permissions form at `/admin/people/permissions` with a faster one that shows only
**one module's permissions at a time**, chosen from a select list. On large sites
with hundreds or thousands of permissions, the core page — which renders every
permission of every module in a single giant table — can become slow or even
produce a white-screen-of-death timeout. This module fixes that.

It works by quietly swapping the form on the existing permissions route: the URL
stays the same (`/admin/people/permissions`), so bookmarks and links keep working,
but the page now shows a **Permission provider** select. Pick a module and only
that module's permission rows are loaded (via AJAX) into the roles table — you
never render the full list. Saving uses exactly the same core mechanism as the
stock page, so grants and revocations are written identically; admin roles keep
their checkboxes disabled-and-checked just as in core.

This is a genuinely drop-in module. It has **no configuration page, no settings,
no permissions of its own, no Drush commands, and no plugins** — enabling it
immediately upgrades the permissions page. It works on Drupal 9.5, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That is the entire setup.

## How to use it

There is nothing to configure. After enabling the module:

1. Go to **People → Permissions** (`/admin/people/permissions`) as a user with the
   core **Administer permissions** permission.
2. Use the **Permission provider** select at the top to choose a module (for
   example *Node*).
3. Only that module's permissions load into the roles table. Set the checkboxes
   for each role as usual.
4. Click **Save permissions**. The page returns to the permissions form, scrolled
   to the module you were working on.

Switch the provider select to manage another module's permissions. Because access
is unchanged from core, anyone who could manage permissions before still can — they
just no longer wait for the browser to render the entire list.
