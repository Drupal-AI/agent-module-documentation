# Filter Permissions — manual setup guide

**Filter Permissions** (`filter_perms`) makes Drupal's **permissions page** far
easier to work with by adding two filters — **Roles to display** and **Modules to
display** — so you can narrow the enormous permissions grid down to just the
roles and modules you actually care about right now.

On a site with many modules, the permissions page at
`/admin/people/permissions` becomes a giant table with hundreds of rows and a
column per role. It's slow to scan and, on large sites, can even exceed PHP's
limit on how many form fields can be submitted at once — meaning you can't save
your changes. Filter Permissions solves both problems: pick a couple of roles and
a few modules, and the grid shrinks to just those, which is both readable and
safe to save.

The filter you choose is remembered for you personally for about an hour as you
work, so the page stays focused while you make a series of changes. Each
administrator has their own independent filter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. The filters appear right on the standard
permissions page: **People → Permissions**
(`/admin/people/permissions`). They also apply to the per-role permissions page
(the one you reach from a single role).

## How to use it

1. Go to **People → Permissions** (you need core's *Administer permissions*
   permission, as always).
2. At the top you'll see a **Permission Filters** section with two multi-select
   boxes:
   - **Roles to display** — choose the roles you want as columns (or *--All
     Roles*).
   - **Modules to display** — choose the modules whose permissions you want to
     see (or *--All Modules*). Only modules that define permissions are listed.
3. Click **Filter Permissions**. The grid redraws showing only the roles and
   modules you picked.
4. Adjust the permission checkboxes as usual and click **Save permissions**.

A few things to know:

- Until you've selected at least one role **and** one module, the permissions
  table stays empty with a prompt to filter — this is intentional.
- On very large sites, if the page would render more form fields than PHP's
  `max_input_vars` allows, the Save button is disabled and you'll see a message
  asking you to filter down first. Narrowing to fewer roles or modules brings the
  count back under the limit — which is the module's main purpose on big sites.
- Admin roles still show every permission checked and disabled, exactly as in
  core.
