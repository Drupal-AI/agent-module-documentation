# Geolocation - Tian Maps — manual setup guide

**Geolocation - Tian Maps** (`geolocation_tian`) adds the Chinese **Tianditu
(天地图, "Tian") Maps** service as a map provider for the **Geolocation** module.
Once enabled, geolocation fields and Geolocation Views can render their maps using
Tianditu tiles instead of Google, Mapbox, or another provider. It's the practical
choice for China‑focused sites, where the usual Western map services are often
unavailable or unreliable.

It's a thin provider on top of Geolocation. It registers a `tian` map provider,
plus a marker info‑window layer and a zoom/navigation control, and it currently
supports position display, position markers, and zoom control. You enter your
**Tianditu App ID** on a small settings form; at render time the module builds the
Tianditu JavaScript API URL with that key and loads the map library in the
visitor's browser.

A couple of things to know up front. Because Tianditu is a third‑party service,
the map library and tiles are loaded from Tianditu's servers in the visitor's
browser. And the Tianditu **App ID is a client‑side key** — by design it's
embedded in the page's script URL and is therefore visible to anyone viewing the
page. That means it's not a server secret: rather than trying to hide it, you
should **restrict it by referrer/domain in the Tianditu console** so it can only
be used from your site. The API base URL is fixed to HTTPS, and the module has no
anonymous or mutating endpoints.

It depends on the **Geolocation** (`geolocation`) module and supports Drupal 10
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Geolocation dependency.
2. [Configuration](configuration/index.md) — get and store your Tianditu App ID,
   then select Tian Maps as your map provider.

## Where it lives in the admin menu

The App ID settings form is at **Configuration → Web services → Tian Maps
settings** (`/admin/config/services/geolocation/tian_maps`, config route
`geolocation_tian.settings`), behind the Geolocation module's **configure
geolocation** permission. Choosing Tian as the actual map provider happens on each
geolocation field formatter or Geolocation Views display — see
[Configuration](configuration/index.md).
