# Copyright Footer — manual setup guide

**Copyright Footer** (`copyright_footer`) gives you a small, self-maintaining
copyright block for your site footer. It renders a tidy notice like
*"Copyright © 2026 Acme Corp ver.3.1.1"* — and the year is computed fresh on every
page load, so the notice never goes stale and you don't have to remember to edit
it each January.

The module ships exactly one thing: a **block** you place through the normal Block
layout UI. Its form gives you six fields to shape the notice: your organization
name (optionally a link), a start year and end year (to print a single year or a
range like "2010-2026"), and an optional version string (optionally a link to a
changelog). Leave the fields you don't need blank — with everything empty you
still get a clean "Copyright © 2026".

Because it's a standard block, you can use core's block visibility conditions to
show it only on certain pages, to certain roles, or per language, and you can
place multiple instances with different organizations for subsites or sections.
There is no settings page and no permissions — everything is configured right on
the block. It depends only on core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the block and fill in its six
   fields to shape the copyright notice.

## Where it lives in the admin menu

There is no module settings page. You place and configure the block from
**Structure → Block layout** (`/admin/structure/block`) — look for **Copyright
Footer** under the "Custom" category when you click *Place block*.

## How to use it

Place the Copyright Footer block in your theme's footer region, fill in your
organization name and (optionally) a start year and version, and save. The block
label is hidden by default, so only the copyright line itself shows. See
[Configuration](configuration/index.md) for the field-by-field details.
