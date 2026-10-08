# Slick Views — manual setup guide

**Slick Views** (`slick_views`) adds a Slick carousel/slideshow display style to Drupal **Views**, so any View — of nodes, media, images, or other entities — can be rendered as a responsive, touch‑enabled slider instead of a plain list or grid. It is the glue between the **Slick** module (a Drupal wrapper around the Slick carousel JavaScript library) and core Views.

Concretely, it registers two Views **style plugins** — **Slick Carousel** and **Slick Grouping** — that appear in a View display's **Format** picker. Once you choose one, the style takes its look and behavior from a Slick **optionset** defined over in the Slick module (number of slides, autoplay, arrows, dots, responsive breakpoints, lazy load, and so on). Because the presets live in the optionset, the same carousel styling can be reused across many Views. Each View row becomes a slide; you can nominate an image/media field, add captions or overlays, and even drive a synchronized thumbnail navigation carousel with a secondary optionset (`asNavFor`). The **Grouping** variant splits results by a field and renders each group as its own carousel — or a nested "carousel of carousels". When image fields use the **Blazy** formatter, Slick Views automatically wires up lazy loading and lightbox galleries.

Slick Views has **no admin settings page of its own** — everything is configured per‑View in the Views UI, and the options are saved inside each View's exportable config. It does, however, need real dependencies to function: core **Views**, and the **Slick** module (`drupal/slick ^3.0`), which supplies the optionsets and the underlying carousel library. Installing and enabling those is covered in the Installation guide below.

This guide is written for a **human** clicking through the admin UI. If you want terse, token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Slick Views and its Slick dependency with Composer, and enable them.

## How to use it

Slick Views has no configuration page. It surfaces as a **Format** option inside the Views UI, so you configure a carousel per View:

1. **Create or edit a View** at **Structure → Views** and add a display (page, block, etc.).

2. **Choose the format.** In the display, open **Format** and pick **Slick Carousel** (or **Slick Grouping**), then open its **Settings**.

3. **Pick a Slick optionset.** In the style settings, choose a Slick **Optionset**. Optionsets are defined in the Slick module at **Configuration → Media → Slick** (`/admin/config/media/slick`), and they control slides‑to‑show, autoplay, arrows, dots, breakpoints, lazy load, and more.

4. **Tune the slides (optional).** You can nominate an **image/media field**, a **caption**, and an **overlay**, and set a *secondary* optionset to drive a synced thumbnail navigation carousel (`asNavFor`).

5. **Set the row style.** Row style is typically **Fields** or **Content**; each View row becomes one slide.

For the **Slick Grouping** style you additionally split results into groups by a field, optionally cap the number of items per group, and pick a group‑level optionset to build a nested "carousel of carousels". To customize the slide markup, override the Slick (or Blazy) module's templates rather than anything in Slick Views itself. Because all of these options are stored in the View, exporting the View's config carries the entire carousel setup with it.
