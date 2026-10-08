# Database logging API — manual setup guide

**Database logging API** (`dblog_api`) is a small developer framework that lets
modules add their own **Operations** (action links) to the log messages shown by
Drupal core's Database Logging (`dblog`) module. Out of the box, the *Recent log
messages* report at `/admin/reports/dblog` and each message's *Details* screen show
your log entries but offer no per-entry actions. This module opens that up: it
replaces the log View's link-field handler with a plugin-based one, so any module
can contribute a custom operation on a log entry.

The classic example is a "Ban this IP" link next to a suspicious log entry (the
companion **Database logging ban operation** module builds exactly that on top of
this API). On its own, `dblog_api` adds no visible operations — it is the
plumbing other modules build on, providing the operation plugin type and the View
integration.

Because it is a developer/framework module, there is nothing to configure and no
end-user feature to switch on. You install it because another module requires it,
or because you are writing a module that needs to add operations to the log. It
depends on core's Database Logging (`dblog`) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (usually as a dependency of another module).

There is **no configuration page** for this module — it is a plugin API with no
settings form and no operations of its own. Enabling it simply makes the operation
plugin type available; the operations themselves come from other modules.

## How to use it

If you are a **site builder**, you typically won't enable this module directly —
you enable a module that *uses* it (for example, an IP-ban operation), and Drupal
pulls `dblog_api` in as a dependency. The added operations then appear on the log
report and detail pages provided by that module.

If you are a **developer**, this module gives you a `DblogOperation` plugin type
and takes over the log View's link column so your plugin's operation shows up
there. See the [`agent/`](../agent/start.md) docs for the plugin details.
