# Extra Paragraph Types (EPT): Carousel — manual setup guide

**EPT Carousel** (`ept_carousel`) adds a ready‑made **Carousel** paragraph type
built on **Tiny Slider**, with slides selected from the media library and an
optional link per slide. An editor can add a rotating set of images — a gallery, a
logo strip, an editorial rotation — as its own page section.

It is part of the **Extra Paragraph Types (EPT)** family, sharing the
[`ept_core`](https://www.drupal.org/project/ept_core) base and its design options
(spacing, background, container width). The distinguishing detail is the slider
library: **Tiny Slider** is a small vanilla‑JavaScript slider with **no jQuery
dependency**, which matters because the usual alternatives (Slick, Owl) are
jQuery‑era and increasingly awkward on a Drupal that has removed jQuery from core's
front end.

A word of honest advice before you build one: engagement with slides after the first
is consistently very low, auto‑advance is an accessibility problem (content moves
while it is being read), and on mobile a carousel pushes real content below the
fold. Where it is chosen for a genuine reason — a visitor‑driven gallery, a logo
strip, a curated editorial rotation — it is fine. Where it exists just because
several teams each wanted the top of the homepage, treat everything after slide one
as close to unseen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in the EPT base, Paragraphs, and Media, and enable it (note the image
   media‑type prerequisite).

There is **no site‑wide configuration page** for this module. Like the rest of the
EPT family, it is configured **per paragraph instance** as an editor builds a page —
see "How to use it" below.

## Where it lives in the admin menu

EPT Carousel adds no standalone admin settings page. The Carousel paragraph type
becomes available wherever a **Paragraphs** field allows it, and its shared design
options come from `ept_core`. Slides are chosen through the core **media library**.
To let a content type use it, add or edit a Paragraphs field at **Structure →
Content types → *(type)* → Manage fields** and allow the Carousel type.

## How to use it

1. Make sure an **image media type** exists (see the installation note) and that a
   content type has a **Paragraphs** field permitting the **Carousel** type.
2. Edit content, add a **Carousel** paragraph, and pick the slide images from the
   **media library**, giving each an optional link.
3. Adjust the Tiny Slider behaviour offered by the paragraph and the shared
   `ept_core` design options (spacing, background, width) to fit the section, and
   save.

Because the whole family shares `ept_core`, adopting one EPT module makes adopting
the others cheap — sites often end up using several together.
