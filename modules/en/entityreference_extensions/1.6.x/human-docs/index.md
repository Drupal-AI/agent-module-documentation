# Entity Reference Extensions — manual setup guide

**Entity Reference Extensions** (`entityreference_extensions`) adds three drop‑in
field formatters for multi‑value entity‑reference fields that let you limit,
offset, reverse, and sort the referenced items at display time — and, for the
rendered variant, show the first few items in a different view mode. It's the easy
way to build a "top items" or curated‑order display from a large reference field
without changing the stored order and without building a View.

The three formatters each mirror one of core's entity‑reference formatters:

- **Rendered entity (PLUS)** (`entity_reference_entity_view_delta`) — renders the
  referenced entities, and can show the first N in an alternate ("featured") view
  mode.
- **Entity ID (PLUS)** (`entity_reference_entity_id_delta`) — outputs the entity
  IDs of the limited/sorted subset.
- **Label (PLUS)** (`entity_reference_label_delta`) — outputs the labels
  (optionally linked) of the limited/sorted subset.

Each adds a **Limit Configuration** (how many items to show, an offset, a reverse
toggle, and whether to limit before or after sorting) and a **Sorting
Configuration** (sort by a field or property on the referenced entities, ascending
or descending; ties break deterministically by field order, and entities missing
the sort value sort to the end). These formatters only appear on fields whose
cardinality is not 1 (that is, multi‑value fields).

There is no admin settings page. The one global value the module has —
`unlimitedcounter`, which caps how many options the limit/offset dropdowns offer
for *unlimited*‑cardinality fields (default 10) — has no shipped UI and is set via
config (see below). The module needs nothing beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no menu item and no settings page. You choose one of its
formatters per reference field on the entity's **Manage display** tab — for
example **Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

1. Go to the **Manage display** tab of the content type (or other bundle) that
   has your multi‑value reference field.
2. In the **Format** column, choose one of **Rendered entity (PLUS)**,
   **Entity ID (PLUS)**, or **Label (PLUS)**.
3. Click the gear icon and configure:

   - **Limit Configuration** — set the **number** of items to show (empty means
     "All"), an **offset** to skip leading items, a **reverse** toggle to limit
     from the end of the list instead of the start, and **limit before sort** to
     choose whether the module slices first then sorts, or sorts first then
     slices.
   - **Sorting Configuration** — pick a **field/property** on the referenced
     entities to sort by (empty keeps the stored delta order) and choose
     **ascending** or **descending**.
   - **Different Display** *(Rendered entity PLUS only)* — enable it to render the
     first **N** items (after sorting and limiting) in an alternate **view mode**,
     leaving the rest in the field's normal view mode. This is how you get a
     "first one featured, the rest compact" layout.

4. Click **Update**, then **Save** the display.

Typical uses: show only the first 3 referenced items, show the *last* 3 (reverse),
sort referenced content by a date or weight field, or present a curated ordering
without touching the stored order.

## Setting the "unlimited counter" (no UI)

For fields with *unlimited* cardinality, the limit/offset dropdowns can only offer
a finite list of numbers; `unlimitedcounter` (default 10) caps that list. There is
no form for it — change it with Drush:

```bash
drush config:set entityreference_extensions.settings unlimitedcounter 25 -y
```

(Prefix with `ddev` when running from your host: `ddev drush config:set …`.)
