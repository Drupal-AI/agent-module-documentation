# Media Contextual Crop Embed — manual setup guide

**Media Contextual Crop Embed** (`media_contextual_crop_embed`) lets editors crop
an image *per placement* directly inside CKEditor 5. When the same media image is
embedded in more than one piece of rich text, each embed can carry its own crop —
a wide crop here, a tighter one there — without touching the underlying media
file. The crop is contextual: it belongs to that specific embed, so the original
image and its other uses are unaffected.

It builds on the **Media Contextual Cropping API**
([`media_contextual_crop`](../../media_contextual_crop/2.2.x/human-docs/index.md))
and core's **Media Library**. It provides a text-format filter and a CKEditor 5
plugin that opens a crop dialog when you insert or edit an embedded media item;
the crop data is stored in the `drupal-media` markup inside the editor content. It
has no access-control role of its own.

Like the rest of the family, this is one piece of a set. On its own it needs the
base API module **plus at least one crop adapter** to supply the actual cropping
interface — either the **Focal Point Adapter**
([`media_contextual_crop_fp_adapter`](../../media_contextual_crop_fp_adapter/2.x/human-docs/index.md))
or the **Image Widget Crop Adapter**
([`media_contextual_crop_iwc_adapter`](../../media_contextual_crop_iwc_adapter/2.2.x/human-docs/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## About this version (2.2.x)

This branch declares core support **`^11`** and requires the **2.2.0 or newer**
release of the Media Contextual Cropping API (`media_contextual_crop >= 2.2.0`),
so it is the branch to use on a Drupal 11 site running the 2.2.x API and its
dedicated derivative download controller. If you are on Drupal 10, or on the 2.1.x
line of the API, use the **2.1.x** branch of this module instead (core
`^10.3 || ^11`).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   with the API module and an adapter.

There is **no dedicated settings page** for this module (`configure` is null). You
switch it on through a text format's filter settings and CKEditor 5 toolbar, as
described below. The cropping mechanism and any crop types come from the base API
and the adapter you chose — see the base module's guide for the shared planning
notes (derivatives multiply; editors need guidance).

## Where it lives in the admin menu

Setup happens on your text formats at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`). Edit the format your
editors use, add the module's contextual-crop capability to its CKEditor 5
toolbar/filters, and save. From then on, the crop option is available when
inserting or editing an embedded media item in that editor.

## How to use it

1. Enable the base API module (2.2.x), this module, and a crop adapter (see
   [Installation](installation/index.md)).
2. Edit the text format your editors use and enable media embedding plus this
   module's contextual-crop capability in the CKEditor 5 configuration.
3. In the editor, insert or select an embedded media image and open its crop
   option. Adjust the crop for that placement and save — only that embed changes.
