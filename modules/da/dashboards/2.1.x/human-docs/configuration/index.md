# Configuration

There are two places to configure Dashboards: the **dashboards list** (where you
create and lay out each dashboard) and a small **settings form** (which controls
chart colours). Access is then governed by a set of permissions.

## Managing dashboards

Go to **Structure → Dashboards** (`/admin/structure/dashboards`). This is the
module's main configuration screen — a list of dashboards with **Add**, **Edit**,
**Delete**, and **Permissions** links.

### Create a dashboard

1. Click **Add dashboard**.
2. Fill in:
   - **Label** — the human name (also shown in the toolbar tray).
   - **Category** — a grouping string used to organise dashboards.
   - **Weight** — the ordering; lower weights come first (for example, in the
     toolbar tray).
   - **Frontend** — leave off for an admin‑only dashboard, or turn it on to expose
     the dashboard on the front end of the site as well.
3. Save. The dashboard is then available at `/dashboard/{name}`.

### Place widgets with Layout Builder

Editing a dashboard opens the **Layout Builder** editor. Add sections (choose a
one‑, two‑, or three‑column layout) and then **Add block** into each section. The
dashboard widgets appear in the block picker grouped under "Dashboards: …"
categories. The base module provides widgets for the current user's account, an
"add content" menu, an embedded View, a "page not found" report, system
information, node view statistics, recent content/status updates, an error report,
and an RSS news feed. Submodules add comment, statistics, webform, and Matomo
widgets.

Because every widget is also a block, you can place these same widgets anywhere on
the site through normal Block Layout, not only on a dashboard.

### Let users personalise a dashboard

If a user has the "can override" permission for a dashboard (below), they get a
**Personalize** option that creates their own editable copy of that dashboard,
stored per user, without affecting anyone else's view.

## Chart colour settings

Chart‑style widgets share a colour scheme set at **System → Dashboards settings**
(`/admin/system/dashboards-settings`), gated by **Administer dashboards**. Three
values control it:

- **Colormap** *(default `summer`)* — the named colour map to draw from (for
  example `jet`, `hsv`, `viridis`, `plasma`, `summer`).
- **Alpha** *(default `40`)* — chart transparency as a percentage, from 20 to 100.
- **Shades** *(default `15`)* — how many colours the map is divided into (minimum
  15).

These can also be set with Drush, e.g. `drush cset dashboards.settings colormap
viridis -y`.

## Permissions

- **Administer dashboards** (`administer dashboards`) — the master permission for
  the dashboards admin UI, the add/edit/delete and Layout Builder forms, and the
  settings form.
- **Per‑dashboard permissions** — every dashboard you create automatically gets two
  of its own:
  - **Can view `<name>` dashboard** — lets a role see that dashboard's page (and it
    then appears in that user's toolbar tray).
  - **Can override `<name>` dashboard** — lets a user create and edit a personal
    copy of that dashboard.

Grant them at **People → Permissions**, or with Drush:

```bash
drush role:perm:add editor 'can view ops_overview dashboard'
drush role:perm:add editor 'can override ops_overview dashboard'
```

So a role can be given access to exactly the dashboards it needs, and nothing more.
