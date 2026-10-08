# Simple Google Maps — manual setup guide

**Simple Google Maps** (`simple_gmap`) adds a **field formatter** that renders a
plain‑text address as an embedded Google Map — an interactive iframe map, a static
map image, a link to Google Maps, or any combination. It is deliberately minimal:
it defines nothing but that one formatter. There's no field of its own, no
JavaScript to configure, and — for the basic iframe map and the map link — **no
Google Maps API key required**.

The way you use it is simple. Add an ordinary core **Text** field (`string` or
`string_long`) to a content type and let editors type a one‑line address that
Google Maps can recognize (for example `100 Madison Ave, New York, NY`). Then, on
the entity's **Manage display** page (or in a View), choose the *Google Map from
one‑line address* formatter for that field. The formatter's per‑display settings
let you independently toggle the dynamic map, a static map image, a link, and the
original address text.

Those settings give you control over the iframe width/height and title, the zoom
level (1–20, default 14), the map type (Map, Satellite, Hybrid, Terrain), the link
text, and the language. Only the **static map image** needs an API key (set in the
formatter settings); the dynamic iframe map and the link work without one. Simple
Google Maps depends on core **Field** and **Text**, has no settings page and no
permissions of its own, and stores its options per display as configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no admin settings page — everything is configured on the field's
display, as described in *How to use it* below.

## Where it lives in the admin menu

Simple Google Maps adds **no admin menu item and no settings form**. It appears as
a formatter option — *Google Map from one‑line address* — when you set up how a
text field is displayed, on a bundle's **Manage display** page (or as a Views
field formatter).

## How to use it

1. Add a core **Text (plain)** or **Text (plain, long)** field to your content
   type and have editors enter a recognizable address.
2. Go to the content type's **Manage display** page and, for that field, choose
   the **Google Map from one‑line address** formatter.
3. Click the formatter's settings gear and configure:
   - Which pieces to show — **dynamic (iframe) map**, **static map image**,
     **link to Google Maps**, and/or the **original address text**.
   - **Size** — iframe width/height in pixels or percent; static maps use bare
     pixels.
   - **Zoom** (1–20, default 14) and **map type** (Map, Satellite, Hybrid,
     Terrain).
   - **Link text** (or reuse the address), **language** (a two‑letter code, or
     `page` to follow the current page language), and accessibility text (iframe
     title, static‑map alt text).
   - An **API key** — only required if you enable the static map image.
4. Save. The map renders wherever the entity (or view) is displayed.

The output is themeable by overriding the `simple-gmap-output.html.twig` template.
