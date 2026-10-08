# Media Stream — manual setup guide

**Media Stream** (`media_stream`) enables native HTML5 **audio** and **video**
formatters for **link fields** on media entities. If a media entity stores the URL
of a stream or media file in a link field, this module lets you render that URL as a
native HTML5 `<audio>` or `<video>` player — so visitors get a proper media player
without any manual embed code.

It is purely a display formatter: it adds no content type, no permissions of
consequence, and no access behavior — the media follows your existing media/file
access. It depends only on core **Media** and supports Drupal 9, 10, and 11. (This
module addresses core issue
[#2927166](https://www.drupal.org/node/2927166).)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media dependency.

This module has **no configuration page**. You choose and configure the formatter
entirely on a media type's *Manage display*, as described under "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Media types →
*(media type)* → Manage display** (`/admin/structure/media`), on a media type that
has a **link** field.

## How to use it

1. Make sure your media type has a **link** field holding the stream or file URL you
   want to play.
2. Go to that media type's **Manage display** tab.
3. For the link field, choose the HTML5 **audio** or **video** formatter provided by
   Media Stream.
4. Save. The stored URL now renders as a native HTML5 player on the media entity's
   display.
