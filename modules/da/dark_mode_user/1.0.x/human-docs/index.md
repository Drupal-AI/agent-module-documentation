# Dark Mode User — manual setup guide

**Dark Mode User** (`dark_mode_user`) provides a standalone dark‑mode system for
Drupal that isn't tied to any particular theme. It offers a **global default**
mode for the site plus **per‑user preferences**, so each authenticated visitor can
choose **light**, **dark**, or **follow system** — and their choice persists
across sessions.

Being standalone is the point: rather than extending a specific theme's dark
variant, it applies site‑wide on its own. The project **replaces** (rather than
extends) the older *Dark Mode Toggle* module, and its author credits that earlier
work as the inspiration.

It's a theming / user‑experience feature with no content role of its own. Access to
the per‑user setting is gated by the `access dark mode user` permission, and it
requires **Drupal 11.1+**. There are no third‑party dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

- **Set the global default.** After enabling, choose the site‑wide default mode
  (for example, light, dark, or follow the visitor's system preference) in the
  module's admin settings. This is what visitors see before they express a
  preference of their own.
- **Let users choose.** Grant the **`access dark mode user`** permission to the
  roles who should be able to pick their own mode. Users with it can set light,
  dark, or system, and the choice is remembered for them across sessions.
- **Accessibility.** A per‑user dark mode is a comfort and accessibility win, so
  consider giving it to authenticated users broadly.

There is no separate configuration page in this guide — the global default is a
single choice in the admin settings, and the rest is per‑user preference.
