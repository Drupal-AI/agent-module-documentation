# Manage State — manual setup guide

**Manage State** (`manage_state`) gives you an admin screen for Drupal's
**State API** — the key/value store Drupal uses for non-configuration runtime
data such as the last cron run time, assorted flags, and counters. Normally this
data is invisible unless you reach for Drush or write code. Manage State surfaces
it as a browsable, searchable list where you can view a value, edit the simpler
ones, and delete individual keys (or clear them in bulk).

It's a **developer and administration tool**, meant for development and
debugging — inspecting or resetting state without dropping to the command line.
The overview page lists every State variable currently set, with search and
filter to find what you're after.

A word of caution up front: State can hold sensitive operational values, and
changing or deleting the wrong key can break site behaviour. The bulk "delete
all" action is especially blunt. Treat this as a power tool, keep its permission
restricted to trusted administrators, and be careful using it on production — the
maintainers explicitly don't recommend it for casual production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the state overview page and how to
   view, edit, and delete state safely.

## Where it lives in the admin menu

The overview lives at **Configuration → Development → State**
(`/admin/config/development/state`, route `manage_state.state_overview`). There
is no separate settings form — the overview page *is* the tool.
