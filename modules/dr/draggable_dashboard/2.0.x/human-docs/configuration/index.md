# Configuration

Draggable Dashboard is configured by building dashboards and then placing them as
blocks. Everything below the "place it" step requires the
**administer_draggable_dashboard** permission.

## 1. Create a dashboard

1. Go to **Structure → Draggable Dashboard**
   (`/admin/structure/draggable-dashboard`) — the list of all dashboards.
2. Click **Add Dashboard**.
3. Fill in:
   - **Title** — the dashboard's name (also used to label its placeable block).
   - **Description** — an optional note about what the dashboard is for.
   - **Columns** — how many columns the grid should have.
4. Save. You now have an empty dashboard to fill with blocks.

## 2. Add blocks to a column

On the dashboard's edit form, each column has a **Place block** control:

1. Click **Place block** for the column you want to fill.
2. A modal lists the standard block library (the same context-aware, filtered list
   Drupal uses elsewhere).
3. Choose a block. The next form shows **that block's own configuration** (label,
   and any settings the block provides), plus a machine name and a **Column**
   selector.
4. Save the block into the dashboard.

Repeat to add as many blocks as you like — Views blocks, custom blocks, and system
blocks can all live together in one dashboard.

## 3. Arrange the layout

Drag blocks to reorder them within a column or move them between columns; the order
is stored as a weight. Save the dashboard when the layout looks right. You can
edit, reconfigure, or delete individual blocks from the dashboard form at any
time.

## 4. Place the dashboard on the site

A dashboard doesn't appear anywhere until you place its block:

1. Go to **Structure → Block layout** (`/admin/structure/block`) — this needs
   core's **Administer blocks** permission.
2. Click **Place block** in the region you want, and add the block named
   **Dashboard: _(your title)_**.
3. Configure its visibility (pages, roles, content types) like any other block and
   save.

Because the dashboard is a reusable block, you can place the same one in several
regions or on several pages, and you can create as many independent dashboards as
you need for different sections of the site.

## Doing it in configuration / code

Each dashboard is a `dashboard_entity` config entity (with `title`,
`description`, `columns`, and a `blocks` map), so dashboards export with your
configuration and deploy between environments. Developers can also create one
programmatically — see the [`agent/`](../agent/start.md) docs for a Drush/PHP
example.

## The permission and a hardening note

The module ships one permission, **administer_draggable_dashboard**, which gates
all dashboard and block administration within dashboards.

- The placeable dashboard block is visible to anyone with **Access content**, but
  each block *inside* a dashboard is re-checked with its own access rules at
  render — so a dashboard can't surface content a viewer wouldn't otherwise be
  allowed to see.
- **administer_draggable_dashboard** is not flagged as a restricted permission,
  yet it lets its holder add and configure arbitrary block plugins (with those
  plugins' own settings forms). On its own that's bounded — actually surfacing a
  dashboard still needs core's restricted **Administer blocks** permission to place
  it — but you should still treat this as an administrative capability and grant it
  only to roles you'd trust with block configuration.
