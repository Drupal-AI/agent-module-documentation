# Sites Robots.txt — manual setup guide

**Sites Robots.txt** (`sites_robotstxt`) lets every site managed by the **Sites**
module serve its own `robots.txt`. It bridges Sites with the **RobotsTxt** module
so that the file served at `/robots.txt` is built from whichever site is currently
active — meaning different domains on one Drupal install can hand crawlers
different rules.

The problem it solves is that RobotsTxt, on its own, stores a single global
`robots.txt` for the whole install. That is fine for one site, but in a Sites
multi‑site you often want a staging or preview domain to disallow crawlers while
production allows them, or you want each microsite to point at its own XML sitemap.
This module adds a per‑site robots.txt setting: a `SitesRobotstxt` site‑setting
plugin holds each site's robots.txt body, and a route subscriber swaps in the
module's own controller, which reads the active site's setting and falls back to
the global RobotsTxt configuration when a site has none.

It has a small settings form for global behaviour, and the per‑site content is
edited directly on each site. It depends on the **Sites** module and the
**RobotsTxt** module, and targets Drupal 11+. There are no submodules. Note the
inheritance behaviour: a **child site inherits its parent site's robots.txt** (the
child returns a 404 for its own), and there is an optional setting to **return 404
for `/robots.txt` when no site context is active**.

On security, there is nothing exposed to worry about: the public robots.txt output
is read‑only, and the settings form is gated by the `administer robots.txt`
permission (which the RobotsTxt module owns). There is no anonymous write surface.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Sites and RobotsTxt).
2. [Configuration](configuration/index.md) — set per‑site robots.txt content and
   the global fallback behaviour.

## Where it lives in the admin menu

Global behaviour is configured at **Configuration → Search and metadata → Sites
Robots.txt** (`/admin/config/search/sites-robotstxt`), behind the
`administer robots.txt` permission. The per‑site robots.txt body is edited on each
site itself, in its "Site specific robots.txt additions" field.
