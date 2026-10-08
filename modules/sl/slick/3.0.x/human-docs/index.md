# Slick — manual setup guide

**Slick** (`slick`) turns ordinary Drupal fields, media, and Views into
responsive, touch‑enabled carousels, sliders, and galleries. Instead of stacking
images down a page, you render them as a swipeable slideshow with arrows, pager
dots, autoplay, and responsive breakpoints — driven by the popular Slick (or
Accessible Slick) JavaScript library and lazy‑loaded through Blazy for good page
performance.

The heart of the module is the **optionset**: a named, reusable bundle of Slick
options — how many slides to show, autoplay, arrows, dots, breakpoints, skin —
that you configure once and apply across many displays. You render carousels by
choosing one of Slick's **field formatters** (`slick_image` for image fields,
`slick_media` for Media reference fields, `slick_file` for file/entity‑reference
fields, `slick_text` for text/entity fields) on a field's *Manage display* screen,
or by using the `slick_filter` text‑format filter to drop an inline carousel into
body text. Presentation is customized through **skins**, prebuilt CSS variants for
arrows, dots, and slide styling.

Slick does **not** work on enable alone — it needs two things first: the
**Blazy** module (installed automatically as a Composer dependency) and the actual
Slick JavaScript library placed under your site's `/libraries` directory. It also
ships one submodule, **Slick UI** (`slick_ui`), which provides the admin screens
for creating and editing optionsets — enable it if you want to manage carousels
through the UI. Optional companion projects extend it further: **Slick Views** for
turning Views results into carousels, **Slick Paragraphs**, and **Slick Extras**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Blazy with
   Composer, place the Slick JS library, and enable Slick UI.
2. [Configuration](configuration/index.md) — creating optionsets, applying the
   field formatters, and the sitewide settings, step by step.

## Where it lives in the admin menu

Slick has no settings form of its own until you enable the **Slick UI**
submodule. Once it is on, you manage optionsets at **Configuration → Media →
Slick** (`/admin/config/media/slick`), and the sitewide settings live at
`/admin/config/media/slick/ui`. The carousels themselves are applied per field on
each entity's **Manage display** tab, by choosing a Slick formatter.
