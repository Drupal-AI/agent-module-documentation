# Image Style Warmer — manual setup guide

**Image Style Warmer** (`image_style_warmer`) pre-generates your image style
derivatives — the resized, cropped, and converted versions of an image — so the files
already exist on disk before a visitor ever asks for them. Normally Drupal creates an
image derivative *lazily*, on the first request for it, which means the first visitor to
a page "pays" for the resize with a slower load. This module warms those derivatives
ahead of time so nobody hits that delay.

You configure two lists of image styles on a single settings form. **Initial image
styles** are generated immediately, in the same request, whenever a permanent image file
is saved (uploaded or updated) — ideal for fast, light styles like thumbnails.
**Queue image styles** are generated later by a cron queue worker — ideal for heavy or
expensive styles (large hero crops, WebP conversions) that you don't want to slow down
the save. Generation is idempotent, so a derivative that already exists is never rebuilt.

Beyond automatic warming on upload, the module ships a Drush command to back-fill
derivatives for images that already existed (handy after you add a new image style), and
Views Bulk Operations actions so editors can warm selected files or media entities from a
list.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choosing which styles warm on upload versus
   via cron, plus the Drush command and bulk actions.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Development → Performance → Image Style
Warmer** (`/admin/config/development/performance/image-style-warmer`), behind the
**Administer site configuration** permission.

## How to use it

1. Enable the module.
2. On the settings form, tick the image styles you want warmed **on upload** (Initial)
   and the ones you want warmed **via cron** (Queue).
3. From then on, every image you upload has those derivatives created automatically. To
   warm images that already existed before you configured the module, run
   `drush isw:wu` — see [Configuration](configuration/index.md) for details.
