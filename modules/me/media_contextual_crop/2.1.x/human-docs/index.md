# Media Contextual Cropping API — manual setup guide

**Media Contextual Cropping API** (`media_contextual_crop`) lets the same media
image carry a *different crop for each place it is used*, instead of one crop that
has to serve every use. A landscape photograph might be a wide hero on the
homepage, a square thumbnail in a card grid, and a portrait in a sidebar — each
of those wants a different part of the picture kept, and a single stored crop
cannot do that. This module makes the crop a property of the **usage** rather than
of the media entity.

It does this with two plugin types — one for the cropping mechanisms and one for
the contexts (use cases) in which a crop applies — plus a path processor that
makes each contextual derivative addressable by URL. It depends on the contrib
**Crop API** (`crop`) and core's **Field** module.

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

## About this version (2.1.x)

The 2.x branch is the current approach, which stores context *in the crops*
themselves (the older 1.x branch worked by generating copies of the source
image). This **2.1.x** release supports Drupal core `^10 || ^11`. If you are on
Drupal 11.4 with the latest Crop API, see the **2.2.x** branch instead, which
narrows to core `^11.4` and adds a dedicated derivative download controller and a
migration Drush command.

## Contents

1. [Installation](installation/index.md) — install the API module with Composer
   and enable it alongside its Crop API dependency.

There is **no configuration page** for this module — it is an API. All the
visible setup happens in the family and adapter modules listed above, and on your
fields' *Manage display*.

## Where it lives in the admin menu

Media Contextual Cropping API adds no admin page. Once the family and adapter
modules are in place, contextual cropping is configured on your media/reference
fields under **Structure → … → Manage display**, and (for embeds) in your text
format's CKEditor 5 settings.
