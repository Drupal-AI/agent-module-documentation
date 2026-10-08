# Leaflet More Markers — manual setup guide

**Leaflet More Markers** (`leaflet_more_markers`) lets each location on a
**Leaflet** map carry its own marker — an emoji or a font icon (Bootstrap Icons,
Font Awesome, or Line Awesome) — instead of the single uniform blue pin Leaflet
shows by default. On top of the icon itself you can control its size, wrap it in a
coloured circle, nudge its vertical position, and add playful animations. It's a
great fit for a points‑of‑interest map where restaurants, hotels, and shops each
get a distinct, recognizable marker.

It works by adding a **Map marker** field type that stores two values per entity:
an `icon` (an emoji, a single character, or a font‑icon code) and a `classes`
list (attributes such as `large`, `circle-red`, `bi bi-shop`, `pulse`). You add
this field alongside a Geofield on your entity, then in the Geofield's Leaflet
formatter you point the marker at those values using tokens. Behind the scenes the
module runs token replacement, works out which icon font each marker needs and
lazy‑loads only that CSS from a CDN, and computes the anchor offsets so icons and
their popups line up correctly at every zoom level. The field widget even includes
an emoji picker for editors.

This is a **field/display module** — there is no admin settings page, no
permissions, and no configuration of its own. Everything is set up per entity
display. It requires the **Leaflet** and **Token** modules.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Leaflet and Token are required).

## How to use it

Setup happens on an entity that already has a **Geofield** rendered by Leaflet.

**1. Add the marker field.** On the bundle, add a field of type **Map marker**
(conventionally `field_map_marker`, cardinality 1). On **Manage form display** its
widget shows a **Pick emoji** button plus two text inputs — one for the icon, one
for the class list. On **Manage display**, drag the Map marker field into
**Disabled** (its value feeds the map, it is not shown as text).

**2. Point the Leaflet formatter at the marker.** Edit the **Geofield**'s display,
set its formatter to **Leaflet Map**, and in the *Map icon* panel choose **Field
(Html DivIcon)**. In the *Html* box enter a template that references the marker
via tokens, keeping the `lmm-icon` class:

```html
<div class="lmm-icon [node:field_map_marker:classes]">[node:field_map_marker:icon]</div>
```

Swap `node` for `user`, `taxonomy_term`, `paragraph`, etc. for other entity
types. For Views‑based Leaflet maps, put the same HTML in the Leaflet Map style
settings.

**3. Fill in marker values.** The `classes` field understands a small vocabulary
of space‑separated tokens:

- **Font‑icon code:** `bi bi-shop` (Bootstrap Icons), `fas fa-bed` (Font Awesome),
  `la la-swimmer` (Line Awesome). The matching CDN CSS is auto‑loaded by prefix.
- **Size:** `large`, `medium` (default), `small`.
- **Circle background:** `circle-black`, `circle-white`, `circle-red`.
- **Baseline:** `center`/`centre`, or `yoffset±N` for a manual pixel offset.
- **Animation:** `pulse`, `jump`, `jump-5`, `flip-1`, `rock`, `bumpy-road`,
  `somersault`, `sky-drop`.

Leave `icon` empty to use a font icon; leave both empty to fall back to the
default blue pin.
