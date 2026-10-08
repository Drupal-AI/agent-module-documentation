# Logo Image Enhanced — manual setup guide

**Logo Image Enhanced** (`logo_image_enhanced`) upgrades the way Drupal handles
your site logo. Out of the box, core treats the logo as a raw, unprocessed image:
you can't run it through an image style, the alt text is inconsistent, and you
have no control over how the browser loads it. This module fixes all of that from
the admin UI — no theme edits or custom code required.

With it you can upload logos in modern formats (**WebP, AVIF, SVG, APNG** in
addition to core's formats), apply any existing **Image Style** to resize and
optimize the logo, set proper **alt** and **title** text for accessibility and
SEO, and tune loading performance with the `loading`, `fetchpriority`, and
`decoding` attributes. For SVG logos it automatically skips image styling (vector
images can't be raster‑processed) while still applying the alt/title and
performance attributes.

It is designed to be **theme‑agnostic**: it applies the logo through a server‑side
pre‑render on the branding block, preprocess hooks, and a JavaScript fallback for
non‑standard themes, so it works reliably whatever theme you run. It also flushes
the relevant caches and image‑style derivatives automatically when you change the
logo or its style, and includes an optional **admin‑only debug panel** for
troubleshooting rendering issues. It adds no permissions, blocks, or content
types, and depends only on core's **Image** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — every field in the Logo Image
   Enhanced fieldset, and how to set it.

## Where it lives in the admin menu

Logo Image Enhanced does not add its own admin page. Instead, it extends the
existing theme settings form. You configure it at **Appearance → Settings**
(`/admin/appearance/settings`) — or the settings page for a specific theme — where
a new **Logo Image Enhanced** fieldset appears inside the "Logo image settings"
area.
