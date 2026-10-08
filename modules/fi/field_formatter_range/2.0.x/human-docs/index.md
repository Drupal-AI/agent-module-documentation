# Field Formatter Range — manual setup guide

**Field Formatter Range** (`field_formatter_range`) lets you show only a *subset*
of a multi-value field's values in a given display — the first two, the last
three, a random one, everything-but-the-first — without building a View or writing
custom preprocess code. It adds three controls (**order**, **display items**, and
**skip items**) to the settings of *any* field formatter, so it works on image,
link, text, number, entity-reference and every other multi-value field alike.

The clever part is that it changes only what visitors *see*, per display — your
stored field values are never touched. That means you can keep a field multi-value
in your content model but curate the output differently in each view mode: full
shows all values, teaser shows just the first one, a sidebar shows a single random
pick, and so on. Because it operates at render time you can also mix it with
Layout Builder component formatters.

There's nothing to switch on globally and no settings page of its own
(`configure: null`) — once the module is enabled, the extra controls simply appear
on the **Manage display** page for multi-value fields. This guide is written for a
**human** clicking through the admin UI; if you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead. The module depends only on core's **Field** module, has no submodules,
and adds no third-party libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

It has no page of its own in the admin menu. Instead it adds a **Field Formatter
Range** section directly into the formatter settings on each bundle's *Manage
display* page — for example **Structure → Content types → Article → Manage
display** (`/admin/structure/types/manage/article/display`). The section only
appears on **multi-value** fields (fields whose cardinality is not 1); a
single-value field has no range to speak of, so nothing is added there.

## How to use it

1. Go to the bundle's **Manage display** page and choose the view mode you want to
   affect (Default, Teaser, or a custom one).
2. Click the **gear/cog icon** on a **multi-value** field's row to open its
   formatter settings.
3. Open the **Field Formatter Range** details and set the three controls:

   - **Order** — how the values are ordered before slicing:
     - *Default* — leave them in their stored order.
     - *Reverse* — flip the order (handy for "show the most recent" when values are
       stored oldest-first).
     - *Random* — shuffle on each render (good for rotating testimonials, quotes,
       or a random image).
   - **Display items** — how many values to show. `0` means show all. For example,
     `2` shows just two.
   - **Skip items** — how many values to skip from the beginning (an offset). For
     example, `1` hides the first value — useful to drop a "featured" first image
     from a grid. Combine skip and display to show a middle slice (skip 1, display
     3 → items 2–4).

4. Click **Update**, then **Save**. A summary line confirms the result, e.g.
   *"Display 2 items in reversed order. Offset by 1."*

To turn the behaviour off again for a formatter, set **Order** to *Default* and
both **Display items** and **Skip items** to `0`, then save.

Because these are display settings, they export as part of your display
configuration (under the field's third-party settings) and deploy between
environments like any other config. See the [`agent/`](../agent/start.md) docs for
the exact config keys and a scripting example.
