# Drimage — manual setup guide

**Drimage** (Dynamic Responsive Image, `drimage`) is a field formatter for image
fields that generates image styles **on the fly**, sized to the actual width the image
is rendered at in the browser. Instead of hand-building and maintaining a set of
Responsive Image styles and breakpoints, you just pick the Drimage formatter and it
serves each image at the exact size it's displayed — with lazy loading, retina/HiDPI
support, and optional WebP.

Here's how it works: the formatter renders an image with a bit of JavaScript that
measures the element's real pixel width, snaps it to a configurable grid, and requests
a derivative from Drimage's own route. The controller then finds — or **creates** — a
matching image style and delivers the derivative. So the styles you'd normally
configure by hand are produced automatically as pages are viewed.

Drimage depends only on core's **Image** module. It has global settings (to cap sizes,
tune the grid, and enable WebP) plus per-field formatter settings (scale, fixed
aspect-ratio crop, CSS background, or Image Widget Crop). It integrates optionally with
**Focal Point**, **Crop / Image Widget Crop**, **Automated Crop**, and
**ImageAPI Optimize WebP**, and provides a Drush command to clear its generated styles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the global settings, the per-field
   formatter, and the Drush cleanup command.

## Where it lives in the admin menu

- **Global settings** at **Configuration → Media → Drimage**
  (`/admin/config/media/drimage`), gated by the **Administer image styles** permission.
- **Per-field formatter** on each entity's **Manage display** tab, where you switch a
  field to the **Drimage** formatter.
