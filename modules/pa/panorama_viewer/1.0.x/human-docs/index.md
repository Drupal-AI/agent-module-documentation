# 360 panorama viewer — manual setup guide

**360 panorama viewer** (`panorama_viewer`) provides an **image-field formatter**
that renders uploaded images as interactive **360° panoramas** — letting visitors
pan and look around inside the photo. It's a natural fit for real-estate listings,
tourism, and product views where a single flat image can't convey the space.

It's a content-display feature only: the image is rendered as a panorama while
respecting normal file access, and the module has no access-control role of its
own. It depends on core **Image**, and (per the project's notes) works alongside
jQuery UI. It supports Drupal 9, 10, and 11.

One thing to keep in mind: the formatter expects a genuine **360×180 degree
panorama** source image. Regular photos displayed through it will look strange,
and the image field should be limited to a single value.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** — you turn the viewer on per image field under
**Manage display**, as described in "How to use it" below.

## Where it lives in the admin menu

360 panorama viewer adds no standalone admin page. You use it entirely from an
image field's **Manage display** (for example **Structure → Content types →
*(type)* → Manage display**, `/admin/structure/types/manage/*/display`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the **image field** you want to show as a panorama is set to allow
   **1** value (**Allowed number of values = Limited, 1**).
3. Open the bundle's **Manage display** and set that image field's format to the
   **360° panorama viewer** formatter. You can also choose an image style here.
4. Add content with a 360° image and save. On the node view, an interactive 360°
   panorama viewer appears for that field.

> **Warning:** Pictures that are not 360×180 degree panoramas may look strange in
> the viewer — use true equirectangular panorama images.
