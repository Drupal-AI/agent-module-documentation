# Plyr — manual setup guide

**Plyr** (`plyr`) plays video and audio through the lightweight, good‑looking
[Plyr](https://plyr.io) JavaScript player instead of Drupal's default oEmbed iframe or the
browser's bare `<video>`/`<audio>` controls. It does this entirely through **field
formatters**, so there is nothing to place and no block to configure — you just choose a Plyr
formatter on a field's display and the player takes over.

The module ships three formatters. **Plyr remote video** renders a core *Remote video*
(oEmbed) field — restricted to YouTube and Vimeo — through Plyr. **Plyr file video** and
**Plyr file audio** render local video and audio `file` fields. Each formatter has its own
options: autoplay, loop, reset‑on‑end, auto‑hiding controls, a checklist of which control
buttons to show (play, progress, current time, mute, volume, settings, fullscreen, and more),
and a YouTube "no‑cookie" privacy option.

Plyr's own JavaScript and CSS (version 3.7.8) load from the public **cdn.plyr.io** CDN, so
there is no library to download or place on disk. The module depends on core's **Media**
module. There is a `plyr.settings` admin route, but its form is empty — all real
configuration lives on the formatters, per field, at *Manage display*.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Plyr is configured per field, on the entity's **Manage display** tab
(`/admin/structure/.../display`) — for example the *Manage display* screen of your Remote
video media type, or a content type that has an audio/video file field.

1. Find the field you want to play with Plyr and, in the **Format** column, choose the
   matching Plyr formatter:
   - **Plyr remote video** — for a core *Remote video* (oEmbed) field. Only **YouTube** and
     **Vimeo** URLs are played; other providers are skipped.
   - **Plyr file video** — for a local video `file` field.
   - **Plyr file audio** — for a local audio `file` field.
2. Click the **cog** (⚙) next to the formatter to open its settings, then set:
   - **Autoplay** (often blocked by browsers), **Loop**, **Reset on end**, and
     **Hide controls** (auto‑hide after a couple of seconds).
   - The **controls** checklist — tick exactly the buttons you want (play, progress, current
     time, mute, volume, settings, fullscreen, captions, restart, rewind, fast‑forward,
     picture‑in‑picture, AirPlay, and a large centre play button).
   - **YouTube no‑cookie** — use the privacy‑friendly `youtube-nocookie.com` domain.
3. Click **Update**, then **Save**. Reload a page that shows the field and the Plyr player
   appears.

The same field can use different control sets in different view modes — just repeat the steps
on each view mode's *Manage display*.
