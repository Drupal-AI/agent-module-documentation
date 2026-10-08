# EPT Image Gallery — manual setup guide

**Extra Paragraph Types (EPT): Image Gallery** (`ept_image_gallery`) gives editors a
ready-made **Image Gallery** paragraph type. Drop it into any Paragraphs-enabled field,
pick a handful of images from the Media library, choose a column layout, and you get a
responsive grid whose thumbnails open in a **GLightbox** popup — visitors can swipe
through all the images in the gallery without ever leaving the page. It's built for
photo albums, event galleries, product shots, and portfolio grids, all without a line
of code.

The module is part of the **Extra Paragraph Types (EPT)** family, so it builds on
`ept_core` (which supplies shared settings such as site-wide gallery colors and
responsive breakpoints) and on the **Paragraphs**, **Media**, and **GLightbox** modules.
Installing it creates the `ept_image_gallery` paragraph type, its fields, a pre-built
365×265 thumbnail image style, and a media display that routes gallery images through the
GLightbox formatter — so it works out of the box.

There is **no global settings page** for this module. You configure a gallery per
paragraph instance (which images, which layout), and the handful of display defaults live
on the Image media type's *Manage display*. Anything site-wide (EPT colors and
breakpoints) is edited once at EPT Core's settings page and shared across all EPT
paragraph types.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.

## Where it lives in the admin menu

The module has no page of its own. What it adds or touches:

- **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) — the new
  **EPT Image Gallery** paragraph type.
- **Structure → Media types → Image → Manage display** — where the gallery view mode
  applies the GLightbox formatter (change thumbnail size, caption source, or lightbox
  grouping here).
- **Configuration → Content authoring → EPT Core** (`/admin/config/content/ept-core`) —
  shared EPT colors and responsive breakpoints, edited once for all EPT paragraph types.

## How to use it

### 1. Make sure your content can hold a paragraph

The Image Gallery is a paragraph, so the content type (or other entity) you want to place
it on needs a **Paragraphs reference field** that allows the *EPT Image Gallery* type. Add
one under **Structure → Content types → [your type] → Manage fields** (an *Entity
reference revisions / Paragraphs* field), or reuse an existing paragraph field, and make
sure the EPT Image Gallery type is allowed.

### 2. Add a gallery while editing content

1. Edit a piece of content and add an **EPT Image Gallery** paragraph.
2. In the gallery images field, select or upload one or more **Image** media items — the
   field is unlimited, so add as many as you like.
3. Optionally fill in a **Title** and **Text** shown above the gallery.
4. Pick a **Styles** layout (see below).
5. Save. The thumbnails render in your chosen grid, and clicking one opens the GLightbox
   popup with all the gallery's images grouped together.

### 3. Choosing a layout (the Styles setting)

Each gallery paragraph has a **Styles** radio that controls how the grid is laid out. The
options are:

- **One, Two, Three, Four, or Five columns** — N equal columns. The default is *Four
  columns*.
- **Fixed-size image grid** — uniform, fixed-size thumbnails.
- **Fluid grid** — a grid that adapts to the images' proportions.
- **Featured images grid** — emphasizes the first images in the set.

The chosen style becomes a CSS class on the gallery wrapper; the module's stylesheet does
the rest. To restyle a layout, override the matching class in your theme, or override the
two provided Twig templates.

### 4. Multilingual and theming notes

Gallery paragraph fields are translatable, so galleries work on multilingual sites. If you
want to change the markup, copy `paragraph--ept-image-gallery--default.html.twig` (and the
gallery field template) into your theme. The lightbox behavior itself comes from the
separate GLightbox module.
