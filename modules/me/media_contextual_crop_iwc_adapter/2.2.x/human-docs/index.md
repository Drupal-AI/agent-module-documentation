# Media Contextual Crop — Image Widget Crop Adapter — manual setup guide

**Media Contextual Cropping with image_widget_crop Plugin**
(`media_contextual_crop_iwc_adapter`) is the bridge that lets **Image Widget Crop**
supply the cropping interface for **Media Contextual Cropping**. The two modules
address the same underlying problem — one image is used in several places and the
right crop differs per place, so cropping the media entity once forces a single
answer for every use. Media Contextual Cropping solves that by allowing a crop
*per usage context*; this adapter plugs in Image Widget Crop — the established
cropping UI in the Drupal ecosystem — as the interface for doing it, rather than a
second crop tool with its own conventions.

That is the whole value of an adapter, and it is worth stating plainly: a site
that **already uses Image Widget Crop** keeps one cropping experience and one set
of crop types, instead of asking editors to learn two. If your site does not
already use Image Widget Crop, you do not need this adapter — consider the
[Focal Point Adapter](../../media_contextual_crop_fp_adapter/2.x/human-docs/index.md)
instead. Either way you also need the base
[Media Contextual Cropping API](../../media_contextual_crop/2.2.x/human-docs/index.md)
and a family module (Embed or Reference) to actually crop anything.

The adapter itself is thin: it registers one crop plugin plus a couple of form
tweaks that reword the crop-reuse message and remove the *Reset* button from the
embedded Image Widget Crop widget so the contextual-crop dialog behaves, along
with a small CSS fix for the editor media dialog's layout.

A practical note carried through from the family: contextual crops **multiply
derivatives** — one image with four contexts and three image styles each is twelve
files. That's fine, but worth knowing when sizing storage for a media-heavy site,
and worth checking that derivative generation is not happening on request for a
page full of them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## About this version (2.2.x)

This branch narrows to Drupal core **`^11`** (Drupal 10 support dropped) and adds
explicit Composer constraints: it pins the base API to `media_contextual_crop
~2.2.0` and accepts `image_widget_crop ^2.4 || ^3.0`. Functionally, 2.2.x also
avoids a redundant save — when you open a context but don't move the crop
selection, the adapter now detects that the geometry is unchanged and reuses the
existing crop rather than writing a fresh crop entity. If you are on Drupal 10 or
the 2.0.x API line, use the **2.0.x** branch of this adapter instead (core
`^10 || ^11`).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   with the API module, Image Widget Crop, and a family module.

There is **no configuration page** for this module (`configure` is null) and no
settings form — it simply registers Image Widget Crop as the crop plugin. All
cropping is set up through the base API and the family modules.

## Where it lives in the admin menu

This adapter adds no admin page. Once it and the rest of the family are enabled,
the Image Widget Crop interface appears wherever you configure contextual
cropping — on a media/reference field's **Manage display**, or in a text format's
CKEditor 5 settings for embeds.

## How to use it

1. Enable the base API module (2.2.x), this adapter, Image Widget Crop, and a
   family module (Embed or Reference) — see [Installation](installation/index.md).
2. Configure contextual cropping as usual on your field's *Manage display* (or in
   CKEditor 5 for embeds). With this adapter enabled, Image Widget Crop provides
   the cropping mechanism behind it, reusing your existing crop types.
