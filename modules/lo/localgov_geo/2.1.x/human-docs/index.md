# LocalGov Geo — manual setup guide

**LocalGov Geo** (`localgov_geo`) gives a LocalGov Drupal site reusable geographic
records: a location entity you can store once and reference from many content items —
events, venues, services — rather than duplicating address and coordinate fields
everywhere. A location can be a point with a structured address or an area drawn as a
polygon (a ward or catchment boundary, say). Out of the box it's wired to
OpenStreetMap for both map tiles and geocoding, with an optional Ordnance Survey Places
geocoder for accurate UK address lookups.

An important architectural note: since version 2, **the location entity itself lives in
the contrib Geo Entity module** (`geo_entity`), which is a required dependency.
LocalGov Geo is the LocalGov-flavoured wrapper around it — it supplies sensible default
configuration, the bundles (via submodules), the UK geocoder plugin, and editorial
polish (tidier action/tab links, breadcrumbs, page titles) that makes the entity
comfortable to use inside a council site. There is **no settings page of its own** and
**no permissions of its own** (though see the note below about what it grants on
install).

The entity types come from three submodules you enable as needed:
**`localgov_geo_address`** (a point plus a structured address), **`localgov_geo_area`**
(polygons/areas), and a hidden **`localgov_geo_update`** submodule that bridges older
installs onto Geo Entity. Because the defaults point at OpenStreetMap, the module works
before you obtain any API key.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and pick the bundle submodules you need.

## Where it lives in the admin menu

There's no dedicated configuration form. Location records are managed as entities, and
the geocoder provider (OpenStreetMap by default, or Ordnance Survey Places) is
configured through the **Geocoder** module's settings, not here.

## How to use it

1. **Enable a bundle submodule** for the kind of location you need —
   `localgov_geo_address` for points with addresses, `localgov_geo_area` for polygon
   areas.
2. **Create location records** and reference them from your content. Editors can search
   for an address rather than typing coordinates.
3. **(UK sites) Use Ordnance Survey Places** for accurate UK address geocoding — it's
   free for UK local authorities but needs an API key and the extra Composer package
   (see [Installation](installation/index.md)). Until then, OpenStreetMap geocoding
   works with no key.

> **Public-by-default location data — read this.** On install, LocalGov Geo grants the
> **View geo** permission to *both anonymous and authenticated* users, on purpose:
> location data is meant to be public, and Search API only indexes what anonymous users
> can see, so withholding it would strip locations from search results. If your site
> genuinely needs to hide location data, you can revoke that permission after install —
> but expect it to disappear from search as a consequence.

## Submodules

| Submodule | What it adds |
|---|---|
| `localgov_geo_address` | A location bundle: a point plus a structured address. |
| `localgov_geo_area` | A location bundle for polygons/areas (boundaries, catchments). |
| `localgov_geo_update` | Hidden bridge that migrates older LocalGov Geo installs onto Geo Entity. You don't enable this by hand for a new site. |
