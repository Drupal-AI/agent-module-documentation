# Field Label Override — manual setup guide

**Field Label Override** (`field_label_override`) lets administrators set a
**custom label for a field per entity view display** (view mode), instead of the
single label that a field otherwise carries everywhere it appears.

A field's label is set once, on the field itself, and used in every context — but
that stops being right as soon as the same field shows up in different places.
The `body` field might read "Full Description" on the full node, "Short
Description" in a teaser, and want a shorter label still in a compact card.
Traditionally sites work around this with a preprocess function per view mode, by
creating a duplicate field just to get a different label, or by hiding the label
and baking the wording into a template — each of which pushes an editorial
decision into code and hides it from whoever manages displays. This module makes
the label a **display setting**, so it lives right alongside the rest of your
display configuration, is visible in Manage display, and exports with your
configuration.

It works with fields on **any entity type** — nodes, taxonomy terms, blocks,
Paragraphs, and so on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** for this module — it has no site‑wide
settings form. You set the override per field, per view mode, on the display,
described in "How to use it" below.

## Where it lives in the admin menu

Field Label Override adds no admin page. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage display**, switching to the
view mode you want and editing the field's label there.

## How to use it

1. Go to the entity's **Manage display** and select the **view mode** you want to
   customise (for example *Teaser* or a custom card display).
2. For the field whose label you want to change in that view mode, open its
   settings and enter the **override label** — for example "From" for a start‑date
   field in a compact card, or "Event begins" in a listing.
3. Save the display. The field now shows your custom label in that view mode,
   while other view modes keep their own labels (or the field's default).

Two things worth keeping in mind:

- **On a multilingual site, a label is content.** An override you enter should be
  translatable in the same way the field's own label is — otherwise one
  language's wording can appear across all languages, the commonest pitfall of
  configuration‑level text on translated sites.
- **The label is what a screen reader announces before the value.** A label
  shortened for visual compactness ("From" instead of "Start date") is shorter
  for everyone, including someone who can't see the surrounding layout for
  context — so where you can, keep the accessible wording fuller even when the
  visible label is terse.
