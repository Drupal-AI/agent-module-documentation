# Image Field 360 — manual setup guide

**Image Field 360** (`image_field_360`) renders an ordinary image field as an
interactive **360° panorama** that visitors can drag to look around. It takes the
flat, distorted **equirectangular** photographs a 360° camera or a phone's
photosphere mode produces — which are meaningless viewed flat — and projects them
onto a sphere so they become immersive. Under the hood it uses the
**Photo-Sphere-Viewer** JavaScript library.

The uses are specific, each a case where a flat photograph genuinely falls short: a
property listing where the visitor wants to stand in the room, a hotel showing a
suite, a museum offering a gallery view, a venue selling a space, or a construction
site recorded at a point in time. Because it is a **field formatter**, the image
stays an ordinary, replaceable image field and the panorama is simply a display
decision — no special content type required.

Three practical points worth knowing before you build with it:

- **The image must actually be equirectangular**, and it is typically large — a
  usable 360 photo is several thousand pixels wide and several megabytes. Image
  styles, lazy loading, and a poster frame matter more here than for ordinary images.
- **It is a canvas-based interaction**, so it needs a keyboard path and a text
  alternative. A panorama that can only be explored by dragging is unavailable to
  keyboard users, and alt text describing the scene is the minimum.
- **Mobile performance is the practical limit.** A large texture on a mid-range phone
  is slow to load and warm to hold, so one panorama per page is a reasonable rule and
  a gallery of them is not.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and add the
   required Photo-Sphere-Viewer JavaScript library.

There is **no separate configuration page** for this module — you set it per field on
*Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

Image Field 360 adds no admin settings page. You use it from **Structure → Content
types → *(your type)* → Manage display**, where it appears as a formatter for image
fields.

## How to use it

1. Add (or reuse) a standard **image field** on your content type.
2. On the entity's **Manage display**, set that field's format to the **360°** /
   **Image Field 360** formatter this module provides.
3. Upload an **equirectangular** image to a piece of content (a normal photo will not
   project correctly).
4. View the content — the image renders as a draggable 360° panorama.
