# Open Y Branch Selector — manual setup guide

**Open Y Branch Selector** (`openy_branch_selector`) lets a visitor pick their
local branch and keep that choice — a "My YMCA" link that always takes them back to
the location they care about. For a multi-site organisation with dozens of physical
branches, this solves a navigation problem no menu can: every visitor wants one
branch, and which one differs per visitor. Saving the choice makes schedules,
programmes, and opening hours default to the right place, turning the site from a
directory into something that behaves like it knows where you go.

Under the hood it is a small JavaScript library that sets **cookies** recording the
visitor's chosen branch, which other parts of the site read for content
personalisation. The branch **location data** itself is not this module's job —
that belongs to `openy_loc_branch`, the Open Y module that defines branches. Branch
Selector supplies only the selection and the persistent link.

> **Important — this module installs only on an Open Y site.** It depends on
> `openy_loc_branch`, which is **not a standalone drupal.org project**: it ships
> inside the [Open Y / YMCA Website Services](https://www.drupal.org/project/openy)
> distribution, and there is no `drupal/openy_loc_branch` package to require. On a
> plain Drupal site, enabling this module fails with *"missing its dependency
> module openy_loc_branch."* Plan to use it only on a site built from the Open Y
> distribution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install within an Open Y site and
   enable the module.

This module has **no settings form**. Its behaviour is the JavaScript selection and
the "My YMCA" link; setup is covered in "How to use it" below.

## Where it lives in the admin menu

Open Y Branch Selector adds no configuration page. On an Open Y site it works
together with `openy_loc_branch` (which provides the branch content) and surfaces a
"My YMCA" selection/link in the site's navigation.

## How to use it

1. Ensure you are on a site built from the **Open Y** distribution, so that
   `openy_loc_branch` and its branch content are present.
2. Enable the module (see [Installation](installation/index.md)).
3. A visitor uses the branch selector to choose their local branch; the choice is
   stored in a cookie and a **"My YMCA"** link then returns them to that branch.
   The visitor can change their saved branch at any time.
4. Other Open Y components can read the saved branch to personalise schedules,
   programme listings, and opening hours to the visitor's location.
