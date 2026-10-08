# Front Page — manual setup guide

**Front Page** (project `front`, module machine name `front_page`) lets you send
visitors to a **different home page depending on their role**. Where core Drupal
has one front page for everybody, Front Page can redirect anonymous visitors to a
marketing landing page, logged‑in members to a dashboard, editors to a work queue,
and so on — each role landing somewhere that makes sense for them.

It works by watching requests to the real front page. When someone hits it, the
module looks at the current user's roles, finds the enabled role override with the
lowest weight (so you can resolve overlaps deterministically), and issues a
redirect to that role's chosen path. Because it is a genuine redirect, the address
in the browser changes to the target path. Administrators can be left out of this
entirely with a single toggle.

A second, separate feature rewrites where the site's **Home link** points. Normally
the theme's Home link and any `<front>` link resolve to `/`; Front Page can point
them at a specific path (for example a particular node) instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the master switch, per‑role redirects
   (and their weights), the administrator exemption, and the Home‑link rewrite,
   field by field.

## Where it lives in the admin menu

Once enabled, the module adds two forms under **Configuration → System → Front
Page**:

- **Settings** — `/admin/config/system/front/settings`: the master switch, the
  administrator exemption, and one collapsible section per role for its redirect.
- **Home links** — `/admin/config/system/front/home-links`: where the site's Home
  link points.

Both forms require the **Administer front page** permission (`administer front
page`).
