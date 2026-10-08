# Page Geofence — manual setup guide

**Page Geofence** (`pagegeofence`) restricts access to chosen pages based on the
**visitor's country**. You define rules that target particular paths (exactly, or a path
and all its sub‑paths), pick the countries the rule applies to, decide whether those
countries are **allowed** or **denied**, and choose what happens to a blocked visitor —
a redirect to another URL, or a 403 "access denied" response. Rules are evaluated in
weight order, and by default nothing is geofenced until you explicitly configure a rule.

The country of each visitor is read from a **configurable request header** rather than a
bundled geolocation database — you tell the module which header carries the country code
(for example `HTTP_CF_IPCOUNTRY` from Cloudflare, or `X-Country-Code` from your own
edge). This keeps it compatible with a wide range of hosting and CDN setups. The module
also keeps **time‑stamped logs** of every change to a restriction — what changed, the
scope, the affected countries, the restriction type and the legal reasoning — and it
asks you to record a justification, which is helpful for compliance record‑keeping.

**Important — this is a soft control, not a hard security boundary.** Geo‑IP restriction
relies on IP‑to‑country data that visitors can bypass with a VPN or proxy, and on the
correct client IP reaching Drupal (configure trusted proxies so a CDN doesn't mask or let
someone spoof the source). Treat Page Geofence as a **policy / UX geoblock** — showing
region‑appropriate content, or meeting a licensing requirement — not as protection for
truly sensitive content. For that, use real access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — set the country header, create geofence
   rules, and choose the blocked‑visitor response.

## Where it lives in the admin menu

Once enabled, Page Geofence adds a **rules collection** where you create and manage your
geofence rules (route `entity.pagegeofence_rule.collection`). Access is governed by the
permission the module provides — grant it only to trusted administrators. See
[Configuration](configuration/index.md) for the details.
