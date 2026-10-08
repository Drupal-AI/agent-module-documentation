# Block Content Permissions — manual setup guide

**Block Content Permissions** (`block_content_permissions`) splits Drupal core's
single, coarse **Administer blocks** permission into granular, per-block-type
permissions for creating, editing, and deleting block content — plus a separate
permission for administering block content **types**.

Out of the box, core gates the whole custom block library (both block content and
the block types themselves) behind one `administer blocks` permission. That means
any editor who can place blocks can also create, edit, and delete *every* custom
block and *every* block type. This module fixes that: it adds dynamic per-bundle
permissions like *create <type> block content*, *update any <type> block content*,
and *delete any <type> block content*, along with two static permissions —
**Administer block content types** and **View restricted block content**.

Operationally, you enable the module and then grant these new, narrower permissions
per role instead of `administer blocks`. The module also filters the block content
listing so users only see the block types they're allowed to manage (unless they
hold *View restricted block content*), and it makes the listing's operation links
respect the new permissions.

Be clear about what this is: a pure **access-policy** layer. It has no configuration
UI, no routes, and no request-handling code of its own — it only tightens (never
loosens) core's block permissions. There is no anonymous or mutating endpoint and no
security-sensitive surface of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You grant its permissions on the standard
**People → Permissions** page (`/admin/people/permissions`), and you manage the
affected block content in the block library at **Content → Blocks**
(`/admin/content/block`).

## How to use it

1. After enabling, go to **People → Permissions**.
2. For each role, grant the specific new permissions it needs — for example
   *create <type> block content* for a role that should only add one block type —
   **instead of** the broad *Administer blocks* permission.
3. Grant **Administer block content types** only to roles that should manage block
   type structure, and **View restricted block content** to roles that should see
   the full block listing regardless of per-type access.

Because it's purely an access layer, the effect is immediate: the block library
listing and its create/edit/delete operations now respect exactly the permissions
you granted per role.
