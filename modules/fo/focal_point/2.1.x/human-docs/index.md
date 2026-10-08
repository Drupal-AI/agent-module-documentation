# Focal Point — manual setup guide

**Focal Point** (`focal_point`) lets a content editor click the single most
important spot on an image — a face, a logo, the subject of a hero banner — so
that every automatically‑cropped version of that image keeps that spot in frame.
Instead of cropping blindly from the geometric center (and lopping off heads),
Drupal crops *around* the point the editor chose.

The problem it solves is a familiar one: you upload one photo, and Drupal
generates thumbnails, teasers, avatars, and responsive variants at many
different sizes. Center‑cropping works for some images and ruins others. With
Focal Point, the editor drags a crosshair over the image once, and every derived
size respects that choice. The point is stored as a relative X,Y *percentage*
(for example `50,50` for dead center), so it survives image replacement and does
not depend on the original dimensions.

Focal Point does **not** work entirely on enable — turning it on adds the
building blocks, but you then wire it up in two places: switch the image field to
the **Image (Focal Point)** widget so editors get the crosshair, and add one of
the module's **focal‑point image effects** (Focal Point Crop, Focal Point Crop by
width/height, or Focal Point Scale and Crop) to the image styles you want to be
subject‑aware. It depends on Drupal core's **Image** module and the contrib
**Crop API** (`crop`) module, which stores the focal‑point data. There are no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Crop API
   dependency with Composer, then enable it.

There is no dedicated settings page for this module, so there is no separate
configuration page in this guide — the setup walkthrough is right below.

## How to use it

Focal Point has no global configuration form. Instead you configure it in two
places, both in the standard admin menu.

### 1. Turn on the Focal Point widget for an image field

The crosshair appears on the image *upload widget*, so you enable it per field on
the form display:

1. Go to the **Manage form display** tab for the entity type and bundle that has
   your image field — for example, for the Article content type that is
   **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
2. Find your image field's row and change its **Widget** to **Image (Focal
   Point)**.
3. Save.

Editors uploading an image on that field now see a draggable crosshair overlaid
on the image preview, plus an X,Y value they can fine‑tune (the values are
percentages). Wherever they place the crosshair is the focal point.

### 2. Add a focal‑point effect to an image style

Setting a focal point only changes the crop if the image *style* is told to crop
around it. You do that by adding one of Focal Point's image effects:

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
2. Edit an existing style, or add a new one, and add an effect. Focal Point
   provides three:
   - **Focal Point Scale and Crop** — scales the image and then crops it to a
     fixed width×height around the focal point. This is the most common choice
     for fixed‑size teasers, thumbnails, and avatars.
   - **Focal Point Crop** — crops to an exact width×height around the point
     without scaling first.
   - **Focal Point Crop by width/height** — crops to an aspect ratio / a single
     dimension around the point.
3. Configure the effect's dimensions and save the style.

Any image style that includes one of these effects will now crop around the
saved focal point instead of the center.

### 3. Preview the crops (optional)

When an editor sets a focal point using the widget, a **Preview** link renders
the image through every image style that uses a focal‑point effect, so they can
check all of the crops at once before publishing.

Focal Point also works with images uploaded through the **Media Library**, and
ships migrate source/process plugins if you are importing legacy focal‑point
data. For setting focal points programmatically via the `focal_point.manager`
service, see the [`agent/`](../agent/api/focal_point.md) API notes.
