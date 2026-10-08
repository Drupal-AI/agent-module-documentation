# Entity Usage Addons — manual setup guide

**Entity Usage Addons** (`entity_usage_addons`) turns the data collected by the
**Entity Usage** module into field formatters, so "where is this used?" becomes
something you place directly on a display rather than a separate report you have to
navigate to. It reads Entity Usage's existing tables through a small `Usable`
service — there's no second source of truth and no extra tracking to keep in sync —
and surfaces the answer right where an editor is looking at the entity, wondering
whether deleting it will break other pages.

It provides two formatter behaviors: one renders the **list of referencing
entities** as links, and the other renders just the **usage count**. Both can be
used in Views (add an ID field, then choose the Entity Usage formatter for its
output) to build usage columns and reports.

The scope is small on purpose — a few PHP classes, no routes, no permissions, and
no configuration page. That also means it inherits every limitation of Entity
Usage: if the parent module hasn't tracked a particular relationship (an
unsupported field type, or a reference built in a way its plugins don't see), the
formatter shows nothing, and shows it without complaint. **An empty usage list is
not proof that an entity is unused.** Configure what gets tracked in Entity Usage
itself, not here. This module depends on the **Entity Usage** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Entity Usage.

There is **no configuration page** for this module — you set it up on a field
display or in a View, described in *How to use it* below. Tracking itself is
configured in the Entity Usage module.

## How to use it

1. Make sure **Entity Usage** is installed and configured, and that you've run its
   bulk update so existing content is tracked.
2. To show usage in a **View**: add an **ID** field to the view, then choose the
   **Entity Usage** field formatter for that field's output and configure it (list
   of links, or count) to your liking.
3. To show usage on an entity **display**: use the formatter on the relevant field
   in **Manage display** so editors see where the entity is referenced right on the
   content.

Remember that the results are only as complete as Entity Usage's tracking — an
empty list means "not tracked", not necessarily "not used".
