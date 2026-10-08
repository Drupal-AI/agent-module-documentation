# Image Processor (WebP) — manual setup guide

**Image Processor (WebP)** (`image_processor_webp`) optimises the images your site
serves without changing how editors work. It does two things: it automatically
creates a **WebP copy** of each uploaded JPG/PNG image, and it scans the generated
HTML and rewrites `<img>` tags into responsive **`<picture>`** elements so browsers
that support WebP get the smaller file while others fall back to the original.

WebP compresses substantially better than JPEG or PNG at comparable quality, so the
payoff is lighter pages and faster loads — and because the conversion and the markup
rewriting happen behind the scenes, editors keep adding images exactly as before.
The module supports Drupal 9, 10 and 11.

The module provides a backend configuration interface where you choose the image
processing toolkit, toggle automatic conversion, and set the default formats and
file extensions. Note that this project is **not covered by Drupal's security
advisory policy**, so evaluate it accordingly before production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the toolkit, enable automatic
   conversion, and set formats/extensions.

## Where it lives in the admin menu

The module exposes a backend settings interface for the toolkit choice, the
auto‑conversion toggle, and the default formats/extensions. See
[Configuration](configuration/index.md) for what to set there.
