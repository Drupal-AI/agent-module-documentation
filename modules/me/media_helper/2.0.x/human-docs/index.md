# Media Helper — manual setup guide

**Media Helper** (`media_helper`) makes it much easier to render Media image and
video entities exactly how you want them — either from a Twig template or through a
field formatter — without wrestling with view modes. Its Twig filters and functions
let you output a media image (through any image style), a media video, or a media's
URL directly in a template, and it handles the media's cache metadata and access
checks for you automatically.

For site builders who prefer to stay in the display UI, the module also ships a
**"Rendered image"** field formatter for media reference fields, where you can pick
the image style, add CSS classes, and set HTML attributes without touching code.

The Twig side exposes filters `media_image`, `media_image_url`, `media_video`, and
`media_first_nonempty`, plus functions `media_bundle` and `media_source`. Each one
accepts flexible input — a reference field, a render array, a media entity, or even
a media ID — so templates stay short. Rendering respects the viewer's `view` access
on each media item, and cache tags bubble correctly, so nothing you render this way
leaks media a user shouldn't see. It integrates transparently with the Responsive
Image module and, when you switch them on, with the *SVG Image* and *SVG Image
Field* modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its core dependencies.
2. [Configuration](configuration/index.md) — the small settings form for the
   optional SVG integrations.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → Media → Media Helper**
(`/admin/config/media/media-helper`). It only exposes the optional SVG
integrations — everything else works the moment the module is enabled.

## How to use it

Most of the value is in Twig. A few examples:

```twig
{# Render a media image through the "500x500" image style #}
{{ node.field_media_image|media_image('500x500') }}

{# Add a CSS class #}
{{ node.field_media_image|media_image('large', 'hero-image') }}

{# Just the URL of a styled derivative #}
{{ node.field_media_image|media_image_url('thumbnail') }}

{# Render an uploaded video with sensible defaults #}
{{ node.field_media_video|media_video }}

{# Pass a media ID directly #}
{{ 6|media_image }}
```

Omit the image‑style argument to fall back to the media's default‑display style,
and pass a Responsive Image style machine name where you'd normally pass an image
style — Media Helper handles it transparently.

Prefer the UI? On any entity's **Manage display**, set a media reference field's
format to **Rendered image** and configure the image style, classes, and
attributes there.
