# Rijksvideo — manual setup guide

**Rijksvideo** (`rijksvideo`) is a media integration aimed at **Dutch governmental
websites** that use the Rijksvideo platform (Rijksbeeldbank). It adds a new media
type — **Rijksvideo** — that displays video in an **accessible** way, with support
for subtitles, audio captioning, and transcriptions, which matters a great deal for
government accessibility requirements.

The way it works is neat: when you upload a Rijksvideo **XML file** (exported from
Rijksbeeldbank), the module reads it and automatically populates all the relevant
fields from the data in that XML. You can then place the Rijksvideo media entity on
a node — or any entity that supports media fields — and choose, in the media
display settings, whether to show multiple accordions or a single download
accordion.

One version note worth flagging up front: from version 2.0.0-alpha4 onward,
Rijksvideo **only supports XML uploads** and drops embed/iframe input. This
**1.x** branch (which this guide covers) supports the same XML uploads and is the
recommended track if you have never moved to a 2.x alpha.

Because the video is served from the Rijksvideo platform, embedding it loads a
third-party player origin, which can carry the platform's tracking — gate embeds
behind consent where your policies require it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Media.

This module has **no dedicated settings form**. You configure it through Drupal's
standard **Media** administration — creating the media type's fields and choosing
its display — as described below.

## How to use it

1. Make sure the core **Media** and **Media Library** modules are enabled (they are
   Rijksvideo's dependencies).
2. Enabling Rijksvideo provides the **Rijksvideo** media type. Add a **media
   reference field** to the content type (or other entity) where you want to show
   videos, allowing the Rijksvideo media type.
3. Create a Rijksvideo media item by **uploading the XML file** exported from
   Rijksbeeldbank. The module fills in the relevant fields automatically from the
   XML.
4. On the media type's / field's **Manage display**, choose how the video renders —
   showing **multiple accordions** or a **single download accordion** — to suit
   your page.

> **Accessibility is the point.** Rijksvideo surfaces subtitles, audio captioning,
> and transcriptions from the source data. Keep those enabled in your display so
> the video meets the accessibility expectations of a Dutch government site.
