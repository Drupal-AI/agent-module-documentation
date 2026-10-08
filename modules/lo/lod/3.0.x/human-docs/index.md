# Linked Open Data (LOD) — manual setup guide

**Linked Open Data (LOD)** (`lod`) transforms your Drupal content into **JSON-LD**,
the standard format for publishing Linked Open Data. It provides the plugin
scaffolding and a set of default JSON-LD serializers so that your entities can be
exposed as machine-readable linked data — useful for search engines, data
aggregators, and any consumer that speaks JSON-LD.

It works through **Views**. You create a View with a **JSON-LD Export** display and
use the View's filters to control exactly which content is published. Out of the
box it understands common Drupal building blocks: **Node**, **Paragraph**, and
**Term** entities; **Address**, **Entity reference**, **Geofield**, **Image**,
**Text**, **UUID**, and changed/created-time fields; and the Timestamp data type.
Anything it doesn't cover can be added in your own module using the module's
**LodNormalizer** plugin type.

Because publishing JSON-LD means putting content on the open web in a
machine-readable form, treat what you expose with care: make sure only content
meant to be **public** is included, and let your export (and its View) respect
content access — publishing linked data for restricted content would be a
disclosure risk. The module provides its own permission; gate it appropriately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Serialization / Views dependencies.

There is **no dedicated settings page** for this module — you configure output
entirely by building a View with a JSON-LD Export display, described under "How to
use it" below.

## Where it lives in the admin menu

LOD adds no settings page of its own. You use it from the **Views** UI at
**Structure → Views** (`/admin/structure/views`), where you add a **JSON-LD Export**
display to a View. Field-type and entity-type support beyond the built-ins is added
in code via the **LodNormalizer** plugin type.

## How to use it

1. Go to **Structure → Views** and create (or edit) a View.
2. Add a **JSON-LD Export** display.
3. Use the View's **filters** to select exactly which content is exposed — keeping
   in mind it should be content intended to be public.
4. Add the fields you want serialized. The built-in normalizers handle the common
   entity types, fields, and data types listed above; for anything else, implement
   a custom **LodNormalizer** plugin in your own module.
5. Visit the display's path to see the JSON-LD output.
