# Navbar Filter — manual setup guide

**Navbar Filter** (`navbar_filter`) adds a small text‑filter box to Drupal's admin
**Toolbar** (navbar) so you can quickly find a link by typing. On sites with a
large admin menu, hunting through nested items is slow; with Navbar Filter you
type a few characters and the menu narrows to matching links. It is a pure
administration/usability convenience — it does not change content, permissions, or
access in any way.

The module works the moment you enable it: the filter text box appears at the top
of the navbar's tray. One thing to know up front — the filter only appears while
the toolbar is **displayed vertically** (the tray shown as a side column), not in
the default horizontal bar. It depends on core's **Toolbar**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it works as soon as it is
enabled.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Switch the admin toolbar tray to its **vertical** orientation — click the
   orientation toggle on the toolbar so the tray shows as a side column.
3. A **filter text box** appears at the top of the tray. Start typing and the
   navbar's menu items narrow to those that match.
