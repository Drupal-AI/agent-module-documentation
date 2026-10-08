# Address Map Link — manual setup guide

**Address Map Link** (`address_map_link`) turns a displayed
[Address](https://www.drupal.org/project/address) field into a link that opens an
external mapping service. When a visitor views a page with an address on it, they
can click through to Google Maps, Apple Maps, Waze, OpenStreetMap, Bing Maps, and
several other providers — including "get directions" links that open pre‑filled
with the address.

The module adds no field of its own. Instead it plugs extra options into the
**display settings** of any existing Address field. On the field's *Manage display*
formatter settings you'll find a "Link Address to Map" checkbox, a provider
selector, a choice of where to put the link, custom link text, and an "open in new
window" toggle. Your stored address data is never touched — only how it renders.

Ten map providers ship out of the box, and the whole thing is per‑display, so you
can (for example) use directions links on the full node view and a plain map link
on the teaser. Developers can add their own provider by writing a small **MapLink**
plugin, and can build a map URL from an address anywhere in code via the module's
`plugin.manager.map_link` service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Address Map Link has **no settings page of its own**. You configure it per Address
field, per view mode, on the bundle's **Manage display** page — for example
**Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

1. Go to the **Manage display** page of the content type (or other entity) that has
   an Address field.
2. Click the **gear icon** on the Address field's row to open its formatter
   settings.
3. Tick **Link Address to Map**, then set:
   - **Map Link Type** — which provider to use. The ten shipped options are Google
     Maps, Google Maps Directions, Apple Maps, Bing Maps, HERE WeGo, MapQuest,
     OpenStreetMap, Yandex Maps, Waze Directions, and Waze Navigate.
   - **Position** — link the address text itself, or place a separate link
     **before** or **after** the address.
   - **Link text** — the text for the before/after link, for example "Get
     directions" or "View on map". If the **Token** module is enabled, you can use
     tokens here (such as the entity title).
   - **Open in new window** — add `target="_blank"` so the map opens in a new tab.
4. Click **Update**, then **Save**.

The address on that display now renders as a map link. Repeat per view mode to vary
the behaviour between, say, teaser and full displays.
