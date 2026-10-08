# Sortable Views — manual setup guide

**Sortable Views** (`sortableviews`) lets people reorder the rows of a View by
**drag‑and‑drop** and saves the new order straight onto the entities. It is a
lighter alternative to Draggable Views: instead of keeping weights in its own
database table, it writes each row's position into an ordinary integer field on the
entity, so the order lives in your content and stays queryable and easy to migrate.

You build a sortable view entirely inside Views — there is no settings page,
permission, or Drush command of its own. The module gives you three drop‑in Views
**formats** (a sortable unformatted list, a sortable HTML list, and a sortable
table), a **drag‑handle** field you add to show the grip, and a **Save** area you
put in the header or footer. When a user drags rows into a new order and clicks
Save, the new positions are written back to the entities over AJAX, without a full
page reload.

Because the order is stored in a real entity field, who is allowed to reorder is
governed by core's normal entity permissions: a user must have **update** access to
the listed entities (and to the weight field). No new permission is introduced.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Everything is configured on the View. To turn a listing into a sortable one:

1. **Make sure there's a spare integer field** on the entity type to hold the
   order — for example an integer field `field_weight`. This is where each row's
   position is saved.
2. **Set the View's Format** to one of the sortable styles: *Sortable unformatted
   list*, *Sortable HTML List*, or *Sortable table*.
3. In that format's **settings**, set **Weight field** to the view field that maps
   to your integer field.
4. **Add the weight field** to the view as a field (so the setting above can
   reference it), and **also add it as a Sort criterion** (ascending or descending)
   so rows display in their stored order.
5. **Add the drag handle**: add the field *Sortableviews: Drag and drop handle.* —
   this renders the grip users drag.
6. **Add the Save button**: put the *Save Sortableviews changes* area in the view's
   **header or footer**. This is the button users click to persist a new order; it
   only appears once rows have been moved.

The view is now sortable for anyone with update access to the listed entities.

### Good to know

- Saving a new order **overwrites** each entity's weight with its new position.
- It works across pagers — positions are adjusted correctly for the current page.
- Avoid pointing two sortable views at the same entity type/bundle, or their
  weights will fight each other.
- Some Stable‑based themes need the view's `.view-content` wrapper present for the
  drag JavaScript to find the rows.
