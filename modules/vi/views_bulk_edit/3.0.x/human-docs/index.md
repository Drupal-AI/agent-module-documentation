# Views Bulk Edit — manual setup guide

**Views Bulk Edit** (`views_bulk_edit`, often shortened to **VBE**) adds a
**"Modify field values"** bulk action that lets you change the field values of
many entities at once — straight from a View. Instead of opening hundreds of
nodes one by one to set the same author, category, or status flag, you filter
them in a View, tick the ones you want, choose exactly which fields to change,
enter the new values, and apply them to the whole selection in a single pass.

It works with entities of any type — nodes, users, media, taxonomy terms — and
can even edit a mix of bundles in one View, rendering a separate form section
per bundle. For each field you change, you pick a **change method**: *Replace*
(overwrite the value), *Append* (add onto the end of a text field), or *Add a
new value* (merge into a multi‑value field without wiping what's there).
Revisionable entities also get a "Create new revision" toggle with a log
message. Which fields are offered comes from each bundle's `bulk_edit` entity
form mode, so you can define that form mode to control exactly what is
bulk‑editable (it falls back to the default form display if you don't).

VBE has **no admin settings page** — you don't configure it centrally. Instead
you add its action to a View and configure it per run. It has no hard module
dependencies beyond Drupal core, but the [Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)
(VBO) module is a strongly recommended companion: it adds batching (so large
edits don't time out), a "select all results in this view" option, and a
selection that persists across paged results. VBE can also work core‑only,
without VBO, through a shipped core Action and a confirm form at
`/admin/content/bulk-edit`. It provides one permission, `use views bulk edit`.

This guide is written for a **human** setting the module up and using it. If you
want terse, token‑cheap references for an AI coding agent — including how to
subclass the action or define the `bulk_edit` form mode — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   (recommended) enable Views Bulk Operations too.

## Where it lives in the admin menu

There is no dedicated settings page. VBE surfaces in two places:

- Inside the **Views UI** (`/admin/structure/views`) as a *Modify field values*
  action you add to a View — this is the recommended, VBO‑driven path.
- At **`/admin/content/bulk-edit`** — the confirm form used by the core‑only
  path after you run the bulk edit action from a standard admin content listing.

## How to use it

**The recommended path (with Views Bulk Operations):**

1. Create or edit a View — a **Table** display gives the most convenient editor
   experience.
2. Add a field → **Views bulk operations** (Global), and place it first. (This
   requires the `views_bulk_operations` module.)
3. In the VBO field settings, tick the **Modify field values** action.
4. Save the View. When you use it, select the rows you want, choose **Modify
   field values**, and you'll get an edit form with one collapsible section per
   bundle in your selection.
5. In that form, tick **which fields to change**, set each field's value and
   change method (*Replace*, *Append*, or *Add a new value*), optionally create
   a new revision, then confirm — VBO batches the edits.

**The core‑only path (without VBO):** VBE also ships a core Action derived for
nodes, users, media, and taxonomy terms. Selecting it on a standard admin
"Action" bulk form stashes your selection and redirects you to the confirm form
at **`/admin/content/bulk-edit`**, which renders the same edit form and saves on
submit. Access to that confirm form is gated by the **`use views bulk edit`**
permission.

In both paths, a user can only bulk‑edit entities they already have permission
to edit — every entity is additionally checked for `update` access — so the
permission alone does not let someone edit content they otherwise couldn't.

**Performance tip:** on very large "all results" selections, the VBO action has a
fixed *Get entity bundles from results* option (checked by default, which is the
accurate choice). If you hit performance issues, unchecking it and adding a
bundle filter (a node type or vocabulary filter) to the View avoids an extra
query.
