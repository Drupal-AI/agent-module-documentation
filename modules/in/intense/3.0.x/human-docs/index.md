# Intense Images — manual setup guide

**Intense Images** (`intense`) is an image field formatter built on the
**Intense.js** JavaScript library. When a visitor clicks an image rendered with
this formatter, the image expands to fill the whole viewport and pans as the mouse
moves — so a large photograph, artwork or detailed graphic can be explored up
close without on‑screen controls. It's a distinctive, immersive alternative to a
conventional lightbox for detail‑rich imagery.

You apply it the same way as any field formatter: on an image or media field's
*Manage display*, choose the Intense formatter. There is no site‑wide settings
page — the behaviour is enabled per field. Because the module builds on the
**Blazy** API (version 3 or later), Blazy must be present, and the third‑party
**Intense.js** library file must be installed where Drupal can find it.

It's a purely front‑end presentation enhancement with no security surface of its
own. The usual JavaScript‑integration notes apply: serve the library locally if
third‑party origins are a concern, confirm the full‑viewport behaviour suits your
theme, and make sure it doesn't clash with another lightbox or zoom module on the
same images.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Intense.js
   library, and enable it.

There is **no configuration page** for this module — you enable it per field on
*Manage display*. See "How to use it" below.

## Where it lives in the admin menu

Intense Images adds no admin page of its own. You use it from **Structure →
Content types → *(bundle)* → Manage display**, on the image or media field you want
to make interactive.

## How to use it

1. Make sure the **Intense.js** library is installed (see
   [Installation](installation/index.md)) and Blazy is enabled.
2. Go to the **Manage display** tab of the content type (or media type) that has
   the image/media field you want to enhance.
3. Set that field's **format** to the **Intense** formatter and configure any
   options it offers.
4. Save. On the rendered page, clicking the image now opens the full‑viewport
   Intense viewer with pan‑on‑mouse‑move.

> **Tip:** If the click does nothing, the library is usually missing or in the
> wrong place — re‑check that `intense.min.js` is installed at the expected
> `libraries/intense/` path.
