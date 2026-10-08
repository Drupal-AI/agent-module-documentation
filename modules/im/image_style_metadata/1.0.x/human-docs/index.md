# Image Style Metadata — manual setup guide

**Image Style Metadata** (`image_style_metadata`) stores metadata about the
*derivative* images your image styles generate — recording things like the exact
width and height of each styled image — as content entities in the database. The
point is to make that metadata available **without having to download the image
first**, which is especially useful for front‑end applications talking to a
headless (decoupled) Drupal backend that need to know an image's dimensions or a
placeholder up front.

Out of the box it captures dimensions, but it is built to be extended. Two
submodules build on it:

- **JSON:API Image Style Metadata** (`jsonapi_image_style_metadata`) denormalizes
  the stored metadata and adds it as a computed field on File entities in the
  JSON:API export — handy for decoupled front‑ends.
- **BlurHash Image Style Metadata** (`blurhash_image_style_metadata`) extends the
  stored metadata with a **BlurHash**, the compact string used to render a blurred
  placeholder while the real image loads ("blur‑up" loading).

The module depends on core's **Image** and **Config** modules and provides its own
permissions. It has no access‑control role of its own — the metadata simply
describes images that already follow Drupal's normal file/image access.

> **Important:** Per the project, this module depends on a Drupal core patch to
> work correctly (core issue **2940016**). Apply that patch before relying on it
> in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, apply the
   required core patch, and enable the module and any submodules you need.

There is **no dedicated settings form**; the module works once enabled. Grant its
permissions at **People → Permissions** and let it capture metadata as image
derivatives are generated.

## Where it lives in the admin menu

Image Style Metadata adds no configuration page. It captures metadata in the
background as styled images are created, and exposes it to code and (with the
JSON:API submodule) to your API consumers.

## How to use it

1. Install the module and **apply the required core patch** (see Installation).
2. Enable the base module, plus **JSON:API Image Style Metadata** if you want the
   metadata exposed through JSON:API, and **BlurHash Image Style Metadata** if you
   want blur‑up placeholders.
3. Review the module's permissions at **People → Permissions** and grant them to
   the appropriate roles.
4. Generate some styled images (for example by viewing content that uses your
   image styles). The module records their metadata as it goes.
5. In a decoupled front‑end, read the dimensions (and BlurHash, if enabled) from
   the JSON:API File output to size image placeholders before the full image
   downloads.
