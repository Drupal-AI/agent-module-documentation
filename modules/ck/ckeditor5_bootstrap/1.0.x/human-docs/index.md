# CKEditor5 Bootstrap Integration — manual setup guide

**CKEditor5 Bootstrap Integration** (`ckeditor5_bootstrap`) brings Bootstrap 5
building blocks into Drupal's CKEditor 5 editor. Instead of hand-typing Bootstrap
markup in Source view or assembling complex Paragraph structures, editors get
toolbar buttons that insert and edit Bootstrap components right inside the WYSIWYG.

The module adds three buttons:

- **Bootstrap Div** — inserts a `<div>` via a popup dialog where you can add any
  Bootstrap 5 utility classes (or pick from options such as *container*, *row*,
  *col-\**, *d-flex*, *p-3*, *bg-light*), set a background image (URL, position,
  size), add AOS "Animate On Scroll" effects (animation, duration, delay,
  anchor placement), and manage custom attributes (`data-`, `aria-`, …). In the
  editor the div is highlighted with a blue border; you can double-click to edit
  it, move it up or down, and insert new blocks before or after.
- **Bootstrap Table** — a balloon toolbar on tables for adding a caption and
  toggling Bootstrap table classes (base `table`; styles like *table-striped*,
  *table-bordered*, *table-hover*, *table-sm*; color classes like *table-primary*,
  *table-dark*; responsive wrappers like *table-responsive*, *table-responsive-md*;
  and *caption-top*).
- **Bootstrap Components** — a library of ready-made components: Accordion, Card,
  Carousel, Collapse, List group, Modal, Offcanvas, Toast, Tooltip, Popover,
  Badge, Alert, and Tabs.

Because the module only writes Bootstrap 5 markup and classes, your **front-end
theme must load Bootstrap 5's CSS and JavaScript** for these components to look
and behave correctly on the published page — it is best paired with a Bootstrap 5
theme (and works well with a Bootstrap 5 admin theme for editing). It targets
Drupal 11 and 12 and depends on core's CKEditor 5 and Editor modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page**. You enable the three buttons per text
format, described below.

## How to use it

This is a CKEditor 5 plugin module: you turn on its buttons per text format.

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **Bootstrap Div**,
   **Bootstrap Table**, and **Bootstrap Components** buttons into your active
   toolbar (add whichever ones you need).
4. Make sure the text format's allowed HTML tags permit the Bootstrap markup
   (divs with classes, table classes, `data-`/`aria-` attributes) so it survives
   saving.
5. Save the text format.

Editors can now insert Bootstrap divs, style tables, and drop in components while
writing. Remember to load Bootstrap 5's assets in your theme so the output renders
correctly on the front end.
