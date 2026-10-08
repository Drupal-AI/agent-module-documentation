# BS Slider — manual setup guide

**BS Slider** (`bs_slider`) is a base framework for building sliders, carousels
and image galleries in Drupal. On its own it does not lock you into one
JavaScript slider library or one content source — instead it provides the common
plumbing and lets you plug in the pieces you want through a set of submodules.

You choose a *library* submodule to decide how the slider looks and behaves
(Bootstrap, Swiper, or Tiny Slider), and a *source* submodule to decide where the
slides come from (Paragraphs, entity-reference-revisions, or a View). The slider
only shows content the visitor is already allowed to see — it plays no part in
access control itself. It ships in the **Media** package and defines its own
permissions.

This is an early release (**1.0.0-alpha8**), so treat it as a foundation to build
on rather than a finished, click-and-go slideshow widget.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   base module, and pick the library and source submodules you need.

## Where it lives in the admin menu

BS Slider is a framework rather than a single settings screen. Once you have
enabled the base module and the submodules you want, you build a slider from the
source you chose (for example a Paragraph type, an entity reference, or a View)
and render it with the selected library. There is no single site-wide settings
page — configuration happens where each source and library integration lives.

## How to use it

1. Install and enable `bs_slider` (see [Installation](installation/index.md)).
2. Enable one **library** submodule — `bs_slider_bootstrap`,
   `bs_slider_swiper`, or `bs_slider_tiny_slider` — to control how the slider is
   rendered.
3. Enable one **source** submodule — `bs_slider_paragraphs`,
   `bs_slider_entity_reference_revision`, or `bs_slider_views` — to control where
   the slides come from.
4. Build your slider from that source and let BS Slider render it with the chosen
   library. The slides respect the access rules of whatever content feeds them.
