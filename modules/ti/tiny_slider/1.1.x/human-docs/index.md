# Tiny Slider — manual setup guide

**Tiny Slider** (`tiny_slider`) brings the vanilla‑JavaScript
[Tiny Slider 2](https://github.com/ganlanyuan/tiny-slider) carousel library into
Drupal. Instead of writing your own slideshow markup, you point Drupal at an
image field, an entity‑reference field, or a View and it renders the items as a
configurable carousel — with autoplay, prev/next controls, dot or thumbnail
navigation, mouse‑drag/touch swiping, looping, and responsive slide counts.

It ships two display plugins that share the same big set of slider options: a
**field formatter** called *Tiny Slider Carousel* (for `image` and
`entity_reference` fields, chosen on a content type's *Manage display* screen)
and a **Views style** called *TinySlider* (chosen under a view's *Format*, which
turns each row into a slide). There is no site‑wide settings form — you configure
each slider where you place it, and the settings are saved alongside that display
or view.

One important setup detail: the Tiny Slider JavaScript/CSS library itself is
**not bundled** with the module. You must download it into
`/libraries/tiny-slider` before sliders will actually animate on the front end.
The module provides a Drush command to do this for you (`drush tiny_slider:download`),
and it shows a warning on the status report until the library is present. See
[Installation](installation/index.md) for both the module and the library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and download the Tiny Slider library.

## Where it lives in the admin menu

Tiny Slider has **no central configuration page**. You use it in two places:

- **Manage display** for a content type / entity bundle — for an image or
  entity‑reference field, change its *Format* to **Tiny Slider Carousel** and
  click the gear to set the slider options.
- **Views** — add or edit a view, and under *Format* choose **TinySlider**; the
  gear opens the same slider options.

## How to use it

### As a field formatter

1. Add a multi‑value **image** or **entity reference** field to a content type (or
   use one you already have — a slider only makes sense with more than one value).
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. In the row for your field, open the **Format** dropdown and choose **Tiny
   Slider Carousel**.
4. Click the gear (⚙) at the end of the row to open the settings, then adjust the
   options below and click **Update**, then **Save**.

### As a Views style

1. Create or edit a View that lists the entities you want to show.
2. In the **Format** section of the view, click the current format and choose
   **TinySlider**.
3. Click **Settings** next to the format to open the same slider options.
4. Each result row becomes one slide.

### The slider options

Both the formatter and the Views style expose the same controls. The most
commonly used ones:

- **Items** — how many slides are visible at once (default 1).
- **Gutter** — pixels of space between slides.
- **Mode** — *carousel* (sliding) or *gallery* (fade).
- **Navigation (`nav`)** and **Navigation position** — show dot navigation, and
  place it at the top or bottom. **Nav as thumbnails** uses the slides themselves
  as a thumbnail strip.
- **Controls** — show prev/next arrows, with configurable position and custom
  *prev*/*next* labels.
- **Autoplay** — auto‑advance the slider, with **pause on hover**, an optional
  start/stop button, and custom *start*/*stop* button text.
- **Slide by** — advance one item at a time or a whole page.
- **Arrow keys** — enable keyboard navigation.
- **Mouse drag** — enable click‑drag and touch swiping.
- **Loop** — loop back to the start infinitely (on by default).
- **Center** — keep the active slide centered.
- **Speed** — transition time in milliseconds (default 300).
- **Responsive breakpoints** — set different item counts for mobile vs desktop.
- **Image style / image link** (formatter only) — apply an image style to the
  slide images and link each image to its content or the file.

### Advanced mode

If you need a Tiny Slider option the form does not expose, turn on **Advanced
mode** and paste a raw Tiny Slider options object as JSON into the **Config JSON**
box. When the JSON is valid it overrides the individual settings above, giving you
full access to every Tiny Slider parameter.
