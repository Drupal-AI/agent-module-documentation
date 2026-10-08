# Image Aspect Ratio Tagging — manual setup guide

**Image Aspect Ratio Tagging** (`aspect_ratio`) computes each image's **aspect
ratio** and attaches it to the rendered image — as a class, attribute, or data
value — so your theme and CSS can reserve the right amount of space for a picture
before it loads. The practical payoff is less **layout shift**: pages stop jumping
around as images arrive, because the browser already knows how tall each image
will be relative to its width.

It is a small media / content‑display helper. It changes how images are rendered
(by adding the aspect‑ratio information) but it does not change who can see them —
images continue to follow core's normal media and image access rules, and the
module plays no access‑control role. It ships in the Media package, has no
dependencies beyond core, and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module adds the aspect‑ratio information to images as they render, so your
theme's CSS can use it to reserve space and cut layout shift. To benefit, make
sure your stylesheet actually uses the tagged value — for example, applying the
aspect ratio to the image's container so the slot is sized before the image
downloads. There is no settings page; enable the module and pick up the value in
your theme.
