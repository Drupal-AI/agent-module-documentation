# Imagefield Slideshow — manual setup guide

**Imagefield Slideshow** (`imagefield_slideshow`) adds a field formatter for
multi-value **image** fields that renders the uploaded images as a rotating
slideshow instead of a stack of pictures. It is a lightweight way to turn a
gallery field — a product's photos, a homepage banner, an article's image set —
into an automatic carousel without building a View or adding your own JavaScript
library. Under the hood it uses the bundled jQuery Cycle2 library to drive the
transitions.

There is no admin settings page. You enable the slideshow by choosing the
**Imagefield Slideshow** formatter on an image field's *Manage display* screen,
per view mode, and set its options right there — the image style for each slide,
the transition effect, prev/next buttons, pagers, speed and timing, and whether
clicking a slide links to the content or the file. All of these are stored in the
entity's view-display configuration, so they are exportable and can differ between
view modes (for example a fade on teaser and a horizontal scroll on full view).

Because the slideshow controls (prev/next and pagers) only make sense with more
than one image, the field should allow **multiple values**; with a single image
the formatter just renders one static picture. The module requires core's
**Image** module, works on Drupal 8.9 through 10 and on 11, and defines no
permissions, Drush commands, or configuration of its own beyond the per-field
formatter settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

(There is no separate configuration page — the module has no settings form. You
configure it per field on *Manage display*, described below.)

## Where it lives in the admin menu

There is no admin page. You enable and configure the slideshow on an image field
at **Structure → Content types → [your type] → Manage display**
(`/admin/structure/types/manage/<type>/display`), or the equivalent *Manage
display* screen for any entity type with a multi-value image field.

## How to use it

1. Make sure your image field allows **more than one value** (an unlimited-value
   image field is ideal for a gallery).
2. Go to the field's *Manage display* screen for the view mode you want, and in
   the **Format** column choose **Imagefield Slideshow**.
3. Click the settings cog to configure the slideshow:
   - **Image style** — the image style applied to each slide (for example
     *Large*), or *None* to use the original image.
   - **Effect** — the transition between slides: *none*, *fade*, *fadeout*,
     *scrollHorz*, *flipHorz*, *flipVert*, or *shuffle*.
   - **Pause on hover** — pause the slideshow while the visitor's cursor is over
     it.
   - **Prev/Next buttons** — show previous and next navigation buttons.
   - **Transition speed** — how fast each transition runs.
   - **Timeout** — how long each slide is shown before advancing.
   - **Pager** — show a default dot pager beneath the slideshow.
   - **Image pager** — show a thumbnail pager.
   - **Link image to** — make each slide link to nothing, to the content (node),
     or to the original image file.
4. Click **Update**, then **Save**.

The images now display as a slideshow on that view mode, with the alt/title text
from each image carried through to the slides.
