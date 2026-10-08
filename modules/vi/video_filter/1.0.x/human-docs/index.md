# Video Filter — manual setup guide

**Video Filter** (`video_filter`) lets content authors embed videos by typing a
simple tag instead of pasting provider‑specific `<iframe>` code. Write
`[video:https://www.youtube.com/watch?v=ID]` in a body field and, on render, the
module turns it into an embedded player. It recognizes the URL by matching it against
a large set of pluggable provider "codecs" — YouTube, Vimeo, Dailymotion, Twitch,
Spotify, and roughly 45 others ship built in.

The tag gives editors a consistent, memorable syntax and keeps raw embed markup out of
stored content (the filter is reversible, so the `[video:…]` tag stays in the text and
the player is regenerated on each view). Authors can override width, height, aspect
ratio, alignment, and provider options per‑video right in the tag — for example
`[video:URL width:640 height:360 ratio:16/9 align:right autoplay:1]`. Site builders
control which providers are allowed and the default player size per text format.

Video Filter is a **text‑format filter**, so there is no standalone settings page — you
enable and configure it on the text formats where you want it, at *Text formats and
editors*. It has no dependencies beyond core, provides its own `video_filter` plugin
type (so developers can add new providers), and ships one submodule,
**video_filter_example**, that demonstrates writing a custom codec.

> **Trust matters.** Video Filter outputs embed HTML (iframes). Only enable it on text
> formats used by **trusted** authors, and keep a *Limit allowed HTML tags* filter on
> any format available to lower‑trust roles. See the note in
> [Configuration](configuration/index.md#security-only-enable-on-trusted-formats).

Note that Video Filter also ships a legacy CKEditor **4** button/dialog. CKEditor 4 was
removed in Drupal 11, so that WYSIWYG button is inert there — but the typed `[video:…]`
tag still works fine.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it,
   and (optionally) the example submodule.
2. [Configuration](configuration/index.md) — enable the filter on a text format, the
   per‑format settings, the author tag syntax, and the trust/security note.

## Where it lives in the admin menu

There is no dedicated settings page. You enable and configure the filter per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

At a glance: enable the **Video Filter** filter on a trusted text format, tick the
providers you want to allow, set a default width/height, and tell your editors to write
`[video:URL]`. The full walkthrough is in [Configuration](configuration/index.md).
