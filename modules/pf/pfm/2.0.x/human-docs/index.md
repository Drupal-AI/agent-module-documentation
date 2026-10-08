# Permissions filtered by modules — manual setup guide

**Permissions filtered by modules** (`pfm`) adds a friendlier permissions administration
page for sites that have grown too many modules and roles to manage comfortably on the core
grid. Drupal's standard permissions page lists every permission for every role in one giant
table; on a big site that's slow to load and a chore to scroll. This module gives you a second
permissions page with **AJAX filters** so you can narrow the grid to just the modules and roles
you actually care about right now.

Importantly, it does **not** replace or alter Drupal's core permissions page — the usual
`/admin/people/permissions` stays exactly as it is. Instead it adds an *additional* page at
**People → PFM Permissions** with a "Permissions Filters" panel at the top. Pick one or more
modules and the roles you want to see, and the table redraws (over AJAX, no full reload) to show
only those permissions and only those role columns. The grid stays small and focused.

Because the page extends Drupal's own permissions form, everything you'd expect still works:
saving uses core's normal save logic, administrator roles still show every box checked and
disabled, and security-sensitive ("restrict access") permissions still display the standard
"give to trusted roles only" warning. Access to the page is governed by the same core *Administer
permissions* permission as the standard page. The module has **no settings of its own** — the
filtered page *is* the feature — and no dependencies. If you also run the **Permissions Dragcheck**
module, its drag-to-check behavior is layered onto the filtered grid automatically.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

The filtered page sits at **People → PFM Permissions** (`/admin/people/pfm-permissions`). You
need the core *Administer permissions* permission to open it — the same gate as the standard
permissions page. The core permissions page remains at **People → Permissions** and is
untouched.

## How to use it

1. Go to **People → PFM Permissions**.
2. In the **Permissions Filters** panel at the top, use **Select Modules** to choose one or
   more modules whose permissions you want to see. Until you pick at least one module, the table
   is empty and prompts you to choose one — this is what keeps the page fast.
3. Optionally use **Select Role** to limit the visible columns to specific roles (or leave it on
   **All Roles**). This is handy when you're only editing one custom role.
4. The permissions table refreshes over AJAX to show just the selected modules' permissions and
   the selected roles' columns.
5. Tick or untick permissions as usual and click **Save permissions**. Saving works exactly like
   the core page.

### Handy things to do with it

- **Set up a new module's permissions** by selecting just that module right after installing it.
- **Edit one role in isolation** by selecting only that role's column, avoiding accidental changes
  to unrelated permissions.
- **Audit** which roles hold a given module's permissions by filtering to that module during a
  security review.

### A couple of notes carried over from core

- Administrator roles show all permissions checked and disabled (they always have everything).
- The `access content` permission appears under the **Node** module group — this mirrors a
  presentational quirk of the core permissions UI even though System actually provides it.
