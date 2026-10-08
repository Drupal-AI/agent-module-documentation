# Maintenance Preview — manual setup guide

**Maintenance Preview** (`maintenance_preview`) lets you view your site's
maintenance page **without actually putting the site into maintenance mode**. It
solves a small but real annoyance: normally the only way to see how the "site
under maintenance" page looks is to take the whole site offline, which you can't
easily do on a live site while people are using it. With this module, permitted
users can render the maintenance page on demand and iterate on its design safely.

It's purely a development and design aid. It does **not** change who can access
the site during real maintenance — Drupal core's maintenance-mode access
behaviour is untouched. All this module does is expose the maintenance page for
preview to users who hold its permission.

The access model is simple: previewing the maintenance page is gated by a
**permission the module provides**. Grant that permission only to the people who
need to design or review the maintenance page (developers, themers, site
builders), and they can preview it without affecting anyone else's experience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** for this module — nothing to configure beyond
granting its permission (below).

## Where it lives in the admin menu

The module adds no configuration page. Access to the preview is controlled at
**People → Permissions** (`/admin/people/permissions`), where you grant the
Maintenance Preview permission to the appropriate roles.

## How to use it

1. Enable the module.
2. At **People → Permissions**, grant the module's preview permission to the
   roles that should be able to see the maintenance page (for example your
   developer or site-builder role).
3. Those users can then preview the maintenance page on demand — designing and
   testing it without ever taking the site offline.

Because it only adds a preview capability, it's safe to leave enabled: it never
changes who can reach the site during an actual maintenance window.
