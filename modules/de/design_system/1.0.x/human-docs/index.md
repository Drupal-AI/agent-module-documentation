# Design System — manual setup guide

**Design System** (`design_system`) puts your design system — a Storybook, a
styleguide, a "kitchen sink" components page, or any URL you like — one click away
from inside the Drupal admin. It adds a menu item to the admin toolbar that opens
the target page embedded in an iframe on an admin route, so themers and editors can
consult the living design reference without ever leaving the site.

You tell the module which URL to embed on its settings form, and that value is
used as the iframe's source. The embedded page is served at `/admin/design-system`,
an admin route gated by the module's own **`access design system`** permission, so
you decide exactly which roles can see it. The module adds a toolbar icon for
core's toolbar and also supports the Gin admin toolbar if you have it installed.

It's a small, focused module: it depends only on core's **Toolbar** module, has no
mutating public endpoints, and makes no external calls from the server — the only
input is the admin-configured URL. It is covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the target URL and grant the
   viewing permission.

## Where it lives in the admin menu

- **Settings** (set the URL): **Configuration → User interface → Design System**
  at `/admin/config/user-interface/settings` (requires the **Administer site
  configuration** permission).
- **The embedded page itself:** `/admin/design-system`, reachable from the Design
  System link in the admin toolbar (requires the **`access design system`**
  permission).
