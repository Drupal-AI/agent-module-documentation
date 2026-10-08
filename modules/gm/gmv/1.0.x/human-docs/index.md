# Google Model Viewer — manual setup guide

**Google Model Viewer** (`gmv`) lets you display **interactive 3D models** on your
Drupal site. It adds a field that renders 3D content through Google's
`<model-viewer>` web component, so visitors can rotate, zoom, and (on supported
devices) view a model in augmented reality — ideal for product visualisation or any
3D content you want people to explore in the browser.

You add a **Three Dee Object** field to a content type, then upload a `.zip`
containing a 3D model in the **glTF** format (`.gltf` is fully supported; `.glb`
support is under development). Each field instance exposes viewer options so you can
tune how the model behaves and appears.

The models are ordinary managed files, so Drupal's normal file access rules apply.
The module renders the 3D asset in the visitor's browser and has no access-control
role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site-wide settings page** for this module — it has no central
configuration form. Everything is set up per field, described in "How to use it"
below.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields** and add a
   new field of type **Three Dee Object**.
2. Create or edit a piece of content of that type and **upload a `.zip`** file
   containing your glTF 3D model.
3. Configure the viewer's display options for that field. The available options
   include:
   - **Camera controls** — enable or disable letting visitors orbit the model.
   - **Touch-action** — the CSS `touch-action` behaviour, for better mobile
     handling.
   - **Shadow intensity** — how strong the model's shadow is.
   - **Height** and **width** — the size of the viewer in pixels.
4. Save and view the content — the interactive 3D model renders in place.
