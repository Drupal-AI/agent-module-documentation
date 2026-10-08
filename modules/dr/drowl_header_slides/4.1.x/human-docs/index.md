# DROWL Header Slides — manual setup guide

**DROWL Header Slides** (`drowl_header_slides`) provides a flexible header /
hero slideshow for your site, built on a custom **block type** and a **Slide**
media type and rendered as a [Slick](https://www.drupal.org/project/slick)
carousel. Each slide can carry media, links, and per‑slide configuration, so you
can drop a configurable header slider anywhere blocks are placed — typically at
the top of a page as a hero banner.

Because it delivers a complete slideshow feature rather than a small tweak, it
pulls in a fairly broad stack. It depends on **Slick**, core **Views**, core
**Media**, core **Block content**, and its sibling
[DROWL Media](../../drowl_media/4.0.x/human-docs/index.md) module (which supplies
the "Slide" media configuration), and it also builds on **Fences**, **Menu Item
Extras**, and **Views Linkarea**. Slide content is authored like any other block
and media, so it follows normal block and media access; the module adds a
permission of its own for managing the slides but grants no other access.

There is no global settings form. Once the module is enabled, you work with it by
creating header‑slide blocks (each a set of slides) and placing them in a region —
described under "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no configuration page** for this module — you set up each slideshow on
the block itself, as described below.

## Where it lives in the admin menu

DROWL Header Slides adds no settings page. You create slideshow blocks under
**Content → Blocks** (the block library) and place them in a region at
**Structure → Block layout**. The underlying Slick behaviour (skins, arrows, dots,
autoplay) comes from Slick optionsets managed at **Configuration → Media → Slick**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); this makes the
   header‑slide **block type** and the **Slide** media type available.
2. Under **Content → Blocks**, create a new header‑slides block and add your
   slides — each with its media (image/video), any caption or link, and per‑slide
   options.
3. Go to **Structure → Block layout**, place your new block into a region (usually
   the header or a hero region of your theme), and save.
4. If you want to fine‑tune the carousel's look and behaviour, adjust or create a
   **Slick optionset** at **Configuration → Media → Slick** and select it for the
   slideshow.
