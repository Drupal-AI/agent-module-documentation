# Field Layout — manual setup guide

**Field Layout** (`field_layout`) lets **Manage display** and **Manage form
display** arrange a bundle's fields into the *regions* of a layout — for example a
two-column or three-column layout — instead of one flat, ordered list. You pick a
layout for a given view mode or form mode, then drag each field into a named region
of that layout. The choice is stored in the display configuration, so it travels
with a normal config export.

This is the **contrib continuation of the core experimental module of the same
name**. `field_layout` shipped in Drupal 8 as an experimental core module, was
never promoted to stable, and was removed from core in 11.3. This project picks it
up so sites that relied on it can keep working. Its `core_version_requirement` is
deliberately set to `>11.3`, which means it **refuses to install on any core that
still ships its own copy** — so the two can never both be active and there is no
ambiguity about which one is in charge.

It is worth knowing how this differs from **Layout Builder**, because they solve
overlapping problems differently. Field Layout arranges *the fields of one
entity's display* into regions — a per-bundle, per-view-mode decision a site
builder makes once. Layout Builder arranges *blocks on a page*, can go per
individual entity, and can place things that are not fields at all. Field Layout is
much smaller, has no per-entity override, and gives editors no new interface to
learn. If all you ever wanted was your fields in two columns, that simplicity is
the whole point.

Because it is minimally maintained and its functionality overlaps heavily with
core's Layout Builder, it is best treated as a way to preserve an existing display
arrangement rather than something to reach for on a brand-new site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it adds no settings form,
routes, or permissions. You use it entirely from the display screens described
below.

## Where it lives in the admin menu

Field Layout adds no admin page of its own. You use it from **Structure → Content
types (or any entity bundle) → *(bundle)* → Manage display** and **Manage form
display**.

## How to use it

1. Go to a bundle's **Manage display** (for the rendered entity) or **Manage form
   display** (for the edit form).
2. At the bottom of the screen you'll find a new **Layout** selector. Choose a
   layout — core provides two-column and three-column options, and any layout a
   theme or module defines (via `layout_discovery`) is available too.
3. The field table now shows the layout's **regions**. Drag each field into the
   region where it should appear.
4. **Save**. The rendered entity (or the edit form) now lays its fields out in the
   layout's regions, styled by that layout's own template.

You can choose a different layout per view mode and per bundle, so a "Teaser"
display can use one arrangement while the "Full content" display uses another.
