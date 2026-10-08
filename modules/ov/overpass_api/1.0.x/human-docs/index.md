# Overpass API — manual setup guide

**Overpass API** (`overpass_api`) is a **client for OpenStreetMap's Overpass API**
that other Drupal modules and custom code can use to run Overpass QL queries
against OSM data. Overpass lets you ask OpenStreetMap for exactly the geographic
data you want — administrative boundaries, points of interest, roads, and so on —
and this module wraps that in a simple Drupal service.

It's a developer‑facing building block rather than an end‑user feature: you call
the `overpass_api` service from PHP, hand it an Overpass QL query, and get back an
array of OSM elements. For example:

```php
$result = \Drupal::service('overpass_api')->query(<<<EOT
relation
  ["admin_level"="2"]
  ["type"="boundary"]
  ["boundary"="administrative"]
EOT);
```

The module talks to the public Overpass instance by default, but that endpoint is
slow and unstable — so the module also builds in resilience, retrying queries and
handling timeouts and errors (429 Too Many Requests, 500/504 gateway timeouts,
memory overflows) to keep things stable on the Drupal side. For heavy use you're
encouraged to point it at a more robust instance (including your own).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the required PHP library) and enable the module.
2. [Configuration](configuration/index.md) — set the Overpass endpoint, timeouts,
   and related options.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Overpass API**
(`/admin/config/system/overpass-api`).
