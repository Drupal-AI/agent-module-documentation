# Geocoder — manual setup guide

**Geocoder** (`geocoder`) is a **geocoding framework** for Drupal. It converts
addresses and free-text location strings into geographic coordinates
(*geocoding*) and turns coordinates back into readable addresses (*reverse
geocoding*). It does this through **pluggable providers** — services such as
Google Maps, Nominatim / OpenStreetMap, ArcGIS, Mapbox, TomTom and many others —
so you can pick whichever backend suits your site, budget and accuracy needs.

Geocoder wraps the popular `willdurand/geocoder` PHP library and exposes it to
Drupal as a `geocoder` service with `geocode()` and `reverse()` methods.
Results can be transformed into GIS formats (GeoJSON, WKT, WKB, GPX, KML, plain
address text) by **Dumper** plugins, or into display strings by **Formatter**
plugins. On top of the framework, Geocoder ships **field widgets and formatters**
(via its `geocoder_field` submodule) that let you geocode one field's value into
another — for example turning a text address into map-ready coordinates when an
entity is saved.

This guide is written for a **human** clicking through the admin UI. It walks you
step by step, with screenshots, from installing the module to configuring a
geocoding provider. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Geocoder configuration page, showing the Configuration and Providers tabs and the caching, presave and queue options](images/settings.png)

## Where it lives in the admin menu

Geocoder's settings live under **Configuration → System → Geocoder**
(`/admin/config/system/geocoder`). That page has two tabs:

- **Configuration** (`/admin/config/system/geocoder`) — global options such as
  result caching, queueing and disabling geocode-on-save.
- **Providers** (`/admin/config/system/geocoder/geocoder-provider`) — the list of
  geocoding providers you have set up, and where you add new ones.

## Contents

1. [Installation](installation/index.md) — install Geocoder and its PHP library
   dependencies with Composer, then enable the module.
2. [Configuration](configuration/index.md) — set the global options, create a
   geocoding provider, and wire geocoding onto a field.
