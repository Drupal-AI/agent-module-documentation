# Permissions Turbo — manual setup guide

**Permissions Turbo** (`permission_turbo`) is a high-performance replacement for
Drupal's core permissions administration page. On a site with a lot of modules,
the standard page at `/admin/people/permissions` can become painfully slow —
often taking ten seconds or more to load and eating hundreds of megabytes of
memory — because it renders every permission for every role at once. Permissions
Turbo rebuilds that interface with modern techniques and reports a 90%+
improvement in load time.

It does this with a few complementary tricks:

- **Lazy-loaded accordion.** Permissions are grouped by module in collapsible
  sections, and each section's checkboxes only load when you expand it — so the
  initial page load stays fast no matter how many modules you have.
- **Instant search.** Type to filter permissions in real time; matching sections
  auto-expand as you go, with no server round-trip.
- **Delta-based saving.** Only the permissions you actually changed are sent back
  to the server, shrinking a multi-megabyte save down to a few kilobytes.
- **Change tracking.** Modified checkboxes are highlighted, a status bar shows
  pending changes, and the browser warns you before you navigate away with
  unsaved work. You can save with **Ctrl+S** (**Cmd+S** on Mac).

It reaches the same outcome as the core page — it is gated by the same
highly-privileged `administer permissions` permission — so keep that permission
tightly restricted, since it controls who can grant or revoke anything. One thing
worth confirming when you adopt it: because it only sends the *changes* you made,
verify after a save that grants and revokes were applied exactly as you intended,
so you can trust Turbo produces the same result as the core page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings form** — the module simply provides its own,
faster permissions page.

## Where it lives in the admin menu

Once enabled, find it at **Administration → People → Permissions (Turbo)**, or go
straight to `/admin/people/permissions-turbo`. It is protected by the
`administer permissions` permission, exactly like core's permissions page. The
core page remains available too, so you can compare results while you build
confidence in Turbo.
