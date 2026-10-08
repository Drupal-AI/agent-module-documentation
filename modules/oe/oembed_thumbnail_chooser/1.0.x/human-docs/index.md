# oEmbed Thumbnail Chooser — manual setup guide

**oEmbed Thumbnail Chooser** (`oembed_thumbnail_chooser`) upgrades the poster
images that Drupal stores for **YouTube** and **Vimeo** remote videos. Out of the
box, core's oEmbed media source keeps whatever thumbnail the provider hands back —
for YouTube that's `hqdefault`, a 480×360 image that looks soft the moment it's
shown at any real size in a modern layout. Higher‑resolution thumbnails exist, but
only for *some* videos, and the provider gives no advance signal of which ones.

This module uses the only reliable approach: **try, and fall back.** When a video
is added, it rewrites the thumbnail URL to the highest resolution, requests it, and
if that doesn't exist steps down to the next best, keeping the original as a last
resort:

- **YouTube:** try `maxresdefault`, then `sddefault`, then keep `hqdefault`.
- **Vimeo:** try `1280`, then `960`, then keep the original — and it also updates
  the reported `thumbnail_width` / `thumbnail_height` so your image styles work from
  accurate dimensions.

It's a tiny, focused module: a single hook implementation
(`hook_oembed_resource_data_alter()`), with **no routes, no permissions, and no
configuration**. Providers other than YouTube and Vimeo pass through untouched.

**One cost to be aware of.** Each oEmbed fetch now makes up to **two extra outbound
HTTP requests**, synchronously, inside the request that's creating or refreshing the
media item. Those requests use a full `GET` (downloading the whole image body where
a `HEAD` would do) with **no explicit timeout**, so they inherit your site's default
Guzzle timeout. On a **bulk import** of many remote videos, that time adds up — keep
it in mind when planning large imports.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings. It works
automatically once enabled.

## How to use it

Just enable it. From then on, any **new** YouTube or Vimeo media item picks up the
best available thumbnail automatically. For videos that already existed before you
enabled the module, **re‑save** the media item (or refresh its thumbnail) to
trigger the upgrade. To make the sharper thumbnails count, use image styles sized
larger than 480×360 on your video posters — the whole point is to stop the browser
upscaling a small `hqdefault` image.

> **Note:** At the time of writing the module notes that it depends on a core patch
> from issue [#3042423] to work. Check the current project page before relying on it,
> and confirm the providers you use permit thumbnail fetching.
