# Configuration

There is no settings form for this module — its entire "configuration" is
deciding **which roles may open the read‑only permissions grid**, and then
understanding what that grid shows. This page walks through both.

## Grant the view‑only permission

1. Log in as a user with **Administer permissions** (an administrator by
   default).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the permission this module adds (its name refers to viewing the
   permissions list). Tick it for each role that should be able to *see* the
   grid — for example an *Auditor*, *Content manager*, or *Support* role.
4. Click **Save permissions**.

That is deliberately the safe part: the roles you tick here gain the ability to
**view** the permissions matrix, but not to change it. You do **not** need to
give them *Administer permissions* (which is the powerful right that unlocks the
editable page and lets someone rewrite the site's access rules). Keep
*Administer permissions* reserved for trusted administrators only.

## What the view‑only page shows

Once a user has the permission, they open the read‑only grid from a tab in the
**People** area, next to the standard *Permissions* tab. On it they see:

- The **same permissions‑per‑role matrix** as the core page — every permission
  listed down the side, every role across the top.
- A **checkmark (✓)** wherever a role has been granted a permission. Ungranted
  cells are simply blank. There are **no checkboxes** and **no Save button**, so
  nothing on this page can alter a grant.
- The **filter/search controls** provided by the required Filter Permissions
  module, so a reviewer can narrow the (often very long) list by keyword or by
  module while they audit it — all without any editing capability.

## A note on what this gates

This module is an access‑control convenience: it lets you delegate *visibility*
of the permissions configuration without delegating *control* of it. Because the
page is strictly read‑only, granting its permission carries far less risk than
granting *Administer permissions*. Still, the permissions matrix reveals how your
site's access model is put together, so grant the view‑only permission only to
roles you are comfortable seeing that information.
