# Toolbar Menu Clean — manual setup guide

**Toolbar Menu Clean** (`toolbar_menu_clean`) is a companion to the
[Toolbar Menu](https://www.drupal.org/project/toolbar_menu) module. Its job is to *tidy up*
the core Toolbar for roles that should see a curated, custom menu instead of the full admin
experience. It can hide the standard **Administration ("Manage") tray**, the **Shortcuts**
tab, and the contextual **Edit** button from users who lack purpose-built permissions — so a
Toolbar Menu you have built can stand on its own.

The whole module is a single behaviour hook plus three permissions. There is no
configuration form. Instead, each of the three toolbar elements is controlled by one
permission: a role that *has* the permission keeps the standard element, and a role that
*lacks* it has that element hidden or removed. This lets you give editors or clients a clean,
uncluttered back-end navigation without writing any code and without touching their actual
site permissions.

One important caveat: this is a **presentation cleanup, not an access-control mechanism**. It
only affects what appears in the toolbar. The underlying admin routes remain reachable by
anyone whose real permissions allow it — a hidden Manage menu does not revoke *access
administration pages*. Treat it as UX tidying layered on top of Toolbar Menu, not as a
security boundary. It depends on the Toolbar Menu module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Toolbar Menu) with
   Composer and enable it.
2. [Configuration](configuration/index.md) — the three permissions and how assigning them
   shapes each role's toolbar.

## Where it lives in the admin menu

There is no settings page. You "configure" the module entirely on the **People → Permissions**
screen (`/admin/people/permissions`) by granting or withholding its three permissions per
role — see [Configuration](configuration/index.md).
