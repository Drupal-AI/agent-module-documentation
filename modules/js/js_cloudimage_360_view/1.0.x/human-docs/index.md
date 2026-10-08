# JS Cloudimage 360 view — manual setup guide

**JS Cloudimage 360 view** (`js_cloudimage_360_view`) turns a set of photographs
into an interactive 360° spin view — the kind of "grab and rotate the product"
experience you see on e‑commerce sites. You upload a series of images taken around
an object, and the formatter stitches them into a drag‑to‑rotate view on the
front end.

It works as an **image field formatter**. Instead of creating a special field
type, you use an ordinary multi‑value image field and simply choose the
**Cloudimage 360 view** formatter for it on Manage display. Under the hood it uses
Scaleflex's open‑source js‑cloudimage‑360‑view library (MIT licensed).

For smooth rotation you'll want plenty of frames — set the image field's
cardinality to **unlimited** (or at least more than 10), otherwise the spin looks
choppy. An optional submodule adds lazy‑loading of the images.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the 360°
   view library, and enable the module (plus the optional lazy‑load submodule).

There is **no site‑wide configuration page** for this module. All of its options
live on the image field's **Manage display** formatter, described in "How to use
it" below.

## How to use it

1. Create an **image field** on the content type (or other entity bundle) of your
   choice, or reuse an existing one.
2. Set the field's **cardinality to unlimited** (or at least more than 10) so
   there are enough frames for a smooth spin.
3. Go to the bundle's **Manage display** and set that image field's format to
   **Cloudimage 360 view**. Adjust the formatter's display settings as desired.
4. When creating content, upload the sequence of images (the frames taken around
   the object) into the field.

On the rendered entity, the images become a single interactive 360° view the
visitor can drag to rotate.
