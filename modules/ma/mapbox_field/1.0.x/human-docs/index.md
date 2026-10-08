# Mapbox Field — manual setup guide

**Mapbox Field** (`mapbox_field`) adds a Drupal **field type** for placing a
location marker on a [Mapbox](https://www.mapbox.com/) map. Editors pick a point
using an interactive Mapbox map widget, and the stored coordinates render on the
front end as a Mapbox GL map. It's the field-level companion to the base
[Mapbox](https://www.drupal.org/project/mapbox) module: it reuses that module's
site-wide access token and default style rather than asking you to configure them
again.

It ships a **Mapbox Field** field type, an interactive **map widget** for choosing
the marker location, and three **formatters** for the display side — a full map, a
single-map variant, and a raw formatter that outputs the coordinate data for your
own JavaScript. If the base module has no token configured yet, the widget shows a
"missing access token" message to point you in the right direction.

Because it builds on the base module, there's nothing to configure in Mapbox Field
itself — the token and style come from Mapbox's own settings page. (The module's
info file names a "Configure" link, but it ships no route to back it, so that link
goes nowhere; it's a harmless packaging leftover. The real settings live on the
base module.) The token used is the same publishable, browser-side Mapbox token,
and the module makes no server-side HTTP requests.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the base Mapbox module).

There is **no configuration page** for this module — its settings come from the
base [Mapbox](https://www.drupal.org/project/mapbox) module's page. You add and
configure the field per content type, as described in "How to use it" below.

## Where it lives in the admin menu

Mapbox Field adds no working settings page of its own. The token and style are set
on the **base Mapbox module** at **Configuration → Web services → Mapbox**
(`/admin/config/services/mapbox`). The field itself is added and configured on your
content type under **Structure → Content types → *(your type)* → Manage fields /
Manage form display / Manage display**.

## How to use it

1. Configure the site-wide token and style on the **base Mapbox module** first
   (`/admin/config/services/mapbox`) — Mapbox Field reads them from there.
2. On a content type, go to **Manage fields** and add a **Mapbox Field**.
3. On **Manage form display**, use the **Mapbox** map widget so editors can pick
   the marker point on an interactive map.
4. On **Manage display**, choose one of the three formatters:
   - **Mapbox (full)** — renders the location as a Mapbox GL map.
   - **Mapbox single map** — the single-map display variant.
   - **Mapbox raw** — outputs the raw coordinate data, for custom JavaScript.
5. Editors set a marker; the map renders on the front end (client-side — no
   server-side tile fetching). You can place multiple map fields on the same
   entity, and combine them with Views to list geolocated content.
