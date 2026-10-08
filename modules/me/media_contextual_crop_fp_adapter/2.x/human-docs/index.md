# Media Contextual Crop Focal Point Adapter — manual setup guide

**Media Contextual Crop Focal Point Adapter** (`media_contextual_crop_fp_adapter`)
is the bridge that lets **Focal Point** supply the cropping mechanism for **Media
Contextual Cropping**. Contextual cropping (a different crop per usage context) and
Focal Point (focus-aware cropping) are two separate approaches; this small adapter
plugs Focal Point in as the crop plugin behind the contextual cropping system, so
a site that already uses Focal Point can keep that familiar focus-point workflow
while gaining per-context crops.

It is purely an integration module — a single crop plugin, with no settings of its
own and no security surface. Install it when both **Media Contextual Cropping** and
**Focal Point** are in use and you want focal-point-driven contextual crops. If
you prefer Image Widget Crop as the cropping interface instead, use the
[Image Widget Crop Adapter](../../media_contextual_crop_iwc_adapter/2.0.x/human-docs/index.md)
in its place. You need one adapter or the other (or both), together with the base
[Media Contextual Cropping API](../../media_contextual_crop/2.1.x/human-docs/index.md)
and a family module (Embed or Reference) to actually do any cropping.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   with the API module, Focal Point, and a family module.

There is **no configuration page** for this module (`configure` is null) and no
settings form — it simply registers a crop plugin. All cropping is set up through
the base API and the family modules; see the base module's guide for the shared
planning notes.

## Where it lives in the admin menu

This adapter adds no admin page. Once it and the rest of the family are enabled,
the cropping interface it enables appears wherever you configure contextual
cropping — on a media/reference field's **Manage display**, or in a text format's
CKEditor 5 settings for embeds.

## How to use it

1. Enable the base API module, this adapter, Focal Point, and a family module
   (Embed or Reference) — see [Installation](installation/index.md).
2. Configure contextual cropping as usual on your field's *Manage display* (or in
   CKEditor 5 for embeds). With this adapter enabled, Focal Point provides the
   cropping mechanism behind it.
