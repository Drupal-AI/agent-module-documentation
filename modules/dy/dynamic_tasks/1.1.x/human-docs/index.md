# Dynamic Local Tasks — manual setup guide

**Dynamic Local Tasks** (`dynamic_tasks`) lets administrators add **local tasks —
the tabs that appear across the top of entity and admin pages** (like *View / Edit
/ Delete*) — to any route, entirely through configuration, without writing a custom
module. You define a tab, point it at a route, and it shows up; no code, no
`*.links.task.yml` file to author by hand.

Local tasks are normally something a developer defines in a module, and that is
still the right home for tabs that ship as part of a feature. This module is
explicitly for the **special cases** in between — a one‑off tab you need on a
particular page, a quick link into an admin route, a tab you'd rather manage as
site configuration than as code. Each tab you create is stored as a configuration
entity, so it exports and deploys like any other config. It works on Drupal 9, 10,
and 11 and depends only on core.

A key thing to understand: **a tab is just a link.** Adding a local task pointing at
a route does *not* grant anyone access to that route — the target route still
enforces its own access rules, so users who can't reach the destination simply
won't see (or can't use) the tab. The module's own permission only governs **who is
allowed to create and manage these dynamic tasks**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage dynamic local tasks.

## Where it lives in the admin menu

Dynamic Local Tasks are managed on their own listing page (the *local task*
configuration‑entity collection), reachable from the module's **Configure** link on
the **Extend** page (`/admin/modules`). See
[Configuration](configuration/index.md) for how to add a tab.
