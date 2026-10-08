# Oomph Paragraph Bundles — manual setup guide

**Oomph Paragraph Bundles** (`oomph_paragraphs`) is a starter kit of ready‑made,
component‑style **Paragraph bundles** for building structured pages. Standing up a
component/page‑builder experience with the Paragraphs module normally means
hand‑configuring a lot of bundles, fields, form displays, and view displays;
this module gives you that whole configuration out of the box, so editors have a
library of reusable layout and content components to drop into a Paragraphs
reference field from day one.

On install it imports configuration for a set of bundles: a **Row** container
(arrange components horizontally), a **Column group** container (arrange
components vertically), a **Hero** row (a background‑image banner with one
WYSIWYG), **WYSIWYG** (free‑form rich text), **Image**, **Video**, **Accordion**,
and a **Testimonial**. Crucially, the components **nest inside each other**, and a
Row lays out whatever it contains independently of what those components are — so
you get real layout flexibility rather than a fixed set of presets.

The Row and Hero bundles carry a rich set of design controls exposed as fields:
background colours and images, top/bottom borders (dashed or solid), a
"caret‑down" triangle, vertical and horizontal alignment of the components inside
a row, **18 layout options** for 1–4 columns, borders between components, and
scroll‑triggered animation "entrances" (zoom, fade, or slide in as the row enters
the viewport). Each bundle also gets its own Twig template, discovered
automatically from the module's `templates/` directory, so your theme can style or
override any component.

One deliberate gap to know about: the **Video** bundle ships *without* a video
field, so you can add Core Media (or whatever video solution you prefer) yourself.

This module is **content‑model configuration plus theming** — it has **no routes,
no permissions, and no runtime configuration UI**, and therefore no admin settings
form and no attack surface of its own. Note also that it is *minimally maintained*
with **no further development** planned, so treat it as a stable starting point
you will extend and own in your own site, rather than something that will keep
gaining features upstream.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Paragraphs
   and Field Group dependencies) with Composer and enable it.

There is **no configuration page** for this module — it adds paragraph bundles and
templates, not a settings screen. Setup happens on your content type's fields and
in your theme, described below.

## Where it lives in the admin menu

Oomph Paragraph Bundles adds no admin page of its own. You work with it through the
standard Paragraphs and Field UI screens: **Structure → Paragraph types** shows
the bundles it installed, and you add a Paragraphs reference field to a content
type from that content type's **Manage fields**.

## How to use it

1. Enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. On the content type you want to build pages with, go to **Manage fields** and
   add a **Paragraphs** reference field, allowing the Oomph bundles you want
   editors to use (Row, Hero, Accordion, and so on).
3. If you plan to use the **Video** bundle, add a video field to it first — go to
   **Structure → Paragraph types → Video → Manage fields** and add a Core Media (or
   other) video field, since the bundle ships without one.
4. Style the components: the module provides a Twig template per bundle, so copy
   the ones you want into your theme and override the markup and CSS to match your
   design.
5. Start building — editors add a Row, choose one of the 18 layouts, drop
   components inside it, and set background, borders, alignment, and animation via
   the Row's fields.
