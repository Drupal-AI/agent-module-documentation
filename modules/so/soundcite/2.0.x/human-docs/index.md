# SoundCite — manual setup guide

**SoundCite** (`soundcite`) brings Knight Lab's **SoundCite** inline-audio tool
into Drupal. It lets content editors wrap a piece of text so that clicking it
plays a short audio clip — a specific segment of an audio file — right there in
the flow of the text, without a bulky player. It provides two ways to do this: a
**CKEditor 5 plugin** and a **field formatter** for audio-file fields.

The CKEditor 5 integration adds a toolbar button that inserts a SoundCite clip.
When you use it you supply the audio URL, a start time, an end time, the number of
plays, and the link text; the plugin then generates the markup and loads the
libraries that turn it into a playable inline clip. The field formatter,
**"Soundcite Audio Player"**, does the same job for file fields that hold audio:
you can set start/end times, number of plays, custom link text (or fall back to
the file description or filename), and it supports common audio formats (mp3, wav,
ogg, m4a, aac, flac).

It depends only on core's **File** module and provides its own permission.
CKEditor 5 is only needed if you want the in-editor button — the field formatter
works without it. Because the plugin inserts SoundCite markup into rich text, make
sure the text format's allowed HTML tags permit that markup, and only offer the
plugin on text formats you trust. The module carries no access-control role beyond
its permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SoundCite has no central settings page; you configure it in the two places it
plugs into.

- **For the CKEditor 5 button:** go to **Configuration → Content authoring → Text
  formats and editors** (`/admin/config/content/formats`), edit a format that uses
  CKEditor 5 (for example *Basic HTML*), drag the **Soundcite** button into the
  toolbar, and save. It then appears in formatted-text fields using that format.
- **For the field formatter:** create or edit a **file field** that accepts audio
  files, then on the content type's **Manage display** settings choose **"Soundcite
  Audio Player"** as the formatter for that field and configure its options
  (start/end time, plays, link text).
