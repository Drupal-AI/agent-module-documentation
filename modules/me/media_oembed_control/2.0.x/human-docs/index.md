# Media oEmbed Control — manual setup guide

**Media oEmbed Control** (`media_oembed_control`) adds two playback options —
**Autoplay video** and **Embed as background video** — to Drupal core's oEmbed
field formatter, for **YouTube** and **Vimeo** embeds. Core Media can display a
remote video by rendering a sandboxed iframe, but it gives you no control over how
that video plays. This module fills that gap with two checkboxes on the
formatter's settings, so you can autoplay a clip on a specific display or run one
as a silent, looping background video (for a hero banner, say).

It works by adding two per‑display settings to the core `oembed` formatter. When
a field with those settings is rendered, the module rewrites the embedded iframe
URL to add the right provider parameters — for example forcing YouTube autoplay to
be muted (so browsers allow it), or setting a Vimeo/YouTube background to loop
silently with controls hidden. Importantly, it keeps core Media's signed‑iframe
security intact: the module's controller still runs core's hash check before
rewriting anything.

There is **no admin settings page, no permission, and no global configuration** —
everything is configured on a field's **Manage display**, per view mode. Only
YouTube and Vimeo are affected; any other oEmbed provider is rendered exactly as
core does.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (core Media is required).
2. [Configuration](configuration/index.md) — the two formatter checkboxes and how
   they change the embed.

## Where it lives in the admin menu

The module has no page of its own. You use it on a media (or entity) field that
uses the core **oEmbed** formatter, at **Manage display** for the relevant view
mode — for a media type that would be under **Structure → Media types → … →
Manage display**.
