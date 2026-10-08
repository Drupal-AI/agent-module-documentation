# Draggable Mapper — manual setup guide

**Draggable Mapper** (`draggable_mapper`) lets editors build interactive image
maps by placing draggable markers (hotspots) onto an image. You upload a picture
— a floor plan, a diagram, a photograph, a custom map — then drag markers onto
the spots that matter, giving each one a title, a rich‑text description, and an
optional custom icon. Visitors can then interact with those markers to reveal the
information behind them.

It's built for annotating any visual: building and campus floor plans, evacuation
maps, system diagrams (rigging, HVAC, electrical, plumbing, network layouts),
educational illustrations, and general image annotation. Each map is stored as
its own content entity, so maps can be embedded elsewhere through an entity
reference field or visited directly at their own URL.

Under the hood it uses core's **Field**, **Image**, and **Text**, plus the
**Paragraphs** and **Inline Entity Form** modules and several jQuery UI pieces
(draggable, droppable, resizable) to provide the drag‑and‑resize editing
interface. Because it defines its own entity type and permissions, you decide
which roles may create and manage maps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Paragraphs / Inline Entity Form / jQuery UI dependencies.

There is **no module‑wide settings form** — you build maps directly through the
Draggable Mapper entity add/edit screens described in "How to use it" below. Grant
its permissions on **People → Permissions**.

## Where it lives in the admin menu

Draggable Mapper adds a content entity type reached from **Structure → Draggable
Mapper Entities**. You create a new map at
`/admin/structure/draggable-mapper-entity/add`. Marker icons live on the **DME
Marker** paragraph type under **Structure → Paragraph types**, if you need to
adjust their fields.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)), and
   grant the Draggable Mapper permissions to the roles that should manage maps.
2. Go to **Structure → Draggable Mapper Entities → Add Draggable Mapper**
   (`/admin/structure/draggable-mapper-entity/add`) and **upload a map image**,
   then give the map a title and description.
3. Click **Add Marker** to create a marker. Fill in its title and description,
   then **drag it to the right spot** on the image and **resize** it as needed.
   Optionally upload a custom icon/image for the marker.
4. Save the form to store each marker's position and details. Repeat for as many
   markers as the map needs.
5. **Embed the map** where you want it — reference it from an entity reference
   field on another piece of content, or link to the map's own URL.

Markers can be configured to display in different ways: title only, title with an
expandable description, a custom icon with the title as a hover tooltip, or a
custom icon with an expandable description.

> **Tip:** Drupal's image fields only offer limited SVG support out of the box. If
> you want SVG marker icons, install the **SVG Image** module and add `svg` to the
> allowed extensions on the marker icon field (under **Structure → Paragraph types
> → DME Marker → Manage fields → Icon → Edit**).
