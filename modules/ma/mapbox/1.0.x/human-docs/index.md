# Mapbox — manual setup guide

**Mapbox** (`mapbox`) is the base integration module for using
[Mapbox](https://www.mapbox.com/) on a Drupal site. On its own it doesn't put a
map on a page — instead it stores your Mapbox **access token** and a chosen
default **map style** in configuration, and exposes them (plus a small helper
service and the Mapbox GL JS libraries) so that companion modules such as
[Mapbox Field](https://www.drupal.org/project/mapbox_field) can render Mapbox GL
maps. Its own settings page also shows a **live preview** of the style you pick.

Think of it as the shared foundation: you set the token and style once here, and
everything built on top reads them from the module's `mapbox` service. That
service offers the access token, the selected style (defaulting to Mapbox
Streets), and the built-in list of styles — Streets, Outdoors, Light, Dark,
Satellite, Satellite Streets, and Navigation Day/Night.

A useful thing to understand about the token: the Mapbox access token is a
**publishable, client-side token by design**. Mapbox GL JS runs in the visitor's
browser and needs the token exposed in the page, so it appearing in the page's
JavaScript is expected, not a leak. This module makes no server-side HTTP
requests. Still, scope and restrict the token in your Mapbox account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your access token, choose a
   default style, and preview it.

## Where it lives in the admin menu

Settings live at **Configuration → Web services → Mapbox**
(`/admin/config/services/mapbox`). Access is gated by the **Access administration
pages** permission.

## How to use it

On its own, Mapbox just holds configuration. To actually show maps, enable a
module that builds on it (such as Mapbox Field) — those modules read the token and
style from the shared `mapbox` service, so you only configure them in one place,
here.
