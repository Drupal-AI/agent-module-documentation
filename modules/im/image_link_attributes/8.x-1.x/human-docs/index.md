# Image Link Attributes — manual setup guide

**Image Link Attributes** (`image_link_attributes`) extends Drupal's image field so
that when an image is linked, its generated anchor can carry extra attributes:
**class**, **target** and **rel**. Core's image formatter can link an image to its
file or its content, but it produces a bare `<a>` — this module lets you add the
hooks other things need.

The everyday use is a **lightbox**: give every linked image a class and let your
JavaScript library bind to it, with no template work — and no risk of a gallery
script missing images because one view mode was templated differently. It also
covers correctness cases: a link that must open in a new tab (`target="_blank"`),
or an outbound image link that needs `rel="noopener"`. That last one isn't
cosmetic — a `target="_blank"` link without `rel="noopener"` hands the opened page a
handle on yours, so this module is the declarative way to set it.

It works with both plain **image fields** and **responsive image fields**. From
version 8.x‑1.8 onward you can also link an image to an **image style variant**
rather than only the original file. The module ships **no PHP classes** — it is
hooks and configuration only — so its surface is small and its upgrade risk low. It
depends on core **Image** and **Link**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set attributes per field display and
   set site‑wide defaults on the settings form.

## Where it lives in the admin menu

There are two places to work with this module:

- **Per field display** — **Structure → *(content type)* → Manage display**, in the
  image field's formatter settings (once the image is set to link to content or
  file).
- **Site‑wide defaults** — the module's settings form
  (`image_link_attributes.config`).

See [Configuration](configuration/index.md) for both.
