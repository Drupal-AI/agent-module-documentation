# Media Contextual Cropping API — manual setup guide

**Media Contextual Cropping API** (`media_contextual_crop`) lets the same media
image carry a *different crop for each place it is used*, instead of one crop that
has to serve every use. A landscape photograph might be a wide hero on the
homepage, a square thumbnail in a card grid, and a portrait in a sidebar — each of
those wants a different part of the picture kept, and a single stored crop cannot
do that. This module makes the crop a property of the **usage** rather than of the
media entity.

It does this with two plugin types — one for the cropping mechanisms and one for
the contexts (use cases) in which a crop applies — a path processor that makes
each contextual derivative addressable by URL, and a dedicated download controller
that serves each derivative through a route as close as possible to core's own
image delivery. It depends on the contrib **Crop API** (`crop`) and core's
**Field** module.

This is the **base API module**: on its own it does nothing you can see. To
actually crop things you install the pieces of the *Contextual Cropping family*
built on top of it:

- **Media Contextual Crop Embed** (`media_contextual_crop_embed`) — crop images
  embedded in CKEditor 5, per placement.
- **Media Contextual Crop Reference** (`media_contextual_crop_field_formatter`) —
  crop media referenced through an entity reference field, per reference.

…together with at least one **crop adapter**, which supplies the actual cropping
interface:

- **Focal Point Adapter** (`media_contextual_crop_fp_adapter`) — use Focal Point.
- **Image Widget Crop Adapter** (`media_contextual_crop_iwc_adapter`) — use Image
  Widget Crop.

Two things are worth planning before you commit to contextual cropping.
**Derivatives multiply**: one image across four contexts and three image styles is
twelve derivative files, so a media-heavy site should size storage accordingly and
confirm derivatives are pre-generated rather than built on request for a page full
of them. And **editors need to understand what they're cropping**: a per-context
crop is a more sophisticated model than a single crop, and without a clear
interface and some guidance the common outcome is a crop set for one context and
forgotten for the others — which can look worse than no contextual cropping at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## About this version (2.2.x)

This **2.2.x** release targets **Drupal core `^11.4` only** — Drupal 10 support
has been dropped. It relies on a **core patch** that refactors core's
`ImageStyleDownloadController` so this module's contextual download controller can
reuse core's derivative token, scheme, and access checks. It also adds a database
index on the Crop table to speed up context lookups (applied by the module's
install and update hooks). If you are on Drupal 10, use the **2.1.x** branch
instead, which supports core `^10 || ^11`.

New in 2.2.x is a Drush command, **`media_contextual_crop:migrateToImageFormatter`**,
which rewrites media view displays that use the *Contextual Crop Image* formatter
back to the plain core *image* formatter when their image style no longer performs
multiple crops — handy for tidying up displays after a design change.

## Contents

1. [Installation](installation/index.md) — install the API module with Composer,
   apply the required core patch, and enable it.

There is **no configuration page** for this module — it is an API. All the
visible setup happens in the family and adapter modules listed above, and on your
fields' *Manage display*.

## Where it lives in the admin menu

Media Contextual Cropping API adds no admin page. Once the family and adapter
modules are in place, contextual cropping is configured on your media/reference
fields under **Structure → … → Manage display**, and (for embeds) in your text
format's CKEditor 5 settings. Maintenance tasks such as
`media_contextual_crop:migrateToImageFormatter` are run from the command line with
Drush.
