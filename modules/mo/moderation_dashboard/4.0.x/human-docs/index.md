# Moderation Dashboard — manual setup guide

**Moderation Dashboard** (`moderation_dashboard`) gives every content editor a **personal
editorial home page** at `/user/{uid}/moderation-dashboard` that gathers everything they need
to moderate in one place: content they recently created, content that recently changed state,
items currently in review, and an activity chart of their editorial work — plus quick "add
content" links. It turns several scattered admin listings into a single landing page an editor
can bookmark or be sent to automatically at login.

The whole dashboard is built from core **Views** and **Layout Builder**, which is deliberate:
administrators are expected to **customize it through the UI** rather than in code. On install
the module ships four Views and a Layout‑Builder layout for a `moderation_dashboard` user view
mode, arranged into a three‑region layout together with two custom blocks (the Chart.js
activity graph and the "add content" links). Because it ships **no update hooks**, any changes
you make to that layout — adding your own Views, re‑ordering regions, dropping in blocks — are
never overwritten by module updates.

A small settings form offers two switches: whether editors are **redirected to their
dashboard after logging in**, and whether **Chart.js** is loaded from a local library
(recommended) or a CDN. Access is governed by two permissions — one for using your own
dashboard, one for viewing anyone else's (for lead editors doing oversight) — and a link to
the dashboard is injected into the user toolbar for anyone who can use it. The module depends
on core **Content Moderation**, **Node**, **Views**, and **Layout Builder**, and requires
Drupal 11.2+ (it targets `^11.2 || ^12`). The activity chart works best with the
`nnnick/chartjs` library installed locally.

This guide is written for a **human** setting the dashboard up in the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it brings in Content
   Moderation, Node, Views, and Layout Builder) and enable the module; plus the Chart.js
   library.
2. [Configuration](configuration/index.md) — the settings form, the two permissions,
   customizing the dashboard with Layout Builder, and setting up Chart.js.

## Where it lives in the admin menu

- **Configuration → People → Moderation Dashboard**
  (`/admin/config/people/moderation_dashboard`) — the module's settings form (its `configure`
  link): the login redirect and Chart.js source.
- **Configuration → People → Account settings → Manage display → Moderation dashboard**
  (`/admin/config/people/accounts/display/moderation_dashboard`) — where you customize the
  dashboard layout with Layout Builder.
- The dashboard itself lives at **`/user/{uid}/moderation-dashboard`** (also linked from the
  user toolbar).
- **People → Permissions** — the *Use moderation dashboard* and *View any moderation
  dashboard* permissions.
