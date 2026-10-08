# Spotify Now Playing — manual setup guide

**Spotify Now Playing** (`spotify_playing`) shows the track currently playing on
your Spotify account, live on your website. It offers two ways to use that data: a
ready‑made **block** that auto‑updates with the current song and can be placed in
any region, and a **JSON endpoint** (cached through Drupal) that returns the
currently playing song so you can build your own widget on top of it.

The module is self‑contained — it bundles the Spotify API wrappers it needs, so
there is nothing extra to install for the API side. What it does need is a small
bit of setup: you register a Spotify app on the Spotify Developer site to get a
**Client ID** and **Client Secret**, paste those into the module's settings, and
copy the **Redirect URI** the settings page gives you back into your Spotify app.
Until that connection is made, there is nothing for the block or endpoint to show.

It runs on Drupal 11 and provides its own permissions. A couple of things worth
keeping in mind: the module authenticates to Spotify with OAuth credentials and
tokens — treat those as secrets (store them in an environment variable or Key
entity, over HTTPS) — and if you expose the JSON endpoint publicly, remember it
reveals what you are listening to, so only surface what you intend to.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.
2. [Configuration](configuration/index.md) — create a Spotify app and connect your
   Client ID, Client Secret and Redirect URI.

## How to use it

- **Block:** place the **Spotify Now Playing** block in a region via **Structure →
  Block layout**. It auto‑updates with the currently playing song.
- **JSON endpoint:** point your own front‑end code at the module's JSON endpoint,
  which returns the currently playing track (cached through Drupal).
