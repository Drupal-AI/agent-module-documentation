# Easy Low Quality Placeholder — manual setup guide

**Easy Low Quality Placeholder** (`easy_lqp`) speeds up how your image-heavy
pages *feel* by shipping a tiny, blurred stand-in for each image in the initial
HTML and then swapping in the full-resolution version once the browser knows how
much space it has. The stand-in is a small `base64`‑encoded copy of the image at
the same aspect ratio (a technique often called LQIP, and comparable to BlurHash
or Symfony's LazyImage), so the visitor sees a soft preview immediately instead
of a blank gap while the real image downloads.

The heart of the module is a **settings form**. You give it a minimum width, a
maximum width, a preferred number of pixels between each generated size, and an
optional list of aspect ratios (for example 4:3 and 16:9). When you save, Easy
LQP automatically generates the matching image styles for you — a whole ladder
of responsive sizes such as `responsive_16_9_50w`, `responsive_16_9_150w`,
`responsive_16_9_1450w`, and so on. Because of this, the module does **not** do
anything useful the moment you enable it: you need to visit the settings form and
save a configuration first so the image styles exist.

Once the styles are generated, you use them on your media: create a media view
mode per aspect ratio, apply the **Easy LQP** field formatter (or use the
provided Twig filter to build `src`/`srcset` URLs), and attach the module's
`easy_lqp/resizer` JavaScript library in your template. The resizer measures the
container at render time and loads the best-fit style over the placeholder. It
depends only on core's **Image** module, and it plays nicely with Focal Point,
Image Optimize, ImageAPI Optimize WebP, and Imagecache External. If you are
migrating from the older Easy Responsive Images module, you can copy your width,
step, and aspect-ratio settings straight across.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form that generates
   your responsive image styles, field by field.

## Where it lives in the admin menu

Easy LQP registers its own **settings form** in the admin area (alongside
Drupal's other media/image configuration). Open it, fill in the width, step, and
aspect-ratio values, and save to generate the image styles — see
[Configuration](configuration/index.md) for the field-by-field walkthrough. The
generated styles then appear under **Configuration → Media → Image styles** like
any other image style.
