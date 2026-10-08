# Automated Crop — manual setup guide

**Automated Crop** (`automated_crop`) automatically crops images to a chosen
aspect ratio — no human placing the crop by hand. It provides an **image effect**
you add to an image style, plus a small **API** for developers. When the style is
applied, the module computes a crop box from a Crop Type's aspect ratio and limits
and applies it, so thumbnails and derivatives stay consistent across your site
without editorial effort.

It integrates tightly with the [Crop](https://www.drupal.org/project/crop) module.
If a stored crop already exists for an image (for example a Focal Point crop), the
effect uses that; otherwise it asks Automated Crop to compute one and saves it. The
default cropping strategy centres a crop box sized from the requested aspect ratio
(or the image's own ratio when none is given), never exceeding the original
dimensions. Developers can add their own cropping strategies by writing an
`AutomatedCrop` plugin — for example a rule-of-thirds crop.

There is **no settings page, no configure route, no permissions, and no Drush
commands** of its own. All configuration happens on the image style's effect and on
your Crop Type entities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Crop module
   with Composer and enable it.
2. [Configuration](configuration/index.md) — add the **Automated Crop** effect to
   an image style and choose its crop type and provider.

## Where it lives in the admin menu

Automated Crop has no page of its own. You configure it as an effect on an image
style, at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). See [Configuration](configuration/index.md).
