# Configuration

Dashboards are created and managed at **Structure → Dashboard**
(`/admin/structure/dashboard`). You need the *Administer dashboard* permission to
reach these pages. There is no single settings form — instead you build one or more
dashboards, arrange their contents, and control who sees each one.

## Creating a dashboard

1. Go to **Structure → Dashboard** — this lists every dashboard, ordered by weight.
2. Click **Add dashboard**, give it a **label** and optional **description**, and
   save.

You can create as many as you like — for example one for editors and one for
administrators.

## Building the layout

Each dashboard's contents are built with Layout Builder:

1. From the dashboard's edit page, click the **Edit layout** action.
2. **Add sections** — choose a layout such as one‑column or two‑column to divide the
   page into regions.
3. **Add blocks** — drop blocks into the regions. Alongside any Views block, the
   core Shortcuts block, and any other core or contrib block, this module provides
   four of its own (in the "Dashboard" category):
   - **Dashboard Text** — a formatted rich‑text block, ideal for a welcome message
     or instructions.
   - **Site Status** — a summary of the core status report.
   - **Navigation Dashboard** — links into your dashboards from the navigation.
   - **Placeholder** — references another block (such as a Views block) that might
     not always exist, degrading gracefully if the referenced block is missing.
4. Rearrange blocks by dragging them between regions, and save the layout when
   done.

You can also **Preview** a dashboard before enabling it, from its Preview tab.

## Per‑role dashboards and the login landing page

There is no explicit "home dashboard" setting; the right dashboard reaches the
right user through a combination of access, weight and an automatic login redirect:

1. **Create one dashboard per role** (or per group of users).
2. **Grant access.** Each dashboard generates its own permission,
   "Access to _\<name\>_ dashboard". At **People → Permissions**, grant each role
   the permission for the dashboard it should see. (A dashboard must also be enabled
   for anyone to view it.)
3. **Set the default with weight.** When a user can view more than one dashboard,
   the one with the lowest weight (highest in the list) is treated as their default
   — the one shown at **/admin/dashboard**. Reorder the list to control this.
4. **Login redirect.** Right after logging in, users are sent to their default
   dashboard automatically whenever they have access to one. (This is skipped if the
   login carried an explicit destination, or during the password‑reset flow.) This
   is what makes a role's dashboard its effective landing page.

## Enabling and disabling

Disabling a dashboard (turning its status off) removes it from view and from the
login redirect, without deleting it. Re‑enable it when you are ready.

## Deploying

Dashboards are configuration entities, so they export and deploy between
environments with `drush config:export` / `config:import` like any other
configuration.
