# Total Control — manual setup guide

**Total Control** (`total_control`) gives your site a ready‑made administration
**dashboard** at `/admin/dashboard` — one central page for running the site. Out of the
box it collects at‑a‑glance stats, quick admin links, and content and user listings
into a single screen, so administrators land somewhere useful instead of hunting
around Drupal's scattered admin pages.

The dashboard is built on Drupal's Page Manager and Panels, and it is pre‑populated
with a set of panes: an intro block, a content overview, "create content" shortcuts
for each content type, and quick links to administer content types, menus, taxonomy,
and Page Manager pages. It also ships several ready‑made Views for the fuller
listings — a full content admin screen with bulk operations
(`/admin/dashboard/content/all`), a user admin screen (`/admin/dashboard/users`), and,
when the relevant core modules are on, a taxonomy‑terms overview
(`/admin/dashboard/categories`) and a comments overview. Tabs across the top let you
jump between the Dashboard, Comments, and Categories views.

Because it is assembled from standard building blocks — Page Manager pages, Panels
variants, Views, and blocks — it is fully customizable. There is **no settings form**:
you tailor it by editing its panes through Page Manager/Panels or by overriding the
supplied Views to match your own content model. You can also embed any of its panes
(like the content overview) as blocks elsewhere, clone the page to build a curated
editor dashboard, or use the whole thing as a starting template for a bespoke admin
experience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it pulls
   in Page Manager, Panels, and CTools), enable it, and grant the permission.

There is no settings form; customization happens through Page Manager and Views, as
described below.

## Where it lives in the admin menu

- The dashboard is at **`/admin/dashboard`** (it also adds a **Dashboard** menu link),
  visible to anyone with the **Have total control** permission.
- Its listing pages sit under it: **`/admin/dashboard/content/all`** (content),
  **`/admin/dashboard/users`** (users), and **`/admin/dashboard/categories`**
  (taxonomy, when enabled).
- You edit the page and panes at **Structure → Pages** and the listings at
  **Structure → Views**.

## How to use it

After installing and enabling the module, grant the **Have total control** permission
to the roles that should reach the dashboard, then visit **`/admin/dashboard`**.
Everything is ready immediately.

To tailor it:

- **Rearrange or reconfigure panes** — use the contextual cog on the dashboard, or go
  to **Structure → Pages**, open the Total Control dashboard page, and edit its Panels
  variant. You can remove default panes, add other blocks, or swap in custom ones.
- **Adjust the listings** — go to **Structure → Views** and override
  `control_content`, `control_users`, `control_terms`, or `control_comments` to change
  their columns, filters, or bulk operations to fit your site.
- **Reuse the panes elsewhere** — each pane is a normal block (in the *Dashboard*
  category), so you can place it in any region via **Structure → Block layout**.
