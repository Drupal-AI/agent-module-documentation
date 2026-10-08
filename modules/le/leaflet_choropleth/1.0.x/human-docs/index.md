# Leaflet Choropleth — manual setup guide

**Leaflet Choropleth** (`leaflet_choropleth`) adds **choropleth maps** to
Drupal's Leaflet integration — maps that shade geographic regions (countries,
states, districts) according to a data value, so a metric like population, sales,
or incidence can be seen across areas as a colour gradient rather than as a table
of numbers. It builds directly on the **Leaflet Views** submodule, so the regions
and their values come from a **View** of your Drupal content, and the module
renders them as a shaded, interactive Leaflet layer.

It plugs in as a Views *style* plugin (`leaflet_choropleth_map`) that sits
alongside the standard Leaflet map style. Choosing it exposes an extra
**Choropleth Map Settings** section in the View, where you pick the numeric field
that drives the shading, the classification method, the colour scale, the number
of classes, and the legend. Choropleth layers can be combined with ordinary
markers and geometries, so you can mix a shaded‑region analysis with pinned
points on the same map.

A couple of practical notes: choropleth shading applies only to features with
**polygon or multipolygon** geometry (you need region shapes, not just points),
and access to the underlying data is governed by the **View's own access
settings** — this module handles the rendering and has no access‑control role of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Leaflet / Leaflet Views dependency.

There is **no separate configuration page** for this module. All of its settings
live inside the View you build — see "How to use it" below.

## Where it lives in the admin menu

Leaflet Choropleth adds no admin settings page of its own. You use it entirely
from the **Views UI** (**Structure → Views**), by choosing the choropleth map
style on a View and configuring its Choropleth Map Settings there.

## How to use it

1. Make sure the **Leaflet** module and its **Leaflet Views** submodule are
   installed and that you already have a Geofield (or similar) driving your
   Leaflet maps — see the Leaflet and Leaflet Views documentation.
2. Create a **View** of the content or entities you want to map, including a
   **numeric field** (integer or float) to use as the basis for the shading, and
   make sure the mapped features use **polygon / multipolygon** geometry.
3. Set the View's **Format** to the choropleth Leaflet map style. A
   **Choropleth Map Settings** section appears.
4. In that section, enable the choropleth option and:
   - set the **data source** to your numeric field;
   - choose a **classification method** — for example Equal Interval, Geometric
     Interval, Natural Breaks (Jenks), Quantile, or Standard Deviation;
   - choose a **colour range** — Sequential (single‑hue), Diverging (two
     endpoints with a neutral midpoint), or Categorical;
   - set the **number of classes** and the **geometry display** options;
   - configure the **legend** (it can be added as a Leaflet control positioned on
     the map and styled to match).
5. Save the View and view it. You can layer the choropleth with markers and other
   geometries for a multi‑layer map.
