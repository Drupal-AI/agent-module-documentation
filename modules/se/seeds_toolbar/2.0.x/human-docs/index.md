# Seeds Toolbar — manual setup guide

**Seeds Toolbar** (`seeds_toolbar`) restyles Drupal's administration toolbar into
a clean, **vertical**, mobile‑first admin navigation with light and dark modes and
built‑in right‑to‑left (RTL) support. It completely replaces the styling of the
core Toolbar and Admin Toolbar, turning the usual horizontal bar into an
opinionated side panel — a nicer admin experience for editors on phones and
tablets, and a good fit for a Drupal distribution or kickstart.

On top of the restyling it adds several conveniences: a **Seeds Add** tray with
one‑click links to create content, taxonomy terms, media, and blocks (showing only
the create links the current user actually has access to); a **local tasks** tray
exposing the current page's tabs; a **Support** tab pointing at a URL you choose; a
home/logo tab you can brand with your own logos and icons per light/dark mode; and
an **admin‑menu search box** so editors can jump to any admin page by typing. It
integrates opportunistically with Masquerade, Responsive Preview, Admin Toolbar
Search, and Devel when those are present.

Seeds Toolbar depends on core's **Toolbar** plus the contrib **Admin Toolbar** and
**Admin Toolbar Tools** modules — all enabled automatically. It has a settings form
for choosing the style, logos, support link, and more, and adds two permissions
(one to administer it, one to use the admin search box). Who sees the toolbar at
all is still governed by core's own *Access toolbar* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — the settings form (style, compact
   mode, search, support link, logos), field by field, plus permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Seeds Toolbar**
(`/admin/config/user-interface/seeds-toolbar`). The restyled toolbar itself is
active site‑wide as soon as the module is enabled, for anyone with core's *Access
toolbar* permission.
