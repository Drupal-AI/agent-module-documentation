# Display Mode Extras — manual setup guide

**Display Mode Extras** (`display_mode_extras`) adds **per‑role access control** to
Drupal's entity **form modes** and **view modes**. Drupal lets you define alternate
form modes (different arrangements of edit fields) and view modes (different display
layouts) for an entity, but core has no way to say "only this role may use that
form mode". This module fills that gap: it generates a dynamic permission for each
display mode you choose to manage, so you can grant or restrict specific modes by
user role.

The problem it solves is tailoring the editing and display experience to different
roles. For example, you might give a "Basic editor" role a slimmed‑down form mode
with just the essential fields, while a "Power editor" role gets the full form —
each role only seeing the variant meant for it. The same idea applies to view
modes, limiting which display variants a role can select or trigger.

The module generates standard Drupal permissions (exportable and deployable like any
other), and it works alongside core's Field UI display‑mode configuration rather
than replacing it. It has no external dependencies. Note that it governs *which
display modes are available* to a role — it does not itself expose entity data
through any route.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — opt form modes and view modes into
   governance, then assign the generated permissions.

## Where it lives in the admin menu

The settings forms are under **Structure → Display modes** — form modes at
`/admin/structure/display-modes/settings` and view modes at
`/admin/structure/display-modes/settings/view_modes` (route
`display_mode_extras.settings`). The per‑mode permissions it generates are assigned
at **People → Permissions** (`/admin/people/permissions`). See
[Configuration](configuration/index.md).
