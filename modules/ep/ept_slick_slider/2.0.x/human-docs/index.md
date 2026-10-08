# EPT Slick Slider — manual setup guide

**EPT Slick Slider** (`ept_slick_slider`) adds a slider/carousel Paragraph type
to your site, built on the long-established
[Slick](https://kenwheeler.github.io/slick/) carousel library. An editor drops
the paragraph onto a page and gets a slider, with the full range of Slick options
available per instance — including separate responsive settings for mobile,
tablet, and desktop. Because the slides are built from Paragraphs and ordinary
Drupal fields, you can adjust image sizes or add a lightbox (such as Colorbox)
through the Field UI without touching code.

EPT Slick Slider is one module in the **Extra Paragraph Types (EPT)** family.
Every EPT module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* (spacing, background, container width). So
there is **no site-wide settings page**: you configure each slider on the
paragraph where you place it.

Two things to weigh before choosing a carousel. First, content past the first
slide is rarely seen, so a slider suits equally-optional items rather than
anything important — and it needs keyboard-operable controls with visible focus,
every slide's content reachable, and a pause control if it auto-advances. Second,
Slick is a **jQuery** plugin, so this component brings jQuery onto any page it
appears on — worth knowing on a site that has otherwise moved off jQuery.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Sliders are configured per
instance, on the paragraph itself, using the Slick options plus the shared EPT
design options described below.

## Where it lives in the admin menu

EPT Slick Slider adds no admin settings page. Once enabled it registers a **Slick
Slider** Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Slick Slider is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Slick Slider** paragraph type.
2. Edit a piece of content, add a **Slick Slider** paragraph, add the slides, and
   set the Slick options (arrows, dots, autoplay, and the per-breakpoint
   responsive settings for mobile/tablet/desktop).
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific slider.
4. Save. The slider renders at the position of the paragraph in the field.
