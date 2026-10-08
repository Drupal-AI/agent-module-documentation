# Tempstore Plus — manual setup guide

**Tempstore Plus** (`tempstore_plus`) reorganises how Drupal handles its
*temporary store* — the place unsaved editing work lives — so that entity edits
and Layout Builder edits go through one shared architecture instead of two
parallel ones, and so that tempstore keys take the active workspace into account.

This is **developer infrastructure**, not a feature you configure. Drupal's
shared tempstore holds work you have made but not yet saved: the Layout Builder
changes in progress, the entity form state carried across a multi‑step flow. Core
has one implementation for Layout Builder and a general one for everything else,
and any code that needs to handle both ends up branching awkwardly. Tempstore
Plus puts a strategy interface in front of them — a `LayoutTempstoreStrategy` and
an `EntityTempstoreStrategy` behind a selector — so a caller can simply ask for
"the tempstore for this thing" and get the right one. Other modules can register
their own strategies without overriding core services and colliding with each
other.

The part worth knowing about even if you never touch the API is its
**workspace‑aware keys**. Tempstore keys that ignore the active workspace let two
editors working in different workspaces collide on the same key — one sees the
other's unsaved changes, or overwrites them. Making the workspace part of the key
fixes that, and it is exactly the kind of bug that is hard to reproduce and easy
to misattribute to caching.

The module has **no routes, permissions, or configuration** of its own — there is
nothing to set up beyond enabling it. In practice it usually arrives as a
dependency of the **Navigation +** (`navigation_plus`) and **Layout Builder +**
(`lb_plus`) editing stack. Because it alters container services when it installs,
it is worth remembering as the culprit if tempstore behaviour changes
unexpectedly after installing that stack. It depends on core **Layout Builder**
and supports **Drupal 10, or 11.3 and newer** (`^10 || ^11.3`).

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Tempstore Plus has no admin UI, settings form, or permissions. It works
silently as infrastructure once enabled.
