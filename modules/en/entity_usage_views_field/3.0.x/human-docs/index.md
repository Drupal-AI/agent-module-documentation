<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Views Field — manual setup guide

**Entity Usage Views Field** (`entity_usage_views_field`) adds a single Views field —
**"Entity usage count"** — that shows, for each row, how many times that entity is
used elsewhere on your site. It is a thin layer on top of the
[Entity Usage](https://www.drupal.org/project/entity_usage) module, which does the
actual work of tracking references between entities; this module just surfaces that
tracked data as a column you can drop into any view.

The typical use is a "content health" or cleanup report: add the field to a Media,
Content, or Taxonomy view and each row gains a number telling you how heavily that
item is referenced. A count of zero flags an orphaned file, an unused term, or a page
nothing links to — exactly the things you want to find before an archive or cleanup.

The count is **revision-aware**: it only counts references recorded against each
source entity's current (default) revision, so superseded drafts are not
double-counted. Achieving that accuracy means the value is computed in PHP per row
rather than in the database query, which has one important consequence — the field is
**not sortable and not filterable** in Views. You can display the number, but you
cannot order or filter a view by it.

There is no settings form. You "configure" the module entirely by adding its field to
a view, so this guide folds the usage instructions into this page rather than into a
separate configuration section.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Entity Usage).

## Where it lives in the admin menu

The module adds no admin page of its own. Its field appears inside the **Views UI**
(*Structure → Views*) when you add a field to a view whose base entity type is
tracked by Entity Usage.

## How to use it

### Before you start

- **Entity Usage** must be enabled and must have recorded some usage data (it builds
  this up as content is created and referenced).
- The view you are editing must have a **base table** matching the entity type you
  want counts for — a Content view for nodes, a Media view for media, and so on.
- If Entity Usage's *tracked target entity types* setting lists specific types, the
  field is only offered for those types. If that setting is empty, the field is
  offered on every entity type that has Views data.

### Add the field

1. Edit the view and click **Add** next to **Fields**.
2. Search for **Entity usage count** and add it.
3. Save. Each row now shows the number of other entities whose current revision
   references it.

### Optional: make the number a clickable modal

You can turn the count into a link that opens the entity's Entity Usage report in a
pop-up dialog:

1. Add a field that outputs the entity's usage URL (for example `/node/{{ id }}/usage`),
   placed **before** the usage-count field.
2. Edit the **Entity usage count** field, open **Rewrite results**, tick *Output this
   field as a custom link*, and put the usage-URL token in the **Link path**.

The module automatically adds the AJAX/modal attributes to that link, so it opens in
a dialog rather than a full page. (This requires the *local tasks / usage report*
option to be enabled for that entity type in Entity Usage's settings.)

### Common uses

- Add an "in use" count next to each item in a media library view to spot unused
  files.
- Build a "safe to delete" report of taxonomy terms or nodes whose count is 0.
- Show editors how heavily each page is referenced in an admin content view.
- Export a view with usage counts (including as a REST export) to audit reusable
  media before a migration or cleanup.

### Remember

- The field is **not sortable and not filterable** — you can combine it with filters
  on *other* fields (for example, restrict to one content type), but you cannot order
  the view by usage count itself.
- It counts only usages recorded against each source entity's **current/default
  revision**.
