# Mapkit — manual setup guide

**Mapkit** (`mapkit`) is a **provider-agnostic mapping framework** for Drupal. It
provides the plumbing for rendering maps, geolocation inputs, and proximity
searches, but deliberately ships **no map provider of its own** — you add one
through a companion module such as
[Mapkit Google Maps](https://www.drupal.org/project/mapkit_gmap). Think of it as
the foundation you build a mapping feature on, choosing the actual map SDK
separately.

Out of the box it defines the plugin managers (for map providers, markers,
location resolvers, location inputs, and geo-parsers), a **`mapkit_map` field
formatter**, theme hooks for map/autocomplete/geolocation output, and rich
**Views integration** — a location row, style, field, filter, and argument, plus a
Search API location data type for indexed proximity search. A **MarkerSet** config
entity groups marker styles, and a geo-parser strategy widens the map formatter to
any field type a parser can read coordinates from.

The one admin route lists the installed map providers and links to each provider's
own configuration form. It's gated by the **Administer mapkit providers**
permission (a second permission, **Administer mapkit markers**, guards marker
configuration). There are no anonymous or mutating endpoints. Mapkit requires the
[Toolshed](https://www.drupal.org/project/toolshed) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and a provider).
2. [Configuration](configuration/index.md) — the provider listing page,
   permissions, and how the pieces fit together.

## Where it lives in the admin menu

The provider listing is at **Configuration → Web services → Mapkit**
(`/admin/config/services/mapkit`, route `mapkit.map_provider.collection`), gated
by **Administer mapkit providers**.

## How to use it

1. Install and enable a **provider** module, e.g. `mapkit_gmap`, and configure it
   (its API key etc.).
2. Confirm the provider is listed at `/admin/config/services/mapkit`.
3. Put maps to work by either rendering a geo-capable field with the **`mapkit_map`
   formatter** (Manage display) or building a **Views** display with Mapkit's
   location row/style and proximity filter/argument. You can also add location
   inputs (autocomplete or plain textfield) and a "use my location" geolocation
   link to forms.
