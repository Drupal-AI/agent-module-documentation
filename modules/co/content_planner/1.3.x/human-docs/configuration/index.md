# Configuration

Content Planner works out of the box, but you'll want to do three things: make sure a moderation
workflow is in place, arrange the dashboard widgets, and set permissions. Here's how.

## 1. The prerequisite — a Content Moderation workflow

The calendar and kanban board plan content against Content Moderation states, so before those
boards are useful you need a **workflow** (under **Configuration → Workflows**,
`/admin/config/workflow/workflows`) with at least one content type enabled on it (for example
your *Article* type moving through Draft → Published). Without a workflow covering the relevant
content types, the boards will have no states to display. The Scheduler dependency also lets the
calendar set a publish date when you schedule content.

## 2. Configure the dashboard

1. Log in as a user with the **Administer content planner dashboard settings** permission.
2. Go to the dashboard settings at **/admin/content-planner/dashboard/settings**.

Here you enable, order, title, and role‑restrict the widgets that make up the dashboard. The
shipped widgets are:

- **User widget** — lists editors along with their content‑moderation statistics, so you can see
  who's working on what.
- **View widgets (View 1–10)** — each embeds an existing View. Point one at a View by its
  `view_id.display_id` (for example an "unpublished articles" listing) to surface it on the
  dashboard. A View widget only renders for users who can access the underlying View.
- **Text/HTML widgets (1–3)** — free‑form rich‑text notes or announcements. The content is authored
  in a Full HTML field (see the note below).

For each widget you can set:

- a **title**,
- a **weight** (ordering on the dashboard), and
- **allowed roles** — restrict the widget to specific roles. Leave it empty to show the widget to
  everyone who can view the dashboard (user 1 always sees every widget).

Each widget's own settings are edited from its configure link on that settings page.

> **A note on the Text/HTML widgets.** Their content is authored as Full HTML and shown to all
> dashboard viewers. The output does pass through Drupal's text‑format filtering, but as with any
> Full HTML field you should only grant the **Administer content planner dashboard settings**
> permission (which lets someone author that markup) to trusted roles.

## 3. Permissions

The base module defines two permissions (grant them under **People → Permissions**):

- **View content planner dashboard** — access the dashboard at `/admin/content-planner/dashboard`.
  Grant to any role that should see the editorial overview.
- **Administer content planner dashboard settings** — access the dashboard settings and the
  per‑widget configuration forms (add, order, title, and edit widget content). Grant to trusted
  editorial administrators.

The **Content Calendar** and **Content Kanban** submodules add their own permissions and settings —
consult each submodule's documentation to grant access to the calendar and board and to configure
which content types they cover. Moving a card on the kanban board respects the user's Content
Moderation transition permissions, so users can only make transitions they're normally allowed to.

## 4. Use the tools

- **Dashboard** (`/admin/content-planner/dashboard`) — your at‑a‑glance planning hub of the widgets
  you configured above, plus quick links to the calendar and kanban.
- **Content Calendar** — plan visually month by month; drag a node to change its scheduled/publish
  date, colour‑code entries by content type, and duplicate a node to reuse it as a template.
- **Content Kanban** — see nodes as cards grouped by moderation state; drag a card to a new column
  to transition its state. Every state change is recorded, so you can review the editorial history.

## For developers — custom dashboard widgets

The dashboard is extensible via a `dashboard_block` plugin type. To add your own widget, create a
`@DashboardBlock` plugin extending `DashboardBlockBase` and implement `build()`; the base class
provides helpers for per‑role visibility and per‑widget configuration forms. See the sibling
[`agent/plugins/dashboard-block.md`](../agent/plugins/dashboard-block.md) reference for a worked
example.
