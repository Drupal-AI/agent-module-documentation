# Model Viewer Formatter — manual setup guide

**Model Viewer Formatter** (`model_viewer_formatter`) adds a field formatter that
displays uploaded 3D model files as interactive, rotatable viewers right in the
browser. It integrates Google's `<model-viewer>` web component into Drupal, so a
file field holding a 3D model renders as a rich viewer that supports rotation,
zooming, panning, auto-rotation, and even augmented reality (AR) on compatible
mobile devices.

You apply it like any other field formatter: add a file field to a content type
(or any fieldable entity), then on **Manage display** choose **Model Viewer
(Google)** as the field's format. It supports the **OBJ, GLTF, and GLB** 3D
formats and works on Drupal 10 and 11. There are no module dependencies — just a
file field and some 3D model files to show. Typical uses include product
visualization for e-commerce, architectural and engineering presentations,
museum and gallery artifacts, and educational 3D diagrams.

All of the viewer's options are set per formatter instance on the field display
(width and height, auto-rotate, camera controls, background color, and an
optional poster image). Models render client-side and follow the normal file and
field access already in place, so the module itself plays no access-control role.
Because there is no site-wide settings page, this guide folds the setup steps
into this page rather than a separate configuration chapter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **A note on release status:** this project is **not covered by Drupal's
> security advisory policy**. Keep that in mind before relying on it for a
> public production site.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You configure the viewer on
your file field's display, as described in "How to use it" below.

## Where it lives in the admin menu

Model Viewer Formatter adds no admin settings page of its own. You use it from
**Structure → Content types → *(your type)* → Manage display**
(`/admin/structure/types`), where you set a file field's format to **Model Viewer
(Google)**.

## How to use it

1. Add (or reuse) a **file field** on the content type or entity that will hold
   your 3D models. Make sure the field's allowed file extensions include the 3D
   formats you plan to upload (`obj`, `gltf`, `glb`).
2. Go to that bundle's **Manage display** tab.
3. For the file field, choose **Model Viewer (Google)** as the **Format**.
4. Click the gear/cog to open the formatter settings and configure:
   - **Width & Height** — the viewer dimensions (supports `px`, `%`, and `vh`
     units).
   - **Auto-rotate** — whether the model spins automatically.
   - **Camera controls** — enable to let visitors zoom, pan, and rotate.
   - **Background color** — a hex color behind the model.
   - **Poster image** — an optional still image shown while the model loads.
5. Save the display. Now create or edit content, upload a 3D model file to the
   field, and view the node — the model renders in the interactive viewer, with a
   loading spinner while it downloads and an AR option on supported devices.
