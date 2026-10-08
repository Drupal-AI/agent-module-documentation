# Supported Image BaguetteBox Formatter — manual setup guide

**Supported Image BaguetteBox Formatter** (`supported_image_baguettebox`) is a
display formatter that makes images in a **Supported Image** field open in a
[baguetteBox.js](https://www.drupal.org/project/baguettebox) lightbox when a
visitor clicks them — turning a field of images into a clean, swipeable
lightbox gallery.

It bridges two existing modules. On its own, the Supported Image field just renders
images inline; this formatter hands that output to baguetteBox.js so clicks open the
familiar full-screen lightbox. Its one addition over a plain baguetteBox setup is
that it can use the Supported Image field's **Caption** and **Attribution**
sub-fields as the lightbox caption source — so the credit and caption you already
entered on the image show up in the lightbox.

This is a pure display formatter — there is nothing to configure globally and no
settings page of its own. You choose it, and tune its options, on a field's display
settings. It depends on the **Supported Image** module and the **baguetteBox.js**
module, and it targets Drupal 10 and 11.

This guide is written for a **human** setting the formatter up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to the **Manage display** page of the entity (content type, etc.) whose
   Supported Image field you want to display.
2. Change that field's format to **BaguetteBox**.
3. Click the gear icon next to the formatter to configure its options — including
   everything baguetteBox.js offers and the choice to use the field's Caption and
   Attribution as the lightbox caption.
4. Save the display settings.
