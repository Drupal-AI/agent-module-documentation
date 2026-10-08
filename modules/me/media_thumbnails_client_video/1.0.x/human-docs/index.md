# Media Thumbnails Client Video — manual setup guide

**Media Thumbnails Client Video** (`media_thumbnails_client_video`) generates
thumbnails for video files **in the visitor's browser** using JavaScript, instead of
relying on server-side tools like FFmpeg. When an editor uploads a video through a
Media entity form, the module's JavaScript grabs a frame (by default around the
2-second mark), sends it to Drupal, and — when the media is saved — the
Media Thumbnails framework picks up that pre-generated frame and uses it as the
entity's thumbnail.

If the automatic frame is not ideal, editors can open the media entity's edit page,
use the **Regenerate Thumbnail** tab, scrub the interactive video player to the exact
frame they want, and save it. The module also sets the `poster` attribute on video
tags so the generated image shows before playback.

It is an add-on to the
[Media Thumbnails](https://www.drupal.org/project/media_thumbnails) module (its only
dependency) and supports Drupal 9.3, 10, and 11. Because generation happens in the
browser, no FFmpeg or other server transcoding tool is required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media Thumbnails dependency.

There is **no configuration page** for this module — once enabled it integrates
automatically with the Media Thumbnails system. Everyday use is described under
"How to use it" below.

## How to use it

- **Automatic:** When an editor uploads a video in a Media entity form, a frame is
  captured in the browser and becomes the thumbnail once the media is saved.
- **Manual regeneration:** Open the media entity's edit page, click the **Regenerate
  Thumbnail** tab, use the video player to find the frame you want, and click
  **Regenerate Thumbnail** to save it.

**Cross-origin note:** If your videos are served from a different domain (a CDN or
S3 bucket, for example), that server must send the appropriate CORS header
(`Access-Control-Allow-Origin`); otherwise the browser will block the JavaScript
from reading frames. Very old browsers without HTML5 video/canvas support fall back
to the default Media Thumbnails behavior.
