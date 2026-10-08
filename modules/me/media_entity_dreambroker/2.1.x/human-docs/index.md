# Media Entity Dream Broker — manual setup guide

**Media Entity Dream Broker** (`media_entity_dreambroker`) adds a media source for
[Dream Broker](https://dreambroker.com/), the business video platform, so editors
can add Dream Broker videos as Drupal media entities and embed them through the
media system, consistent with every other media type. There is no API to set up
and no extra key to manage: the module uses the automatically generated iframe
code that Dream Broker Studio provides, so you simply reference a video and it
embeds.

It depends only on Drupal core's Media module and runs on Drupal 10.1 and 11. The
module has no content or access‑control role of its own — the videos are hosted on
Dream Broker, and Drupal's normal media access applies.

Because the player is embedded from Dream Broker's servers, the video loads
third‑party content in your visitors' browsers. That is the usual egress and
privacy consideration for any external embed: Dream Broker sees the visitors who
load the player.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

This module has no separate settings page. You set it up by creating a media type
that uses the Dream Broker source, described below.

## Where it lives in the admin menu

Media Entity Dream Broker adds no admin settings form. The media types you create
with the Dream Broker source appear under **Structure → Media types**
(`/admin/structure/media`), and individual videos are managed from **Content →
Media** (`/admin/content/media`) or through the Media Library.

## How to use it

1. **Create a media type that uses the Dream Broker source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), name it (for
   example "Dream Broker video"), and in the **Media source** field choose **Dream
   Broker**. Save.
2. **Add a video.** Go to **Content → Media → Add media**, choose your Dream
   Broker media type, and provide the video's URL or ID from Dream Broker Studio.
   Save.
3. **Reuse it.** The video is now in the Media Library and can be referenced from
   media reference fields or inserted through the CKEditor Media button wherever
   entity embedding is allowed.
