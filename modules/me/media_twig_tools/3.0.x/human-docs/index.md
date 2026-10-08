# Media Twig Tools — manual setup guide

**Media Twig Tools** (`media_twig_tools`) is a set of Twig helper functions for
rendering media images cleanly and adaptively straight from your theme templates.
Drupal's normal media rendering pipeline is powerful, but for something as simple
as an image it often wraps the output in extra markup, and building responsive
`srcset`/`<picture>` output the "core way" means defining an image style and a
responsive image style for every breakpoint you care about. This module gives
front-end developers a lighter path: call a Twig function, describe the sizes and
rules you want inline, and get a clean `<img>` or `<picture>` tag back — with
image derivatives generated at runtime, no per-breakpoint configuration entities
required.

It provides two main Twig functions. `imgFromMedia()` renders a single `<img>`
tag from a media field, letting you set a base image style, custom classes and
attributes, and a `srcset` map (each entry can reuse an image style or apply a
list of resize/crop rules on the fly). `pictureFromMedia()` renders a full
`<picture>` element with multiple `<source>` entries keyed by media query, so you
can serve genuinely different crops at different viewport sizes. Both strip the
default media wrapper markup so the resulting HTML is exactly the image tag you
asked for.

Media Twig Tools depends only on core **Media**, works on Drupal 9, 10 and 11,
and starts working the moment you enable it — there is nothing to configure in the
admin UI. It ships Drush commands and its own permissions, but the day-to-day use
is entirely in your Twig templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Media.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from your theme's Twig templates, described in "How to use it"
below.

## Where it lives in the admin menu

Media Twig Tools adds no admin settings page. Once enabled, its Twig functions are
available in any template that renders a media field.

## How to use it

Both helpers take a media field render array (for example
`content.field_media_1`) plus an options map. A minimal responsive `<img>` looks
like this:

```twig
{{ imgFromMedia(content.field_media_1, {
  style: 'landscape',
  class: 'bordered grow',
  attributes: { title: 'Title', alt: 'Overridden alt' },
  srcset: {
    '1x': {
      style: 'portrait',
      rules: [
        { id: 'image_crop', data: { width: 100, height: 200 } }
      ]
    },
    '2x': 'default'
  }
}) }}
```

- **`style`** sets the base image style used for the `src`.
- **`class`** and **`attributes`** are added to the tag as-is (so you can set your
  own `alt`, `title`, or `data-*` attributes).
- **`srcset`** maps each descriptor (`1x`, `2x`, …) either to the string
  `'default'` (use the base image) or to an object with its own `style` and a list
  of `rules`. Each rule has an `id` (for example `image_crop`, `image_scale`,
  `image_scale_and_crop`) and a `data` object of width/height values, and the
  derivative is generated at runtime.

For a full `<picture>` element with per-media-query sources, use
`pictureFromMedia()` with a `settings` map keyed by media query — each entry
carries its own `style` and `srcset`:

```twig
{{ pictureFromMedia(content.field_media_1, {
  style: 'landscape',
  settings: {
    '(min-width: 1024px)': {
      style: 'landscape',
      srcset: { '2x': 'default', '1x': { rules: [ { id: 'image_scale', data: { width: 2000, height: 1000 } } ] } }
    },
    '(max-width: 1024px)': {
      style: 'portrait',
      srcset: { '2x': 'default', '1x': { rules: [ { id: 'image_scale_and_crop', data: { width: 200, height: 300 } } ] } }
    }
  }
}) }}
```

Media is still rendered respecting normal media and file access, so these helpers
do not expose anything a user could not otherwise see — they only change how the
markup is produced.
