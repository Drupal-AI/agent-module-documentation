# Roles Nested — manual setup guide

**Roles Nested** (`roles_nested`) gives you a draggable admin screen for
arranging your site's user roles into a parent/child tree. If your role list has
grown long and unwieldy, you can drag roles under one another to group them —
for example placing "Editor" and "Author" beneath a "Content team" role — so the
list reads as an organized hierarchy instead of a flat pile.

The one thing to understand clearly before you rely on it: the nesting is
**organizational only**. Roles Nested stores and displays the arrangement, but it
does **not** make a child role inherit its parent's permissions. There is no
permission-inheritance logic in the module. Permissions are still assigned
per‑role through Drupal core exactly as before, and a role placed under another
gains nothing from that placement.

Because of this, do not treat the tree as an access‑control feature. If you nest
"Editor" under "Administrator", the Editor role does **not** quietly pick up
administrator permissions — but neither should anyone assume it does. Keep
granting and reviewing permissions on the normal core **People → Permissions**
screen; use Roles Nested purely to keep a large role list tidy and easy to scan.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings form** for this module. The one screen it adds is
the drag‑and‑drop role arranger described below.

## Where it lives in the admin menu

Once enabled, the arranger lives under **People → Roles Nested**
(`/admin/people/roles-nested`).

## How to use it

1. Go to **People → Roles Nested** (`/admin/people/roles-nested`).
2. Drag each role's handle to place it under (or beside) another role, building
   the tree you want.
3. Save the arrangement.

That's the whole workflow. Remember that the result is a visual/organizational
map of your roles — nothing about who can do what changes as a result.
