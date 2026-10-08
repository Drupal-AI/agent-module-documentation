# CiviMRF Leaflet Views — manual setup guide

**CiviMRF Leaflet Views** (`cmrf_leaflet_views`) is the glue between two other
modules: it lets a Drupal **View** that pulls its data from a remote **CiviCRM**
(over a **CiviMRF / CMRF** connection) plot those records on an interactive
**Leaflet map**. Each CiviCRM record that carries latitude and longitude becomes
a marker, so you can build a member map, an event map, or a donor map that reads
live from your CRM without keeping a local copy of the data.

It works by adding a Views **style plugin** — "CiviMRF Leaflet Map" — that you
choose in the Format section of a View, exactly like any other Views style. There
is no settings page, no permission, and no route of its own: everything is
configured through the Views UI. Because the data is fetched per request from
CiviCRM, map responsiveness depends on your CiviMRF connection and CiviCRM API
latency.

It depends on **CMRF Views** (`cmrf_views`, part of CMRF Core) for the CiviCRM
data source and on **Leaflet Views** (`leaflet_views`) for the map rendering.
Both must be installed and working before this bridge is useful.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its CMRF Views and Leaflet Views dependencies.

There is **no configuration page** for this module. You set it up entirely in the
Views UI, as described in "How to use it" below.

## How to use it

1. Make sure you have a working **CiviMRF connection** (configured in CMRF Core)
   and that a plain CMRF-backed View already returns rows from CiviCRM.
2. Create or edit a **View** whose data source is your CMRF / CiviCRM connection.
3. Add **latitude** and **longitude** fields from the CiviCRM API response to the
   View.
4. Add a field of type **Additional Text** (a "Global: Custom text" style field)
   containing `POINT({{ longitude }} {{ latitude }})`. Replace `longitude` and
   `latitude` with your actual field machine names if they differ.
5. In the View's **Format** section, choose **CiviMRF Leaflet Map** as the style,
   and set that Additional Text field as the map's data source.
6. Save and preview. Records with valid coordinates appear as markers; marker
   popups can render your configured Views fields.

> **Tip:** combine the View with exposed filters to let visitors narrow the
> mapped CiviCRM dataset. Always confirm the underlying CMRF View returns rows
> *before* adding the Leaflet style, so you know any empty map is a coordinate
> problem and not a data problem.
