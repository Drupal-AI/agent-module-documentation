# Iframe Media Embed Video — manual setup guide

**Iframe Media Embed Video** (`iframe_video`) lets editors embed remote videos
from providers that **don't** have an oEmbed provider. Drupal core's remote‑video
media source relies on oEmbed, which only covers certain platforms; this module
fills the gap by storing an **iframe embed** as a core media source, so a video
from an unsupported platform can still be added as a Media entity and reused
through the Media Library.

Under the hood it adds a new media **source type** for iframe‑based video. You
create a media type that uses it, and from then on editors add these videos just
like any other media — including from the Media Library. It depends on core
**Media** and **Media Library**, and on the contributed **Iframe** field module.

A word of caution, because this renders an **iframe to a remote source**: an
iframe embeds third‑party content directly into your page's context, so keep
control over which URLs and domains can be embedded. Restrict embedding to
**trusted editors**, and ideally maintain an **allow‑list of trusted video
domains** — an unrestricted iframe embed of an arbitrary URL is a
clickjacking/malicious‑content vector. The module itself has no access‑control
role beyond this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no central settings form** — you set it up by creating a media
type that uses its source, described below.

## Where it lives in the admin menu

Iframe Media Embed Video adds no single settings page. You use it from **Structure
→ Media types**, by creating (or editing) a media type whose media source is the
iframe video source this module provides. After that, videos are added and reused
through the usual **Media Library**.

## How to use it

1. Go to **Structure → Media types → Add media type**.
2. Choose the **iframe video** media source provided by this module, and save the
   type.
3. Add media of that type — pasting the iframe/video URL — and reuse it anywhere
   via the Media Library.

> **Security tip:** grant the ability to add these embeds only to editors you
> trust, and keep to an allow‑list of known‑good video domains.
