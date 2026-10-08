# Media Contextual Crop Reference — manual setup guide

**Media Contextual Crop Reference** (`media_contextual_crop_field_formatter`) lets
the same media item be cropped *differently depending on where it is referenced*.
One photo can be a wide banner on the homepage and a square thumbnail in a card,
without a duplicate media entity — the crop travels with the *usage* (the field
instance where the media is referenced) rather than with the asset itself.

It is a **field formatter**, not a new field type: you apply it through the display
settings of an existing media entity reference field, so adding or removing it
changes no stored field schema. When an editor places a referenced media item,
they can adjust the crop for that particular reference, and the canonical media
asset — along with its alt text, metadata, and every other usage — stays
untouched.

This is part of the **Media Contextual Cropping family** and does its job on top
of two other modules: the base
**[Media Contextual Cropping API](../../media_contextual_crop/2.1.x/human-docs/index.md)**
(`media_contextual_crop`), which stores and applies the crops, and
**Media Library Media Modify** (`media_library_media_modify`), which is what makes
per-reference modification from the media library possible. You also need at least
one crop adapter — Focal Point
([`media_contextual_crop_fp_adapter`](../../media_contextual_crop_fp_adapter/2.x/human-docs/index.md))
or Image Widget Crop
([`media_contextual_crop_iwc_adapter`](../../media_contextual_crop_iwc_adapter/2.0.x/human-docs/index.md)) —
to supply the cropping interface.

One installation detail deserves attention: this module's Composer requirements
include **`cweagans/composer-patches`**, which means installing it applies patches.
That plugin must be listed under `config.allow-plugins` in your project's
`composer.json`, or the `composer require` will abort. It also accepts
`media_library_media_modify` at a **beta** constraint (`^2.0.0@beta`) as well as
the stable `^1.0.0`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with the
   patches plugin allowed) and enable it with the API module and an adapter.

There is **no dedicated settings page** for this module (`configure` is null). You
configure it on a media reference field's **Manage display**, choosing this
formatter for the field. The shared planning notes — derivatives multiply, and
editors need guidance so they don't set a crop for one context and forget the
others — are covered in the base module's guide.

## Where it lives in the admin menu

Media Contextual Crop Reference adds no admin page. You use it under **Structure →
Content types (or other entity type) → *(bundle)* → Manage display**: set the
display format of a media *entity reference* field to this module's contextual
crop formatter, then configure the crop options offered by the base API and your
chosen adapter.

## How to use it

1. Enable the base API module, this module, and a crop adapter (see
   [Installation](installation/index.md)).
2. On the entity that references media, go to **Manage display** and set the media
   reference field's formatter to the contextual crop formatter this module
   provides.
3. When editing content, adjust the crop for that reference. The same media item
   referenced elsewhere keeps its own crop, and the underlying asset is unchanged.
