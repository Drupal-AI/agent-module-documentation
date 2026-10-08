# Entity Jump Menu — manual setup guide

**Entity Jump Menu** (`entity_jump_menu`) adds a small **jump menu to the admin
toolbar** that lets administrators see which entity the current page represents and
quickly hop to a different one. You pick an entity type from a select list, type an
entity ID, and jump straight to it.

It is especially handy on sites that use URL aliases. When nodes, users and terms
have friendly aliases, the underlying system path — the one that includes the entity
type and ID, like `/node/123` — isn't visible in the address bar anymore. The jump
menu surfaces that information and gives you a fast way to navigate by ID without
hunting for the raw path.

Besides the toolbar widget, the module provides an **"Entity jump menu" block** you
can place in a region, and it adds a **permission** ("Use the entity jump menu
toolbar widget") so you control who sees it. Navigation still respects normal entity
access — the jump menu just gets you there faster; it doesn't bypass permissions.
Currently it supports **Node, User and Term** entities, which cover the most common
cases.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated settings form. Setup is just granting the permission and,
optionally, placing the block — described in "How to use it" below.

## How to use it

After enabling the module:

1. **Grant the permission.** At **People → Permissions**
   (`/admin/people/permissions`), give the **Use the entity jump menu toolbar
   widget** permission to the roles that should see it (typically administrators).
2. **Use the toolbar widget.** Users with that permission will see the entity‑type
   select and ID field in the admin toolbar; choose a type, enter an ID, and jump.
3. **Place the block (optional).** At **Structure → Block layout**
   (`/admin/structure/block`), place the **Entity jump menu** block in a region if
   you want the jump menu available outside the toolbar.

> **Note on appearance:** because browsers and themes style form elements
> differently, the jump menu's exact look and alignment can vary from browser to
> browser.
