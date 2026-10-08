# File Browser — manual setup guide

**File Browser** (`file_browser`) gives you a ready‑made, Media‑library‑style
picker for files and images. It presents editors with a responsive Masonry grid
of the files already on your site to click and select, plus a drag‑and‑drop
"Upload files" tab powered by DropzoneJS. You attach it to any File, Image, or
entity‑reference field as its form widget.

Think of it as a modern recreation of the old Drupal 7 media library experience,
built on today's Drupal stack. Enabling the module installs a complete, working
Entity Browser named "Browser for files" (with an inline iframe version and a
modal version), the View that supplies the thumbnail grid, the image styles the
thumbnails use, and an Entity Embed button so editors can drop images into rich
text.

File Browser is essentially a configuration layer that wires together several
other modules — Entity Browser, Entity Embed, and DropzoneJS — so it has no admin
settings form of its own. All tuning is done on the pieces it installs (the
Entity Browser, its View, and the field widget). It also relies on a few
front‑end JavaScript libraries (Masonry, imagesLoaded, Backbone, Underscore).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, provide the JS libraries, and enable it.

## Where it lives in the admin menu

File Browser has no settings page. Its effect appears where you configure a
field's form widget — **Structure → Content types → (your type) → Manage form
display** — and where editors create content. The pieces it installs are managed
under **Configuration → Content authoring → Entity browsers**, **Structure →
Views**, and **Configuration → Media → Image styles**.

## How to use it

The main task is attaching the shipped browser to a field:

1. Go to **Manage form display** for a bundle that has a File, Image, or
   entity‑reference (targeting files) field — for example
   **Structure → Content types → Article → Manage form display**.
2. Change that field's widget to **Entity Browser** (or **File Browser** if that
   widget is offered).
3. Open the widget's settings (the gear icon) and select **Browser for files**
   from the entity‑browser dropdown. Choose the modal variant instead if you
   prefer a pop‑up over the inline iframe. Save.

The field now shows a **Select files** button that opens the browser: a grid of
existing files to pick from, and an upload tab for adding new ones. Selecting a
thumbnail adds it immediately.

You can customize the experience by editing the pieces File Browser installed:

- **Which files appear, their sorting, filters, and pager** — edit the
  `file_entity_browser` View.
- **Allowed upload extensions or the upload destination** — edit the DropzoneJS
  widget settings on the browser (the default allowed extensions are
  `jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp`, uploaded to `public://`).
- **Thumbnail sizes** — edit the `file_entity_browser_small` and
  `file_entity_browser_thumbnail` image styles.
- **Embedding images in rich text** — use the shipped **file_browser** Embed
  button (via Entity Embed) in your text format's CKEditor toolbar, or place the
  "Image Embed" block.

Enable the **File Browser Example** submodule to see a pre‑wired demo of the
whole setup.
