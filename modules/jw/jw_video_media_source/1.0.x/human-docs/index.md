# JW player media source for media library — manual setup guide

**JW player media source for media library** (`jw_video_media_source`) lets editors
add [JW Player](https://www.jwplayer.com/)‑hosted videos to Drupal as **media
entities** through the standard **Media Library**. An editor pastes a JW Player
media ID, and the module fetches the video's details from JW's CDN and turns them
into a reusable media item.

Behind the scenes a `MediaFetcher` service calls JW's fixed CDN endpoint
(`https://cdn.jwplayer.com/v2/media/{id}`) over a TLS‑verified connection, caches
the response, downloads the video's thumbnail, and fills in metadata — title,
description, duration, dimensions, and the MP4 source URL. The video is then
rendered on the page in an HTML5 `<video>` tag, and the accompanying field
formatter lets you control playback options such as showing controls, looping,
muting, autoplay, and the player's width and height.

Because adding a video requires media‑create privileges, this is an editorial
feature, not a public endpoint — visitors never supply a URL that the server
fetches. Video hosting and streaming stay on JW's platform; Drupal just stores the
reference. The module requires core's Media and Media Library modules and supports
Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its Media dependencies.

There is **no central settings form** for this module. You set up a JW Player media
type once in the admin UI, and each video's playback options are set on the field
display — both described in "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated settings page. You configure a media type at
**Structure → Media types** (`/admin/structure/media`) and add videos through the
**Media Library** wherever a media field appears.

## How to use it

1. Create a **media type** at **Structure → Media types → Add media type**, and
   choose **JW Player** (this module's media source) as its source. Drupal creates
   the source field that stores the JW media ID.
2. On that media type's **Manage display**, use the module's field formatter to
   render the video, and set its playback options — **show controls**, **loop**,
   **mute**, **autoplay**, and the **height** and **width**.
3. Add a **media reference field** for that type to your content (or use it through
   Layout Builder), then add videos via the **Media Library**: paste a JW Player
   media ID and the module fetches the video's metadata and thumbnail. Videos you
   add are reusable across the site like any other media.
