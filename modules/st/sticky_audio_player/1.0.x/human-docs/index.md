# Sticky Audio Player — manual setup guide

**Sticky Audio Player** (`sticky_audio_player`) is a field formatter that adds a
"Listen to Article" button to your content. When a visitor clicks it, a modern
audio player slides in from the bottom of the screen — much like Spotify's web
player — and stays fixed there while they keep reading and browsing, so audio
plays continuously without interrupting the page.

It solves a specific presentation need: letting people listen to an audio version
of a page (a narrated article, a podcast episode) while they scroll, rather than
being pinned to a player that scrolls away. The sticky player comes with full
playback controls — play/pause, a seek bar, time display, a playback-speed control,
and a close button — and it is responsive.

The formatter works on an **entity reference field that points to Media entities
containing audio files**. It depends on core's File and Media modules and requires
Drupal 11.2 or newer (this is version 1.0.0). Audio played through it follows
Drupal's normal file and field access — the module adds no access control of its
own.

> **This module has no settings page.** Like any field formatter, you configure it
> on the content type's **Manage display** screen, not through a dedicated admin
> form. See "How to set it up" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Composer command and enabling the
   module.

## How to set it up

After enabling the module, turn it on for a field by choosing it as that field's
display format:

1. Make sure the content type has an **entity reference field targeting Media
   entities** that contain audio files. You manage fields at, for example,
   `/admin/structure/types/manage/article/fields`.
2. Go to that content type's **Manage display** screen — for example
   `/admin/structure/types/manage/article/display`.
3. Find your audio field in the list and change its **Format** dropdown to
   **Sticky Audio Player**.
4. Click the format's settings gear to **customise** the player options, then
   save.
5. Save the Manage display form.

From then on, that field renders as the "Listen to Article" button, and clicking it
brings up the sticky player at the bottom of the viewport.
