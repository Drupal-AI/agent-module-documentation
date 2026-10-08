# Geofield polygon select — manual setup guide

**Geofield polygon select** (`geofield_polygon_select`) lets editors **pick a
named polygon from a predefined list** instead of drawing geometry by hand. You
load one or more GeoJSON feature collections up front — a set of countries,
regions, cities, or districts — and editors then choose from a simple dropdown.
The result is consistent, standardized shapes across all your content, with no
free‑hand variation between editors.

Setup has two halves. First, you create **feature collection** config entities:
each one holds a GeoJSON `FeatureCollection` plus a "keyholder" property that
names each feature's index (for example `city_name`). Second, you add a Geofield
to your content type and set its form widget to **Polygon select**; in the
widget's settings you choose which collections are available and in what order.
Editors then get a two‑step picker — choose the collection, then choose a feature
within it.

How the chosen polygon is stored depends on the field:

- On a **plain Geofield**, the module writes only the geometry as WKT (just like
  Geofield normally does). When a feature is picked it also dispatches an event
  carrying the entity, the chosen shape, its key, and the collection ID — so a
  developer can subscribe and populate a related text or taxonomy field.
- On the module's **extended field type** (`GeofieldPolygonItem`), it additionally
  stores the selected feature's GeoJSON, its collection machine name, and the
  feature name. The extended type can also **sync** the chosen geometry into
  another Geofield on the same entity just before save — useful because the
  extended type can't use the formatters that work with a plain geofield, so this
  gives you "the best of both worlds."

It depends on the **Geofield** module (and the `jmikola/geojson` PHP library).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Geofield dependency.

There is **no single settings form** for this module. You set it up by creating
feature‑collection config entities and then configuring the field widget, both
described in "How to use it" below.

## Where it lives in the admin menu

The module adds an admin **list of feature collections** (managed as config
entities), where you create and manage the GeoJSON collections editors will pick
from. The per‑field choices — which collections are enabled and their order —
live on the field's form‑display settings (the gear/cog icon on **Manage form
display**).

## How to use it

1. **Create one or more feature collections.** From the module's feature‑collection
   admin list, add a collection: paste in a GeoJSON `FeatureCollection` and set
   the **keyholder** — the property inside each feature that names it (for
   example `city_name`, so a feature's `barcelona` value becomes its label).
   Repeat for each set of shapes you want (countries, regions, districts, …).
2. **Add a field to your content type.** Choose either a plain **Geofield** (stores
   only WKT) or the module's extended **Geofield polygon** field type (also stores
   the GeoJSON, collection name, and feature name). Pick the extended type if you
   want to keep the richer metadata or sync into a second geofield.
3. **Set the widget.** On the content type's **Manage form display**, set that
   field's widget to **Polygon select**. Open the widget's settings (the cog) to
   choose which collections are **enabled** and to **order** them. If you're using
   the extended field type, you can also choose another Geofield on the same
   entity to **sync** the selected geometry into just before save.
4. **Edit content.** Editors now see a two‑step picker — first the collection,
   then a feature within it — and the chosen polygon is stored according to the
   field type.
5. *(Optional, for developers)* On a plain Geofield the module only writes WKT, so
   subscribe to the `PolygonSelectFieldSelectedEvent` (dispatched on save) to
   populate a related text or taxonomy field from the selection.
