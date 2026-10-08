# Entity Reference Revisions Context — manual setup guide

**Entity Reference Revisions Context** (`entity_reference_revisions_context`) is a
field formatter that adds **contextual `data-*` attributes** to the markup of
entity-reference-revisions fields — the field type used by **Paragraphs**. Those
attributes tell your theme and JavaScript where each item sits within the list, so
you can style or script a set of referenced entities based on their position and
their neighbours.

The formatter adds attributes such as:

- `data-entity-context-first` — on the first item in the field.
- `data-entity-context-last` — on the last item.
- `data-entity-context-prev="{bundle}"` — the bundle of the previous item.
- `data-entity-context-next="{bundle}"` — the bundle of the next item.
- `data-entity-context-group="{bundle-group-number}"` — an incrementing group
  number, where a group is a run of consecutive items with the same bundle.
- `data-entity-context-odd` / `data-entity-context-even` — the item's odd/even
  position (delta) in the list.

This is invaluable when theming Paragraphs: you can, for example, alternate
background colours, remove spacing between two paragraphs of the same type, or
change layout when a paragraph of one bundle follows another. It is a
content‑display feature that only adds attributes — the referenced entities render
respecting their own access, and the module has no access‑control role. It depends
on the contributed **Entity Reference Revisions** module and runs on Drupal 8
through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Entity
   Reference Revisions dependency with Composer, then enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You select the "with context" formatter on the field's *Manage display*,
described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference Revisions Context adds no admin settings page. You use it from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
display** (typically on a Paragraphs field).

## How to use it

1. Go to the **Manage display** page of an entity that has an entity-reference-
   revisions (Paragraphs) field (for example **Structure → Content types → Landing
   page → Manage display**).
2. Set that field's **Format** to the Entity Reference Revisions Context formatter
   (the "rendered entity with context" option).
3. Click **Update**, then **Save** the display.
4. In your theme's CSS/JS, target the new `data-entity-context-*` attributes to
   style or script items by their position, bundle, and neighbours.
