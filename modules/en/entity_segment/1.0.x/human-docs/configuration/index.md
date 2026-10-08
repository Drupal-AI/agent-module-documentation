# Configuration

Setting up Entity Segment has two stages: first you define a **segment type**,
which binds the generic segment engine to one target entity type; then you create
individual **segments** of that type using the visual condition builder.

## Step 1 — Define a segment type

A segment type is the "bundle" of the segment entity, and its job is to name the
**target content entity type** that its segments will select.

1. Log in as a user with the **Administer segment types** permission.
2. Go to **Structure → Segment types** (`/admin/structure/segment-type`) and add a
   new segment type.
3. Give it a label and choose the **target entity type** — the content entity type
   whose entities this segment type's segments will select (for example `node`,
   `user`, or a Commerce order). The target must be a queryable content entity
   type (one with base‑table storage).

Each segment type you create gets, for free, its own listing, an **Add segment**
flow, and its own set of access permissions. Because the segment entity is
bundleable, you can also add your own fields to a segment type via **Field UI** —
a description, a campaign reference, an external‑audience id, and so on.

You can also ship a segment type as install configuration from a custom module if
you prefer to manage it in code rather than the UI.

## Step 2 — Build a segment

1. From a segment type's listing, use **Add segment**.
2. Give the segment a name and build its membership rule with the **visual
   condition builder**: nested **AND/OR groups**, where each condition is shown as
   a plain‑language summary.
3. Add conditions with the shipped **Field value** plugin. It compares any field of
   the target entity and offers operators appropriate to the field's data type —
   string *contains* / *starts with*, numeric or date *greater than* / *between*,
   and so on. (These operator sets are derived from each field's Views filter
   handler, so any contrib field that ships correct Views data gets sensible
   segment operators automatically.)
4. To compare fields on *referenced* entities, use **multi‑hop reference
   traversal** — descend through entity reference fields one hop at a time, to any
   depth (for example an order's customer's country).
5. Save. The segment resolves **live** against current data — there is no
   materialised list to rebuild, so a segment always reflects the site as it is
   right now.

Segments are **revisionable** and can be scoped as **global** or **personal**.

## Permissions

Entity Segment provides granular permissions under **People → Permissions**:

- **Administer segment types** — create and manage the segment types themselves
  (Step 1).
- **Administer segments** — manage segments.
- Additionally, each segment type generates its own node‑style set of
  per‑type permissions, so you can control who may create, edit, view or delete
  the segments of each individual type.

## Exposing an audience safely

A segment's **membership** (the entities it resolves to) is more sensitive than its
**definition** (its rules). The raw resolver is deliberately not access‑filtered,
so when you render or export an audience to a particular user, always go through the
viewer‑safe accessible‑resolution path rather than the raw resolver. The segment
entity type also ships query‑level access, so listings, Views of segments and
JSON:API collections return only the segments a viewer is entitled to see.
