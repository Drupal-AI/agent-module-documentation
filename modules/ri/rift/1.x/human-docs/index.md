# RIFT — manual setup guide

**RIFT** (`rift`) is a toolkit that makes **responsive images** in Drupal far less
painful. Instead of hand-building image styles and responsive image styles for
every breakpoint, you define reusable **Responsive Image View Modes** that
implement a responsive strategy using modern HTML — `srcset`/`sizes` or `<picture>`
elements — and apply them to your images through field formatters.

A distinctive design choice sets RIFT apart from other responsive-image modules:
its formatters are applied to **media reference fields**, not raw image fields.
That indirection is what lets it support advanced cases other modules can't. It
comes with:

- **Field formatters** for media entity reference fields — *Rift Media Picture*
  (responsive `<picture>` markup) and *Rift Media Picture with Fallback* (same,
  but other media types fall back to a configured media view mode).
- A **Twig extension** (the `rift_picture` filter) and services so developers can
  generate responsive picture markup directly in templates.
- A **plugin architecture** (RiftSource and RiftMediaSource plugins) for
  extensibility, plus integration with image cropping and focal-point tools.
- Extras like a **placeholder mode** for testing configurations and **image token
  (`?itok`)** support.

Because RIFT lives in the theme/display layer, it has no security surface of its
own: the Twig helpers render in the trusted theme layer, and the field formatters
display the same access-controlled field data any formatter would.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (recommended) its UI submodule.

RIFT has no single settings page in the core module. The **RIFT UI** submodule
(`rift_ui`) is the recommended way to create and manage your responsive sizes
through a rich interface — see "How to use it" below.

## How to use it

Before configuring anything, decide on a **responsive image strategy** for your
site (which breakpoints, which aspect ratios, which formats). Then:

1. Enable the **RIFT UI** submodule (`rift_ui`) — it is strongly recommended, and
   it adds validation and auto-healing of your configuration. With it, you create
   and manage responsive sizes through a rich UI, with **no need to create image
   styles or run any Drush commands**.
2. Define your **Responsive Image View Modes** in that UI.
3. On the **Manage display** of the content type (or other entity) that has a
   **media reference** field, set the field's format to **Rift Media Picture** or
   **Rift Media Picture with Fallback**, and choose the view mode you defined.

### For developers

RIFT also exposes a `rift_picture` Twig filter so you can produce responsive
`<picture>` markup straight from a template:

```twig
{{ node.field_image.0.entity|rift_picture({
  sizes: "120w 320w 640w 1024w 1920w",
  aspect_ratios: "1x1 16x9 16x9 4x3 4x3",
  quality: {
    "1x": "80 80 70 70 60",
    "2x": "40 40 40 40 40"
  },
  types: ["webp", "avif", "jpeg"]
}) }}
```

The filter takes a media entity plus a configuration array (`sizes`,
`aspect_ratios`, `quality` for 1x/2x pixel densities, and the `types`/formats to
generate, in order of preference).

> **Tip:** RIFT integrates with `image_widget_crop` (manual crop), `focal_point`
> (point of interest), and `crop`. Install those if you want editorial control
> over how images are cropped at each size.
