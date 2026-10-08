# remove.bg — manual setup guide

**remove.bg** (`removebg`) adds an **image effect** that strips the background out
of images by sending them to a cloud background-removal API — either
[remove.bg](https://www.remove.bg/) or rembg.com. You add the effect to a Drupal
**image style**, and from then on any image processed through that style comes out
with a **transparent background**. It's a fast way to produce clean cutout product
shots, portraits without a backdrop, and similar derivatives, all handled
automatically by Drupal's normal image-style pipeline.

Because it's built as an Image Effects plugin, it slots into the same place as
core's resize and crop effects, and the processed derivatives are cached like any
other image style. You can switch between the two providers without changing your
image styles, and the settings form can check your API account status and credits.

To use it you need a **remove.bg (or rembg.com) API key**, since the actual
background removal happens on the provider's servers. That means two things to plan
for: you're storing an API key (a secret), and you're sending your images to a
third party (egress and, potentially, privacy considerations if the images contain
people or sensitive content). Both are covered in
[Configuration](configuration/index.md). It depends on core's **Image** module and
the contributed **Image Effects** module, and runs on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Image Effects) and enable it.
2. [Configuration](configuration/index.md) — enter your API key, pick the
   provider and output format, and add the effect to an image style.

## Where it lives in the admin menu

The module's settings form is at **Configuration → remove.bg**
(`/admin/config/removebg`), gated by the *administer removebg* permission. Image
styles (where you add the effect) live at **Configuration → Media → Image
styles**.

## How to use it

1. Get an API key from remove.bg or rembg.com.
2. Enter the key, provider, and output format on the settings form (see
   [Configuration](configuration/index.md)).
3. Edit an **image style** and add the **remove.bg** effect.
4. Any image rendered through that style is sent to the provider and returned with
   its background removed. Existing images can be reprocessed by flushing the
   image style.
