# Audio Player — manual setup guide

**Audio Player** (`audio_player`) is a field formatter that renders audio fields
with a configurable, themeable player — skins, playlists, colour palettes and an
equalizer display. Browsers ship a native audio element, but it looks like a
browser control: functional, largely unstyleable, and different in every browser.
For a music site, a podcast, an oral-history archive or a language-learning
resource, the player is part of the presentation, and a consistent, themeable one
is worth having.

This formatter provides that. It supports **playlists**, so a set of files plays
as a sequence rather than as separate controls, and it exposes visual
configuration — a **skin**, a **colour palette** and an **equalizer** display — so
the player matches the site design. It depends on core's Image, Field and Media
modules.

Two things belong in any audio-player deployment. **Keyboard and screen-reader
access** — custom players routinely lose what the native element gives for free,
so verify that play, pause, seek and volume are reachable by keyboard and
labelled; a visitor who cannot operate the player cannot reach the content, and
audio often has no alternative. And **a transcript is not optional** for
spoken-word audio under most accessibility obligations: the player does not
provide one, so your content model has to — a content-type design decision, not a
retrofit. Practically, audio files are large and served from the site, so plan
hosting for a substantial archive.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Audio Player is a formatter, so there is no central settings page — you configure
it per display:

1. On the entity's **Manage display** tab, find the audio (file/media) field.
2. Choose **Audio Player** as its format.
3. Open the formatter's settings (the gear icon) to pick the skin, colour palette,
   playlist behaviour and equalizer display.
4. Save. The chosen player renders wherever that view mode is shown.

When you design the content type, add a **transcript** field alongside the audio
so spoken-word content has a text alternative from the start.
