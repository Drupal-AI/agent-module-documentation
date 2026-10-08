# External Image Styles — manual setup guide

**External Image Styles** (`external_image_styles`) lets your site **delegate image
style derivative creation to an external service** instead of resizing images on
the Drupal server. Image styles are still managed inside Drupal as usual — you keep
the familiar image-style UI — but for a style that uses an external provider,
Drupal hands off building the derivative URL to that provider (for example a
microservice running Glide, or a CDN-style image service), so the resized images
are served without further work from Drupal.

It's important to understand what this module *is*: it is a **framework**. It ships
the plugin API — an `ImageStyleProvider` plugin type, a provider plugin manager,
and a base plugin — plus an override of the core `image_style` config entity. It
does **not** ship a concrete remote provider. On its own, with no provider module
installed, image styles behave exactly like Drupal Core. To actually offload
derivatives you (or a contrib module) supply a provider plugin that knows how to
build the external URLs; you then select that provider per image style.

Because the module overrides the core `image_style` entity class, it is
**incompatible with any other module that also overrides that class** — enabling it
alongside such a module throws an error at cache rebuild. The base module itself
performs no server-side fetch of a user-supplied URL, so any SSRF considerations
live in a concrete provider plugin, not here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. The one choice it adds —
the provider for a given image style — appears directly on Drupal's own image-style
add/edit form, described in "How to use it" below.

## Where it lives in the admin menu

External Image Styles adds no configuration page of its own. Its single setting
appears on the core **image style** add/edit form at **Configuration → Media →
Image styles** (`/admin/config/media/image-styles`).

## How to use it

1. Enable this module **and** a provider module that implements a concrete image
   service (a custom or contrib plugin). Without a provider, styles keep behaving
   like Drupal Core.
2. Go to **Configuration → Media → Image styles** and add or edit an image style
   (`/admin/config/media/image-styles/add`).
3. A new **Image Style Provider** select appears, defaulting to **Drupal Core**.
   Choose your external provider to offload that style's derivatives; leave it on
   **Drupal Core** to keep the default on-server behavior for that style.
4. Save. Your choice is stored per image style (as the
   `external_image_styles.provider` third-party setting), so you can mix external
   and core styles freely across the site.

> **Heads-up:** do not enable this alongside another module that overrides the core
> `image_style` entity class — the combination fails at cache rebuild.
