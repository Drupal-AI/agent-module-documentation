# Configuration

There are three things to set up: the **site‑wide settings** (most importantly your
IIIF server), and then one or both ways of showing a viewer — the **field formatter**
and the **manifest block**.

## Site‑wide settings

1. Log in as a user with the **administer site configuration** permission.
2. Go to **Configuration → Media → OpenSeadragon settings**, or navigate directly to
   `/admin/config/media/openseadragon`.

### The essentials

- **IIIF server** *(required)* — the base URL of your IIIF Image API server, **without
  a trailing slash** — for example `http://127.0.0.1:8080/cantaloupe/iiif/2`. This is
  the single most important setting: if it's empty, viewers render nothing. The field
  formatter builds each tile source by appending the (URL‑encoded) file URL to this
  base.
- **Manifest view** *(optional)* — the machine name of a View that generates IIIF
  manifests, if you use the block flow with a Views‑produced manifest.

### Viewer options

The rest of the form is a large set of **viewer options** that mirror the
OpenSeadragon JavaScript API. You don't need to touch most of them — the shipped
defaults are sensible — but they let you fine‑tune the experience across the whole
site. Highlights:

- **Fit to aspect ratio** — fit the whole image into the viewport when it loads.
- **Zoom** — default zoom level, minimum/maximum zoom, and pixel‑ratio limits.
- **Pan** — enable/disable horizontal and vertical panning, and constrain panning to
  the image.
- **Gestures per input device** — separate settings for mouse, touch, and pen (scroll
  to zoom, click to zoom, pinch to zoom, flick, pinch‑rotate, and so on).
- **Navigation controls** — toggle the zoom, home, full‑page, and rotation buttons and
  where they anchor.
- **Navigator (mini‑map)** — show a small overview map, and set its position and size.
- **Sequence (paged) mode** — for multi‑page objects: previous/next controls, initial
  page, and wrap‑around. (Sequence mode turns on automatically when a viewer has more
  than one tile source and collection mode is off.)
- **Reference strip** — a filmstrip for browsing a sequence of images.
- **Collection mode** — show several images together as a grid, with row/column and
  layout controls.

Set what you need and **Save configuration**. These options apply to every viewer on
the site; the per‑viewer details (which image, the DOM element) are filled in
automatically for each instance.

## Show a viewer with the field formatter

1. Go to the entity's **Manage display** (for example
   *Structure → Content types → Article → Manage display*).
2. Find an **image** or **file** field and set its **Format** to **OpenSeadragon**.
3. Save. Each referenced file becomes a zoomable tile source. Files the current user
   can't view are skipped, so access control is respected.

## Show a viewer with the manifest block

1. Go to **Structure → Block layout** and place the **OpenSeadragon block** in a
   region.
2. In the block's settings, enter a **IIIF Presentation manifest URL**. This can be a
   relative path or a full URL, and it may include tokens such as
   `node/[node:nid]/manifest` to build a per‑node manifest.
3. Save. The module fetches and parses the manifest and renders its images as tile
   sources in the viewer.

Between the two, use the **formatter** when the zoomable images live in fields on your
content, and the **block** when you have a IIIF manifest describing the object (common
in Islandora/repository setups).
