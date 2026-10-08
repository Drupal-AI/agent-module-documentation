# List Inline Block — manual setup guide

**List Inline Block (Layout Builder Blocks)** (`list_inline_block`) answers a
question that Drupal makes surprisingly hard to answer: *where are my Layout
Builder inline blocks actually used?* When you add a custom block directly to a
layout in Layout Builder, it becomes an "inline block" that lives inside that
layout rather than in the reusable block library — and Drupal offers no built‑in
way to enumerate those inline blocks or see which pages reference them.

This module adds an admin report page and a Drush command that list inline blocks
together with the nodes and layouts that use each one. It's a read‑only auditing
and reporting tool: it never changes your content. Site builders and developers
use it to track down where a block type is used before removing or refactoring
it, and to find orphaned or reused inline blocks during a content inventory.

It depends on core's **Layout Builder** module (and Layout Builder's own
dependencies), and the report is available only to users who can administer site
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it exposes a report page and a
Drush command, both described below rather than on a configuration page.

## Where it lives in the admin menu

Once enabled, the report lives at **Structure → Block layout → List Inline Block**
(`/admin/structure/block/list-inline-block`). It is gated by the **access site
configuration** permission, so administrators see it by default.

## How to use it

**From the admin UI** — visit `/admin/structure/block/list-inline-block`. The page
lists the inline blocks created through Layout Builder and the nodes/layouts that
reference each one, so you can see at a glance where a given inline block is used.

**From Drush** — pass the exact machine name of the block type used in your Layout
Builder pages:

```bash
drush inline-block:list <blockType>
```

For example, if your inline block type's machine name is `basic`, run
`drush inline-block:list basic`. This is handy for scripted audits or for checking
usage before you remove or change a block type.
