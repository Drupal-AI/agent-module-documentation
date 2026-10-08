# Workbench — manual setup guide

**Workbench** (`workbench`) gives content editors a personalized **My Workbench**
dashboard — a single landing page, plus a toolbar tab and sub‑tabs, that surfaces
the content they created, edited, or can access. It is aimed at non‑technical
editors who would otherwise have to learn the separate `/user`, `/node/add`, and
`/admin/content` pages.

The overview page at `/admin/workbench` shows three regions: the editor's own
profile, their most recent edits, and recent site content. Sub‑tabs provide full,
sortable, filterable lists for **My edits** and **All recent content**, and a
**Create content** tab that mirrors Drupal's "Add content" page. A **Workbench**
item appears in the admin toolbar so editors can reach their workspace from
anywhere.

Every region on the dashboard is powered by a View, and a small settings form
lets a site builder assign any View display to each region — so you can reshape
the dashboard without writing code. Workbench is also the foundation of the wider
Workbench suite (Workbench Access, Content Moderation), which builds a full
editorial workflow on top of it. It depends on Drupal core's Image, Node,
Toolbar, User, and Views modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant editors the right permissions.

## Where it lives in the admin menu

The editor‑facing dashboard is at **`/admin/workbench`** (reached from the
**Workbench** toolbar tab). The site‑builder settings form — where you map Views
to the dashboard regions — is at **Configuration → Workflow → Workbench**
(`/admin/config/workflow/workbench`).

## How to use it

Out of the box, once editors have the right permissions, Workbench works
immediately: they click the **Workbench** toolbar tab and land on their
dashboard. The two permissions that matter are:

- **Access My Workbench** (`access workbench`) — grants an editor role the whole
  Workbench area and its toolbar tab. This is the one you give to editors.
- **Administer Workbench content settings** (`administer workbench`) — grants
  access to the settings form that maps Views to regions. Keep this to trusted,
  administrative roles.

For Workbench to be genuinely useful, editors also need the usual core content
permissions (access the toolbar, create/edit their content types).

### Reshaping the dashboard (optional)

The dashboard has five regions, each set to a `View : display` pairing:

- **Overview left** — the current user's profile (default
  `workbench_current_user`).
- **Overview right** — the user's most recent edits (default `workbench_edited`).
- **Overview main** — recent content (default `workbench_recent_content`).
- **My edits page** and **All recent content page** — the bodies of the two
  sub‑tab list pages.

To change any region, go to **Configuration → Workflow → Workbench**. Each region
is a dropdown listing every View display on the site — pick one and save. To use
your own View, build it first under **Structure → Views**, then assign its
display to a region here. The mapping is stored as exportable configuration, so
it deploys between environments. The **Create content** tab is not a View and is
not configured here.
