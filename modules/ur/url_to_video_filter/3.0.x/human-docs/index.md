# URL To Video Filter — manual setup guide

**URL To Video Filter** (`url_to_video_filter`) is a text filter that turns a bare
YouTube or Vimeo URL, pasted on its own line in body text, into an embedded,
responsive video player. There's no CKEditor plugin to learn and no media entity
to create — editors simply paste a link and the rendered page shows the video.

Because it's a text filter, nothing changes in the stored content: the body still
holds a plain URL, and the embed only appears when the text is rendered. Turn the
filter off and the content reverts to a plain link. You decide which text formats
get the behaviour, and whether YouTube, Vimeo, or both are recognised.

It also has a privacy‑friendly option: instead of loading the third‑party player
immediately, it can show a lightweight WebP preview image and only load the player
(and its cookies/requests) once the visitor clicks — handy for cookie‑consent
compliance and for pages with many videos.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The filter has no settings page of its own — it's configured **per text format**.

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the format you want (for example
   *Basic HTML* or *Full HTML*).
2. In the **Enabled filters** list, tick **Convert URLs to embedded videos**.
3. In that filter's settings below the list, choose the options:
   - **YouTube** — recognise YouTube URLs.
   - **Vimeo** — recognise Vimeo URLs.
   - **YouTube WebP preview** — show a WebP preview image and defer loading the
     player until the visitor clicks, rather than loading it on page view.
4. Mind the **filter order** — like any embedding filter, it should generally run
   before "Convert line breaks" and after tag‑limiting filters so the URL is intact
   when it runs. **Save configuration**.

Once enabled on a format, editors just paste a video URL on its own line into any
field that uses that format, and the rendered output contains the player. The
module ships its own CSS for a responsive wrapper and a fallback image for
browsers without JavaScript.

> **Heads up on defaults:** when you configure the filter through the UI it starts
> with YouTube and Vimeo *on* and the WebP preview *off*. A format configured
> programmatically without explicit settings gets **neither** provider — so set
> them explicitly if you script it.

## Where it lives in the admin menu

There is no dedicated settings page. The filter is turned on and configured on
each text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).
