# Dashboards — manual setup guide

**Dashboards** (`dashboards`) lets you build dashboard pages — admin or front‑end —
out of **Layout Builder** sections filled with ready‑made widgets. Instead of a
single fixed admin landing page, you compose your own: drag in a chart of your most
read content, a system status summary, an "add content" menu, a user's account
card, an RSS feed, an embedded View, and more, arranged in one, two, or three
columns.

Each widget is a **Dashboard plugin**, and every one is also exposed as an ordinary
block, so you can place the same widgets outside a dashboard too. Nine widgets ship
in the base module, and optional submodules add comment, statistics, webform, and
Matomo analytics widgets. Chart‑style widgets share a common colour scheme you can
tune site‑wide.

Access is flexible: a general **Administer dashboards** permission covers managing
dashboards, and every dashboard you create automatically gets its own "can view"
and "can override" permissions — so you can give a role access to just one
dashboard, and let users personalise their own copy of it. Dashboards also appear
in a toolbar tray for quick access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodule widgets you want.
2. [Configuration](configuration/index.md) — creating and editing dashboards,
   placing widgets, the chart colour settings, and the permissions.

## Where it lives in the admin menu

Dashboards are managed at **Structure → Dashboards**
(`/admin/structure/dashboards`), where you add, edit, and lay them out. A finished
dashboard is viewed at `/dashboard/{name}`. The chart colour settings live
separately at **System → Dashboards settings** (`/admin/system/dashboards-settings`).

## How to use it

1. Go to **Structure → Dashboards** and **Add dashboard**. Give it a label and a
   category.
2. Use the **Layout Builder** editor to add sections (columns) and drop widget
   blocks into them — the widgets appear in the block picker under
   "Dashboards: …" categories.
3. Save, then view the dashboard at `/dashboard/{name}`.
4. Grant the per‑dashboard "can view" permission to the roles that should see it.

See [Configuration](configuration/index.md) for the full detail.
