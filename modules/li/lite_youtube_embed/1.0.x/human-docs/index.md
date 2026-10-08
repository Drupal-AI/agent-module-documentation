# Lite YouTube embed — manual setup guide

**Lite YouTube embed** (`lite_youtube_embed`) is a small performance module that
changes how YouTube videos are rendered on your site. Out of the box, Drupal
embeds a Remote video by dropping the full YouTube player iframe straight into
the page — a heavy chunk of third‑party JavaScript, cookies, and network
requests that loads whether or not the visitor ever presses play. This module
replaces that with Paul Irish's lightweight `lite-youtube` web component: a
"facade" that shows just a thumbnail and a play button, and only loads the real
YouTube player the moment someone clicks it.

The result is faster pages (better Core Web Vitals such as LCP and Total
Blocking Time), fewer third‑party requests on the initial load, and a more
privacy‑friendly first impression — no YouTube iframe or cookies until the
visitor actually interacts. Editors keep exactly the same media workflow; only
the front‑end output changes.

Technically, the module adds one **field formatter**, *"Lite YouTube embed
(with oEmbed fallback)"*, which you select on a media type's *Manage display*
page. It only applies to **media** entities whose source is an **oEmbed** source
(the standard *Remote video* type is the common case). When the video is a
YouTube URL it renders the lightweight component; for any other provider (Vimeo
and friends) it automatically falls back to Drupal's normal oEmbed iframe, so a
mixed remote‑video field keeps working. It depends only on core's **Media**
module.

One important requirement: the `lite-youtube` JavaScript and CSS are **not
bundled** with the module. You must install Paul Irish's library into your
site's `/libraries` directory (see [Installation](installation/index.md)) or the
component will not become interactive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the required `lite-youtube` library.

## Where it lives in the admin menu

There is no dedicated settings page — the module has no configuration route of
its own. You turn it on where display formatters are chosen: on a media type's
**Manage display** tab, for example **Structure → Media types → Remote video →
Manage display** (`/admin/structure/media/manage/remote_video/display`).

## How to use it

1. Make sure the required `lite-youtube` library is installed (see the
   [Installation](installation/index.md) page) — without it the facade renders
   but never upgrades into a working player.
2. Go to your media type's *Manage display*, e.g. **Structure → Media types →
   Remote video → Manage display**.
3. For the oEmbed video field (on Remote video this is
   `field_media_oembed_video`), open the **Format** dropdown and choose
   **"Lite YouTube embed (with oEmbed fallback)"**.
4. Optionally set a **Maximum width** and **Maximum height**. Note these apply
   only to the non‑YouTube fallback (the plain oEmbed iframe) — they are ignored
   for YouTube videos, which are sized by the web component itself.
5. Click **Save**.

You can set this per view mode, so you might use the lite formatter on the full
display but a different one on teasers. From then on, YouTube videos on that
display render as a fast click‑to‑load facade, while Vimeo and other providers
continue to use the standard iframe.
