# Blurhash — manual setup guide

**Blurhash** (`blurhash`) makes image‑heavy pages feel faster by showing a
colorful blurred preview of each image while the full image is still loading.
It computes a compact **BlurHash** string for an image — a tiny piece of text
that encodes a soft, recognizable approximation of the picture — and uses that
to paint a placeholder in the image's spot until the real file arrives.

The payoff is better *perceived* performance and a more stable layout: instead of
blank gaps or content jumping around as images pop in, visitors see a gentle
blurred version that resolves into the real photo. This is especially noticeable
in galleries and long articles full of images.

Under the hood the module is developer‑oriented: it provides a reusable
**Blurhash service** that encodes images into BlurHash strings, which you (or a
theme/module) wire into your image display so the blurred preview renders first
and is swapped for the real image on load. It adds no routes and no permissions,
and it requires no changes to your content model. This release targets Drupal 9
and 10.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — including the service class
names — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no admin settings screen. After enabling the module, the blurred‑preview
behavior comes from integrating the Blurhash service into how images are
rendered:

- The module exposes a **Blurhash service** that turns an image file into a
  compact BlurHash placeholder string.
- A theme or custom module uses that string to render the blurred preview first,
  then replaces it with the real image once it finishes loading.

Because it is a rendering enhancement rather than a configurable feature, most of
the work is done by a developer or themer wiring the service into your image
markup. See the [`agent/`](../agent/start.md) docs for the exact service and
interface names.
