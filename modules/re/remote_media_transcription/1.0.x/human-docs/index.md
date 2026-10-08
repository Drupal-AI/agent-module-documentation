# Remote Media Transcription — manual setup guide

**Remote Media Transcription** (`remote_media_transcription`) adds a **text
transcription field to the remote-video media type** in Drupal. If your site
embeds remote-hosted videos (YouTube, Vimeo, and similar, via oEmbed), this module
lets editors attach a written transcription to each one — improving
**accessibility** for people who can't or don't watch the video, and giving search
something to index.

The transcription is written in a **WYSIWYG editor**, so it can be rich text, and
it is displayed alongside the video on the front end with a **toggle button** that
shows or hides it. You control the button's labels, whether the transcription is
visible by default, and the animation used when it opens and closes.

Importantly, this is a **local field**, not a speech-to-text service: the module
does not send your video anywhere or generate a transcript automatically. A human
(or your own process) types or pastes the transcription into the field. It depends
on core's **Media** and **Media Library** modules and runs on Drupal 9, 10, and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the default visibility, button
   labels, animation speed, and permission.

## Where it lives in the admin menu

The module's settings are at **Configuration → Media → Remote Media
Transcription** (`/admin/config/media/remote-media-transcription`). Its permission
is managed at **People → Permissions**.

## How to use it

1. Configure the display options and grant the permission (see
   [Configuration](configuration/index.md)).
2. Edit a **remote video** media entity.
3. Find the **Video Transcription** section and type or paste the transcription
   into the WYSIWYG editor.
4. Save. On the front end, the transcription appears below the video with a toggle
   button that shows or hides it.
