# Video Embed Field Dailymotion — manual setup guide

**Video Embed Field Dailymotion** (`video_embed_dailymotion`) adds
[Dailymotion](https://www.dailymotion.com/) support to the
[Video Embed Field](https://www.drupal.org/project/video_embed_field) module.
Once it is enabled, editors can paste a Dailymotion video URL into a Video Embed
Field and it renders as a responsive, fullscreen‑capable Dailymotion iframe with
a cached poster thumbnail — no hand‑written embed markup required.

The entire module is a single "provider" plugin for Video Embed Field. It adds
**no configuration page, no permissions, and no settings of its own** — every
option that affects how the video appears (width and height, autoplay, lazy
loading, thumbnails, the accessible iframe title) comes from Video Embed Field's
own field formatter and widget settings. Installing this module simply makes
**Dailymotion** appear in the list of recognised video providers.

Because it builds on Video Embed Field, that module is a hard dependency and
Composer installs it for you. It works on Drupal 10.3+ and Drupal 11. There are
no submodules. The module works the moment you enable it — there is nothing to
configure here beyond your normal Video Embed Field setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no settings page of its own. You work with it wherever you manage
your Video Embed Field fields — under **Structure → Content types →** *(your
type)* **→ Manage fields / Manage form display / Manage display**, or wherever
else you have added a `video_embed_field`.

## How to use it

The workflow is the standard Video Embed Field one:

1. Add a **Video Embed Field** to a content type (or use one you already have).
2. When editing content, paste a Dailymotion URL into that field. Recognised
   formats include full watch URLs
   (`https://www.dailymotion.com/video/x8abc12`), short share links
   (`https://dai.ly/x8abc12`), and Dailymotion embed URLs. Any trailing
   `_slug` on the URL is ignored.
3. Save. The video renders as a Dailymotion iframe, and a poster thumbnail is
   downloaded and cached for teaser/list views.

You can freely mix Dailymotion videos alongside YouTube and Vimeo in the same
field. Dimensions, autoplay, and lazy loading are all controlled by the field's
display formatter settings under **Manage display**.

**If a field restricts its allowed providers**, you must explicitly allow
Dailymotion for it: go to **Manage form display**, open the video field's
widget settings (the cog icon), and tick **Dailymotion** — otherwise Dailymotion
URLs are rejected when the content is saved.
