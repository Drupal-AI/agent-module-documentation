# Mapsemble — manual setup guide

**Mapsemble** (`mapsemble`) turns geolocated Drupal content into interactive,
good‑looking maps — no coding required. It connects your Drupal site to the
[Mapsemble](https://mapsemble.com) map builder, so any entity that carries a
**Geofield** location (nodes or custom entities) can be plotted on a map with
markers, clustering, and popups. The cards and popups are rendered by Drupal
itself, which means you keep full control over how each point looks using your
theme.

Because the data comes straight from your site, changes you make in Drupal show
up on the map, and you can add filters that are handled either by Drupal or by
Mapsemble. Typical uses are store locators, event and venue maps, real‑estate
listings, business directories, and location‑based storytelling.

Mapsemble depends only on the [Geofield](https://www.drupal.org/project/geofield)
module for storing coordinates, and it supports Drupal 10 and 11. The map‑building
and styling experience lives on the Mapsemble side — after enabling the module you
follow the guided setup at **mapsemble.com/drupal** to connect your site and build
your first map.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Geofield dependency.

Mapsemble has no traditional Drupal settings page of its own. The map building,
styling, and filtering happen through the Mapsemble service once your site is
connected, so there is no separate Configuration page to document here.

## Where it lives in the admin menu

Mapsemble does not add a standalone settings form under **Configuration**. Instead
you work in two places: your entities need a **Geofield** location field
(**Structure → Content types → *(your type)* → Manage fields**), and the map is
built and styled by following the connection steps at **mapsemble.com/drupal**.

## How to use it

1. Make sure the content you want to map has a **Geofield** field holding its
   coordinates (add one under **Manage fields** if it does not).
2. Enable Mapsemble (see [Installation](installation/index.md)).
3. Follow the guided setup at **mapsemble.com/drupal** to connect your Drupal site
   to Mapsemble and build a map from your geolocated entities.
4. Style the cards and popups with your Drupal theme, and add filters (handled by
   your site or by Mapsemble) as needed.

> **Tip:** Want a working example to copy? The separate **Mapsemble Store Locator**
> submodule ships a ready‑made store‑locator configuration — enable it, visit
> `/mapsemble-store-locator`, and follow the on‑screen instructions.
