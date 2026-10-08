# Map Object Field — manual setup guide

**Map Object Field** (`map_object_field`) adds a field type that lets content
editors **draw shapes on a map** and store them as structured data. Instead of
just dropping a single pin, editors can draw circles, lines, polygons, polylines,
rectangles, and markers — each with its own title and description that appears in
an info window when clicked, and each with configurable fill and stroke colours.
It's a natural fit for capturing service areas, delivery zones, routes, or any
region you want tied to a piece of content.

The current version renders maps with **Google Maps**, which means you supply a
Google Maps JavaScript API key once, site-wide. The field's **widget** is
configurable — you decide which shape types editors may draw and how many objects
they can add — and its **formatter** lets you set the width and height of the map
shown on the rendered page.

It depends on core's **Field** module and lives in the Field types package. There
is one small site-wide settings page (for the API key); everything else is
configured per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the Google Maps API key, then
   add and configure the field, its widget, and its formatter.

## Where it lives in the admin menu

The site-wide API-key setting lives at **Configuration → Map Object Field**
(`/admin/config/map-object-field`). The field itself is added and configured on
your content type under **Structure → Content types → *(your type)* → Manage
fields / Manage form display / Manage display**.

## How to use it

1. Set your Google Maps API key on the settings page (see
   [Configuration](configuration/index.md)).
2. Add a **Map Object Field** to any fieldable entity.
3. Configure the **widget** to choose which shapes editors can draw and how many.
4. Configure the **formatter** to set the displayed map's dimensions.
5. Editors then draw shapes on the map, naming and colouring each one; the shapes
   render on the front end with clickable info windows.
