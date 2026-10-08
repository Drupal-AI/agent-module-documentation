# Canvas Pattern Blocks — manual setup guide

**Canvas Pattern Blocks** (`canvas_pattern_blocks`) lets you reuse patterns built
in **Canvas**, Drupal's Experience Builder page builder, as ordinary placeable
blocks. A pattern you assemble in Canvas becomes a block you can drop in elsewhere
— in the block layout or in Layout Builder — so a design you build once can be
reused across the site instead of rebuilt each time.

It is a site‑building and theming feature. Pattern content is authored by admins
and editors, and the module declares its own permission but has no
access‑control role beyond that. It depends on the **Canvas** module and supports
Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Canvas is required).

## Where it lives in the admin menu

Canvas Pattern Blocks adds no settings form of its own. Your Canvas patterns
appear as blocks in the **Block layout** area (**Structure → Block layout**,
`/admin/structure/block`) and in Layout Builder. It declares a permission, so
review it at **People → Permissions** (`/admin/people/permissions`) and grant it
to the roles that should place these blocks.

## How to use it

Build a pattern in Canvas, then place it like any other block — pick it in the
Block layout or in Layout Builder and position it in a region. The same pattern
can be reused in as many places as you like.
