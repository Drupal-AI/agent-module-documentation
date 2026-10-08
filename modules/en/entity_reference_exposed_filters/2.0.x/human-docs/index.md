# Entity Reference Exposed Filters — manual setup guide

**Entity Reference Exposed Filters** (`entity_reference_exposed_filters`) adds a
Views filter that turns an entity‑reference relationship into an exposed dropdown
of the referenced content's **titles** — instead of the raw node IDs a plain
reference filter would show your visitors. So on a listing page, people choose
"Summer Festival" from a select list rather than "42".

The module contributes a single Views filter plugin, **Entity Reference Exposed
Filters Node Titles** (`eref_node_titles`), registered on the Content
(`node_field_data`) table. You use it in a View that already has an
entity‑reference **relationship** — a "Content referenced from …" relationship. The
filter reads that relationship, works out which referenced content type(s) it
points at, and builds the exposed dropdown's options from those nodes' titles
(keyed internally by node ID). The filter is **always exposed** — its expose
toggle is disabled — so once you add it, it shows up as part of the View's public
UI.

A few options let you control the option list: how it is sorted (by title or by
node ID, ascending or descending), how bundles are ordered when the reference can
point at more than one content type, whether unpublished/published/all referenced
nodes appear, and whether to drop options that would return no results.

Note the scope: this works on **node reference fields only** — not taxonomy terms
or users — and reference fields whose selection is driven by a View are not
supported. It depends on core **Views** and has **no admin settings page of its
own**; everything is configured inside the View.

This guide is written for a **human** clicking through the Views UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no admin page, no permissions, and no Drush commands. Its one
feature is the Views filter, which you reach from inside any View at **Structure →
Views** (`/admin/structure/views`).

## How to use it

The filter needs a View with an entity‑reference **relationship** in place first:

1. **Add the relationship.** In your Content View, open **Advanced →
   Relationships → Add** and choose a "Content referenced from `<field>`"
   relationship (a node entity‑reference field). The filter only accepts standard
   node reference relationships — it ignores comment/user/nid/target_id
   relationships and will mark itself broken if none is valid.
2. **Add the filter.** Under **Filter criteria → Add**, search for **Entity
   Reference Exposed Filters Node Titles** (on the Content table) and add it.
   Because it is always exposed, it immediately appears as an exposed dropdown of
   referenced node titles on the View.
3. **Tune its options** in the filter settings form:

   - **Sort by** — `title` or `nid`: which attribute the option list is sorted on.
   - **Sort order** — `ASC` or `DESC` for the option list.
   - **Sort bundle order** — `ASC` or `DESC`, used when the reference targets more
     than one content type.
   - **Get unpublished** — *Unpublished*, *Published*, or *All*: which referenced
     nodes appear as options.
   - **Get filter no results** — whether to drop options that would return zero
     results.

Save the View. Visitors now get a human‑readable select list of referenced content
titles that stays in sync with your published nodes — no internal node IDs exposed
in the filter labels.
