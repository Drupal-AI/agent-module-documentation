# Cloudinary — manual setup guide

**Cloudinary** (`cloudinary`) integrates the [Cloudinary](https://cloudinary.com/)
media management and transformation service into Drupal. Cloudinary is a media CDN
that stores your images and video remotely and transforms them on demand — resize,
crop, optimize, convert to WebP, and deliver from a global edge network. This
module hooks that service into Drupal so your media is offloaded to Cloudinary
instead of being stored and processed on your own server.

Its headline feature is turning Drupal's own **image styles** into Cloudinary
transformations automatically: the standard effects (crop, desaturate, resize,
rotate, scale, scale‑and‑crop) are converted into Cloudinary's transformation URLs
without patching core. The result is on‑demand derivatives (no pre‑generated files
piling up locally), automatic WebP conversion and substantially smaller image
files.

The project ships as a suite of submodules you enable according to your needs:
`cloudinary_sdk` (the supporting Cloudinary PHP SDK library), `cloudinary_stream_wrapper`
(a `cloudinary://` stream wrapper so uploads go straight to Cloudinary),
`cloudinary_storage` (caches the remote file structure locally to cut network
round‑trips, with DB/filesystem/MongoDB/Redis backends), `cloudinary_media_library_widget`
(a Media source and media‑library widget), `cloudinary_video` (HTML5 and Cloudinary
video player integration) and `cloudinary_source_migrate` (migrating existing
sources into Cloudinary).

Two things belong in the plan before you commit. First, your **Cloudinary API key
and secret are credentials** — keep them out of plain configuration (see the
Configuration guide for the environment‑variable approach). Second, media you
upload **resides on Cloudinary**, which means it leaves your infrastructure; that's
a deliberate data‑location decision, and if you host any non‑public media, make
sure it isn't left publicly transformable through Cloudinary's URL model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enter your Cloudinary credentials and
   secure them with environment variables.

## Where it lives in the admin menu

After enabling, enter your Cloudinary credentials at **Configuration → Media →
Cloudinary**. From there, Drupal image styles are automatically translated into
Cloudinary transformations.
