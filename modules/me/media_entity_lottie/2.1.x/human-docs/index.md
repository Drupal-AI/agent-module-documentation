# Media entity Lottie — manual setup guide

**Media entity Lottie** (`media_entity_lottie`) lets Drupal's Media system store
and play [Lottie](https://lottiefiles.com/) animations — the lightweight
JSON‑based vector animations designers export from After Effects and similar
tools. It adds a new **Lottie file** media source so you can create a media type
that accepts `.json` animation files, and a matching **Lottie player** field
formatter that renders each animation using the LottieFiles `<lottie-player>`
web component.

Once you have a Lottie media type, editors upload animations through the normal
Media library, reuse them across the site by reference, and you control how each
one plays — looping, hover‑to‑play, playback speed, background transparency,
bounce mode, and a "play only when it scrolls into view" option. On upload the
module validates that the file really is a valid Lottie animation (non‑empty,
valid JSON, and containing the keys a Lottie file must have), and it can expose
the animation's metadata — width, height, name, version, frame rate — as media
fields.

There is no dedicated settings form for the module itself (`configure: null`).
Everything is configured through the standard Media UI: create a media type that
uses the Lottie source, then set that type's display to use the Lottie player.
One thing worth knowing up front — the player's JavaScript is loaded from a
remote CDN (unpkg), so the animations need outbound network access, or you can
override the libraries with a local copy on a locked‑down site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create a Lottie media type, wire up
   its display, and tune the player's settings field by field.

## Where it lives in the admin menu

The module adds no top‑level admin page of its own. You work with it through the
existing Media administration:

- **Structure → Media types** (`/admin/structure/media`) — where you create the
  Lottie media type and manage its fields and display.
- The **Media library** — where editors upload and reuse the animations once the
  type exists.
