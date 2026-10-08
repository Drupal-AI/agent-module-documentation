# Navigation Extra Tools — manual setup guide

**Navigation Extra Tools** (`navigation_extra_tools`) adds a **Tools** menu — marked
with a wrench icon — to Drupal core's modern **Navigation** toolbar, giving you
one‑click administrative shortcuts for flushing caches, running cron, and running
outstanding database updates. If you have used the popular "Admin Toolbar Extra
Tools" submodule, this is the same idea rebuilt for the Navigation‑era toolbar that
core is moving toward.

Under the Tools menu you get a **Flush all caches** link, a **Flush individual
cache** submenu (with separate links for CSS/JS aggregation, plugins, static caches,
routing and menu links, Twig templates, the render cache, Views, and a theme‑registry
rebuild), a **Run cron** link, and a **Run updates** link that jumps to core's
database‑updates page. Each cache and cron action is a protected route that performs
the operation and drops you back on the page you were on with a status message.

The menu is also aware of a couple of other modules. If **Devel** is installed, a
**Development** submenu appears mirroring your Devel Toolbar selection (plus a
Webprofiler link and an "Execute PHP Code" link when those are present). If
**Project Browser** is installed, a Project Browser section with a "Clear storage"
link appears. The module has no settings form of its own — instead, access to the
cache and cron shortcuts is controlled by dedicated permissions you grant per role.
It depends only on core's Navigation module and runs on Drupal 10.3+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it requires core's Navigation module).

There is no settings page; granting the permissions that reveal the Tools menu is
covered in *How to use it* below.

## Where it lives in the admin menu

The module has **no settings form**. What it adds is the **Tools** menu (wrench
icon) in the core **Navigation** toolbar itself, at `/admin/tools`. To control who
sees it, you use **People → Permissions** (`/admin/people/permissions`).

## How to use it

**1. Enable the Navigation toolbar.** This module extends core's **Navigation**
module, so that must be on and in use. Users also need the core **Use the
navigation** permission (`access navigation`) to see the toolbar at all — the wrench
icon library is only attached for those users.

**2. Grant the tool permissions.** The Tools items only appear for users who hold
the matching permission, so nothing shows up until you grant them. At **People →
Permissions**, look for:

- **Access navigation extra tools cache flushing** — reveals and enables *all* the
  cache‑flush links (Flush all caches and every item under "Flush individual
  cache").
- **Access navigation extra tools cron** — reveals and enables the **Run cron**
  link.
- **Access project browser clear storage** — reveals the "Clear storage" link in the
  Project Browser section (only relevant if Project Browser is installed; intended
  for development/debugging).

All three are marked as restricted because they grant administrative capabilities —
give them only to trusted roles. (The **Run updates** link is governed by core's own
update‑access rules, not by a permission from this module.) From the command line
you can grant them with, for example,
`drush role:perm:add site_manager 'access navigation extra tools cache flushing'`.

**3. Use the Tools menu.** Once permissions are granted, open the Navigation
toolbar, click **Tools** (the wrench), and use the shortcuts. Each action runs
immediately and returns you to your current page with a confirmation message — handy
during theme or module development, or as part of a deploy checklist.
