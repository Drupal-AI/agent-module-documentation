# Block Usage Report — manual setup guide

**Block Usage Report** (`block_usage_report`) adds a single read-only admin report
that answers a surprisingly hard question on a mature site: **where is this block
actually used?** It lists which blocks are enabled and where they're placed,
presented as a table at `/admin/reports/block-usage`.

On a real site, blocks live in more than one place: in the block layout per theme,
inside Layout Builder sections, and in other modules' placements — and no single
core screen summarises all of that. The gap is felt most when you're about to
delete a custom block, auditing what a theme still depends on, or preparing for a
redesign or migration. This module fills the gap by walking the block placements
and, importantly, using a dedicated finder for the **Layout Builder** case — the
part the core block layout page misses.

It's a low-risk, self-contained reporting tool: a controller, a finder service, a
route, and no writes to your configuration. It has no dependencies and supports
Drupal 10.1 and 11. One thing to check before you rely on it in a shared
environment: confirm the report's **access requirement** matches who should be
allowed to see structural information about your site, since the report exposes
where things are placed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The report lives under **Reports → Block usage**, at
`/admin/reports/block-usage`. The module declares its package as *Custom*, so on
the **Extend** page you'll find it listed under **Custom**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Reports → Block usage** (`/admin/reports/block-usage`).
3. Read the table of enabled blocks and where each is placed — including Layout
   Builder placements — to audit usage before deleting a block, refactoring a
   block library, or migrating a theme.
4. Before relying on it in a shared environment, confirm who has access to the
   report, since it reveals structural information about the site.
