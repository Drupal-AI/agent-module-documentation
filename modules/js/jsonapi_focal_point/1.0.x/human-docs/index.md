# JSON:API Image Styles Focal Point — manual setup guide

**JSON:API Image Styles Focal Point** (`jsonapi_focal_point`) is a JSON:API
extension that exposes an image's **Focal Point** data — the crop-focus
coordinates an editor sets with the
[Focal Point](https://www.drupal.org/project/focal_point) module — through
JSON:API. On a decoupled or headless site, that lets your front end crop and
resize images with the correct focus preserved, instead of guessing where the
important part of a picture is.

By default, JSON:API doesn't include focal-point data in its image output, so a
headless front end has no way to honour the editor's crop choices. This module
fills that gap: with it enabled, the focus coordinates travel alongside the image
in the API response, and your front-end code can apply focal-point-aware cropping
client-side.

It builds on [JSON:API Extras](https://www.drupal.org/project/jsonapi_extras),
which is where you manage how JSON:API resources are shaped — so the focal-point
enhancement is configured through Extras rather than through a settings page of its
own. As with any API surface, remember that exposing image metadata is a data
exposure decision: make sure the relevant JSON:API resources are access-controlled
appropriately. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Focal Point
   / JSON:API Extras dependencies, then enable it.

There is **no dedicated configuration page** for this module. It enhances JSON:API
image output automatically, and any resource shaping is done through **JSON:API
Extras**, described below.

## How to use it

1. Make sure the [Focal Point](https://www.drupal.org/project/focal_point) module
   is set up and your editors are choosing focus points on images.
2. With this module enabled, the focal-point data is exposed through JSON:API.
   Manage the JSON:API resource configuration (field names, whether fields are
   enhanced, and so on) through **JSON:API Extras**, at its settings under
   **Configuration → Web services → JSON:API Overwrites**.
3. In your decoupled front end, read the focal-point coordinates from the API
   response and use them to crop or position images correctly.
