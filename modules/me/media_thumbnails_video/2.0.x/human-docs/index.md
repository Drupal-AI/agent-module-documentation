# Media Thumbnails Video — manual setup guide

**Media Thumbnails Video** (`media_thumbnails_video`) automatically creates a
still-image thumbnail from a video file, so your video media entities get a real
preview frame instead of a generic file icon. It plugs into the **Media
Thumbnails** framework and uses **FFmpeg** to grab a frame from the video and
save it as a PNG on the media entity. It also adds a video field formatter that
uses that generated image as the HTML5 `<video>` **poster**, so viewers see a
meaningful preview before the video plays.

This is a great fit for media-heavy sites: media library items get proper
thumbnails, hero and background videos get posters, and editors no longer have to
upload a separate preview image for every video. Thumbnails are generated (and
regenerated) through the Media Thumbnails framework whenever a matching video
media entity's thumbnail is created.

Because the actual frame-grabbing is done by FFmpeg, the module needs a working
FFmpeg installation on the server (the `ffmpeg` and `ffprobe` binaries), the
`php-ffmpeg` PHP library, and PHP's GD extension. Without a working FFmpeg, no
thumbnails are produced. A small settings form lets you point the module at your
FFmpeg binaries and tune how it runs. This version handles MP4 (`video/mp4`)
video files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including the FFmpeg library) and enable it.
2. [Configuration](configuration/index.md) — set the FFmpeg/FFprobe paths,
   timeout, and thread count.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → Media
thumbnails video settings**
(`/admin/config/media/media-thumbnails-video-settings`).

## How to use it

For thumbnail generation, there's nothing to switch on per field — once the
module is enabled and FFmpeg is configured, the Media Thumbnails framework routes
MP4 video files to it and stores the generated PNG as the media entity's
thumbnail. Upload or re-save a video media item and its thumbnail appears (for
example in the media library). If you change the FFmpeg settings, re-generate
thumbnails through the Media Thumbnails framework to apply them.

To show the generated image as a video **poster**, use the module's field
formatter:

1. Go to the **Manage display** tab of the entity/bundle that has the video
   **file** field (for example your Video media type).
2. Set that field's formatter to **Video extended** (`file_video_extended`).
3. Save. The field now renders an HTML5 `<video>` player with the generated
   thumbnail set as its `poster` attribute — so a still preview shows before
   playback.

This formatter extends core's File Video formatter, so it behaves like the core
one but adds the poster image.
