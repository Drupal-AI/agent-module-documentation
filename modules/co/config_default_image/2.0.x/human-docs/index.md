# Config Default Image — manual setup guide

**Config Default Image** (`config_default_image`) provides image field
**formatters** whose default (fallback) image is a file path stored in
configuration — so the default image deploys with `drush cim`/`cex` like any
other setting, instead of relying on an uploaded file that never leaves the
environment it was uploaded on.

It exists to fix a real gap in Drupal core. Core's built-in default-image feature
points at an uploaded *file entity by UUID*; when you export configuration, the
field config is exported but the file's actual bytes are not — so the default
image simply doesn't show up on other environments. Config Default Image sidesteps
this by adding a formatter, **"Image or default image"** (`config_default_image`),
that stores the default as a **path string** (for example
`themes/custom/my_theme/img/default.jpg`) plus alt text, title, and dimensions,
all captured by config export. When a field is empty, the formatter builds a
temporary file from that path and renders it exactly like a real image, image
styles included. The idea is to point the path at an image committed to your repo
alongside the config, so the two deploy together.

The module works the moment you set the formatter on a display — there is **no
global settings page**, no permissions, and no Drush commands. All configuration
happens per field, on the **Manage display** tab, in the formatter's settings.
Three optional submodules apply the same idea to other base formatters:
**config_default_responsive_image** (core Responsive Image),
**config_default_svg_image** (SVG Image), and, nested under it,
**config_default_responsive_svg_image**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodule matching your base formatter.
2. [Configuration](configuration/index.md) — set up the "Image or default image"
   formatter on a field's Manage display, field by field.

## Where it lives in the admin menu

There is no dedicated page. You configure the formatter on each entity's
**Manage display** tab, e.g. **Structure → Content types → *(type)* → Manage
display** (`/admin/structure/types/manage/<type>/display`), by choosing
**Image or default image** as the format for an image field and opening its
settings gear.
