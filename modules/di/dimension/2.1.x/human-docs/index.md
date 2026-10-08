# Dimension — manual setup guide

**Dimension** (`dimension`) provides three **calculated field types** — **Length**,
**Area**, and **Volume** — that let editors enter component measurements and have
the module store and display the derived product automatically. Enter a width and
a height, and the Area field computes and stores the area (width × height). Enter
length, width, and height, and the Volume field stores the volume.

The point of the module is that the total is *calculated*, not typed. That keeps
derived measurements consistent (no manual‑arithmetic mistakes) and gives you a
real numeric `value` you can sort or facet on in Views. As the editor types the
components on the form, a disabled "Dimension" total updates live so they can see
the result immediately.

Each component can be tuned: a **factor** (for unit conversion), a **min**/**max**,
decimal **precision** and **scale**, and **prefix**/**suffix** strings (for example
`cm` on the inputs and ` m²` on the computed total). Displaying values is flexible
too — a plain formatter shows the computed total with its unit, and a "Components"
formatter shows the raw parts through a template like `12 x 8`. The module depends
only on core's **Field** module and needs PHP 8.1+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per‑field storage and field
   settings (factor, min/max, prefix/suffix, precision, scale), field by field.

## Where it lives in the admin menu

Dimension has **no module settings page**. You configure everything on the field
itself, under **Structure → Content types → [type] → Manage fields**, when you add
or edit a Dimension field. There are no permissions of its own.

## How to use it

1. Edit a content type under **Manage fields** and **Add field**.
2. Choose one of the three field types: **Length**, **Area**, or **Volume**.
3. On the field settings, tune each component's factor, min/max, prefix/suffix,
   precision, and scale (see [Configuration](configuration/index.md)).
4. On **Manage form display**, the widget shows one number input per component
   plus a read‑only live total.
5. On **Manage display**, pick a formatter:
   - the **value** formatter (Length / Area / Volume) shows the computed total
     with its prefix/suffix, e.g. `96 m²`;
   - the **Components** formatter (Area or Volume) shows the raw parts, e.g.
     `12 x 8`.

When an editor saves the entity, the module multiplies each component by its
factor, multiplies the components together, rounds to the configured scale, and
stores the result in the field's `value`.
