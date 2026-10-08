# Able Player — manual setup guide

**Able Player** (`ableplayer`) brings the accessible [Able Player](https://github.com/ableplayer/ableplayer)
JavaScript media player into Drupal's Media system. Instead of the browser's plain
HTML5 player, your uploaded audio, uploaded video, and remote YouTube/Vimeo video are
rendered with a keyboard-friendly, screen-reader-aware player that supports closed
captions, chapter markers, a text audio-description track, a sign-language companion
video, and a poster image. If your site has Section 508 or WCAG obligations, this is
the kind of player that helps you meet them.

The module does most of its setup for you. The moment you enable it, it programmatically
creates a set of caption/description/chapter/sign-language/poster fields on your existing
audio and video Media types, wires them into the display, and switches your local video
Media to the Able Player formatter. It also ships a dedicated **Able Player Caption**
media type so you can manage caption files (and translate them for multi-language
subtitles) through the normal Media Library.

There is **no settings form** — Able Player has no admin configuration page of its own.
All of the "configuration" is done on each Media type's *Manage display* tab by choosing
one of the module's field formatters, and the install step already does that for the
standard types. It depends only on core's **Media** and **Media Library** modules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

Able Player adds **no settings page**. What it touches instead is:

- **Structure → Media types** (`/admin/structure/media`) — this is where the auto-created
  fields and the new **Able Player Caption** media type appear, and where you set which
  formatter renders each media type on its *Manage display* tab.
- **Content → Media** (`/admin/content/media`) — where you create and (optionally)
  translate the caption, video, and audio media you want the player to show.

## How to use it

### 1. Let install do the wiring

When you enable the module it looks at every Media type whose source is a local **video**
or **audio** file and, if the fields are not already there, adds:

| Field | What it holds |
|---|---|
| Able Player Caption reference | A reference to an **Able Player Caption** media entity (a VTT file). Translate that media entity to provide captions in several languages. |
| Description (VTT) | A text audio-description track. |
| Chapter (VTT) | Chapter markers. |
| Sign language (MP4) | A sign-language companion video shown alongside the main video. |
| Poster image (JPG/PNG) | The still image shown before playback starts. |

For **Remote Video** (oEmbed) media types it instead adds two URL fields — one for a
YouTube/Vimeo audio-described alternate, and one for a YouTube sign-language video —
that viewers can toggle. Install also registers the `text/vtt` mime type so your caption
and chapter uploads validate.

### 2. Confirm the formatter on Manage display

Install already switches the standard local **video** media to the **Ableplayer Video**
formatter. If you have custom media types, or you want audio or remote video to use the
player, go to that media type's **Manage display** tab and set the file (or source URL)
field to the matching formatter:

- Local video → **Ableplayer Video**
- Local audio → **Ableplayer Audio**
- Remote video → **Ableplayer Remote Video**

The video and audio formatters automatically pull in the related caption, chapter,
sign-language, and poster fields when they render — you don't wire those up separately.
Each formatter has a few per-display options (show controls, autoplay, loop, and how
multiple files are displayed).

### 3. Add the media

Upload your video or audio through **Content → Media** and fill in whichever of the
extra fields (captions, chapters, poster, and so on) you want. For a remote video, paste
the YouTube or Vimeo URL as usual; the player detects the provider and embeds it.

### 4. Multi-language captions

1. Enable core **Content Translation** (`drush en content_translation -y`) and add your
   languages under **Configuration → Regional and language → Languages**.
2. Create an **Able Player Caption** media entity, upload the primary-language VTT, and save.
3. Translate that caption media, uploading one VTT file per language.
4. Reference the caption media from your video's *Able Player Caption* field. The player
   emits one caption track per translation, so viewers can pick their language.

### A note on assets

The core Able Player JavaScript ships inside the module, but two helper assets (a cookie
library and the Vimeo player API) are loaded from a CDN. If loading third-party assets
from a CDN is a concern on your site, plan to self-host those two files.
