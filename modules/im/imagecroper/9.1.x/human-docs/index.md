# Image Crop Widget — manual setup guide

**Image Crop Widget** (`imagecroper`, labelled "Imager Widget") is a field widget
for core **Image** fields that lets content authors rotate, crop, and resize an
uploaded image right in the edit form — in the browser, before saving the node or
media entity. It saves a trip to a separate desktop image editor for quick fixes
like straightening a photo, trimming a border, or re‑framing an avatar.

After a file is uploaded, the widget shows a **Start Editing** button. Clicking it
loads a bundled in‑browser editor (the ImagerJS library, with Rotate, Crop,
Resize, Undo, and Save controls) over the image preview. When the author saves in
the editor and then submits the form, the edited image is written back to the
site. All the editor assets are served from the module itself — there is no CDN or
external dependency.

A single per‑field option, **Type of update image**, controls how the edit is
persisted: either **replace** the original file in place (so all existing
references and image styles pick up the change) or **create a new** managed file
and point the field at it. There is no global settings page — you configure the
widget entirely on an entity's *Manage form display* tab, and it can be used on any
image field, including those on Media types and custom entities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn the widget on for an image field
   and choose how edits are saved.

## Where it lives in the admin menu

There is no global settings page. You enable and configure the widget per field on
each bundle's **Manage form display** tab — for example **Structure → Content
types → [type] → Manage form display**, or a Media type's form display.
