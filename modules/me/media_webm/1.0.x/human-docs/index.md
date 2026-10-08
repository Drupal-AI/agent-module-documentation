# Media: Webm — manual setup guide

**Media: Webm** (`media_webm`) automatically converts uploaded **MP4** video files
to **WebM** format inside your Drupal site. MP4 is widely supported, but WebM
usually compresses better and is optimised for web delivery, so offering a WebM
version alongside the original gives browsers a smaller, more efficient option for
`<video>` playback. The module handles the conversion transparently: when an MP4 is
uploaded to a video media type, it queues a conversion job, produces the WebM file,
and displays it through its own field formatter.

Conversion runs through Drupal's **Queue API** rather than blocking the upload, so
large files do not tie up the request. You process the queue either manually with a
Drush command or automatically via cron. Because the actual encoding is done by an
external video encoder, the module needs **FFmpeg** (or an equivalent encoder)
available on the server.

Media: Webm depends only on core **Media** and works on Drupal 9, 10 and 11. There
is no site‑wide settings form — setup is a structural step on your video media type
(add the file field and use the WebM formatter) plus arranging for the conversion
queue to run. Those steps are described under "How to use it" below. Note the
module is currently under active development (1.0.x‑dev) and is **not covered by
Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and make sure a video encoder is available.

There is **no module configuration page** — Media: Webm has no global settings
form. Setup happens on your media type's display and by running the conversion
queue, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page of its own. You work with it through:

- **Structure → Media types** (`/admin/structure/media/manage`) — to add the MP4
  file field and set the WebM field formatter on your video media type's **Manage
  display**.
- Your site's **cron** configuration, or a manual Drush command, to process the
  conversion queue.

## How to use it

1. On your **video media type** (**Structure → Media types**), make sure there is a
   file field for MP4 uploads (for example `field_media_video_file`).
2. On that type's **Manage display**, set the field to use the **Media: Webm**
   field formatter so the converted WebM is displayed.
3. Upload MP4 videos through the media type's file field as usual. Each upload
   enqueues a conversion job.
4. Process the conversion queue. Manually:

   ```bash
   drush queue:run media_webm_converter
   ```

   Or set up **cron** to run at regular intervals so the queue is processed
   automatically — the WebM derivatives are then generated in the background and
   shown via the formatter.
