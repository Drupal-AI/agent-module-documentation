# Program Search — manual setup guide

**Program Search** (machine name `openy_programs_search`, project
`program_search`) provides a configurable **block** for searching *programs* —
the classes and activities that YMCA sites list. It is part of the
[Open Y](https://www.drupal.org/project/openy) (YMCA) distribution rather than a
general-purpose search tool, and it is designed to sit on an Open Y site that
already has program content to search.

Because the module ships as a block (and a searchable programs paragraph), the
setup is entirely about placing that block on a page and letting visitors search
your program catalogue. Like any search feature, it surfaces the program content
your site exposes, subject to normal access checks — it does not widen who can see
what.

Note that the project name and the machine name differ: you install it with
Composer as `drupal/program_search`, but you enable it with Drush as
`openy_programs_search`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Open Y dependencies.

There is no dedicated settings form for this module. You set it up by placing its
block, described below.

## Where it lives in the admin menu

Program Search adds no configuration page of its own. You use it entirely from
**Structure → Block layout** (`/admin/structure/block`), where you place the
programs-search block into a region, and from the block's own configuration form
when you add it.

## How to use it

1. Confirm your site is an Open Y build with program content — this module depends
   on `daxko` and `openy_socrates` and expects the Open Y program data model.
2. Go to **Structure → Block layout**, choose a region, and click **Place block**.
3. Find the programs-search block, place it, and configure it on the block form
   (title, visibility, and region).
4. Save the block layout. Visitors can now search your programs from wherever you
   placed it.

> **Tip:** Program Search reads from a shared data cache. If your program listings
> look stale after content changes, the Open Y programs-search data store exposes
> `warmCache()` and `resetCache()` service methods that a developer can call to
> rebuild or clear that cache.
