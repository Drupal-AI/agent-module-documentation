# Entity Reference Dynamic Display — manual setup guide

**Entity Reference Dynamic Display** (`entity_reference_dynamic_display`) adds a
field formatter that renders each referenced entity with a *different* view mode
— chosen either by the referenced entity's bundle or by the item's position
(delta) in the field. Core's rendered-entity formatter renders every referenced
item in one fixed view mode; this formatter lets a single reference field mix
displays.

The problem it solves shows up on reference fields that hold a mix of things.
A Paragraphs field where the first item should render as a hero and the rest as
teasers; a "related content" field where articles, events, and pages each want
their own display mode — with this formatter you map those differences directly
on the field's display instead of building separate fields or templates.

It works on both `entity_reference` and `entity_reference_revisions` (Paragraphs)
fields, which makes it well suited to Layout Builder and Paragraphs-heavy
displays. Because it extends core's `EntityReferenceEntityFormatter`, it
inherits core's referenced-entity access checks and recursion protection — it
only decides which view mode to hand to the entity view builder. There are no
routes, permissions, or endpoints.

There is nothing to configure globally — the module simply adds a formatter you
select per field. Note this project targets Drupal 8, 9, and 10
(`^8 || ^9 || ^10`); confirm compatibility before using it on Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
All setup happens on a reference field's *Manage display*, described in "How to
use it" below.

## Where it lives in the admin menu

Dynamic Display adds no admin page. You use it entirely from **Structure →
Content types (or other bundles) → *(bundle)* → Manage display**, by choosing
the **Dynamic Display** formatter on a reference field.

## How to use it

1. Go to the host bundle's **Manage display** and find your entity-reference (or
   Paragraphs) field.
2. Set its **Format** to **Dynamic Display**.
3. Open the formatter's settings (the gear icon) and pick an **override mode**:
   - **None** — behaves exactly like core's rendered-entity formatter, using a
     single view mode for every item.
   - **Select view modes based on target bundle** — map each referenced bundle
     to its own view mode (for example Article → Teaser, Event → Card).
   - **Select view modes based on item delta** — map item positions to view
     modes (for example delta 0 → Hero, everything else → Teaser).
4. Set the **default view mode**, used whenever no specific mapping applies, and
   **Save** the display.
