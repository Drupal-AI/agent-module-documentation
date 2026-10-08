# Pathauto Condition UI — manual setup guide

**Pathauto Condition UI** (`pathauto_condition_ui`) is an extension for the popular
**Pathauto** module. Out of the box, a Pathauto pattern applies to every entity of
its type. This module adds an administrative interface for attaching **conditions**
to alias generation, so you can control *when* an automatic URL alias is created
rather than always — for example, only generating an alias when a route or entity
meets criteria you define. It lets you do this from the admin UI, without writing
code.

Once enabled, the condition‑management interface appears alongside Pathauto's own
settings in the admin area. From there you can add new conditions, and edit or
remove existing ones. This module governs alias **creation**, not access — it has
no access‑control role of its own — and it depends on the Pathauto module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Pathauto is required).

The module *is* a configuration UI — its whole purpose is managing Pathauto
conditions — so rather than a separate configuration chapter, the setup steps are
described under "How to use it" below.

## Where it lives in the admin menu

The condition‑management UI is presented alongside the existing **Pathauto**
settings in the administrative interface (under **Configuration → Search and
metadata → URL aliases**, with the Pathauto pattern settings).

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Pathauto must be
   installed and configured with at least one pattern.
2. Open the Pathauto settings area, where you'll find the new condition‑management
   UI.
3. **Add** a condition that determines whether a pattern applies for a given
   entity or route, or **edit / remove** an existing one.
4. Save, then create or update some content to confirm aliases are generated only
   when your conditions are met.
