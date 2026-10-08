# Media Remote — manual setup guide

**Media Remote** (`media_remote`) turns a plain remote URL into a proper Drupal
**media item** for services that *don't* support oEmbed. Core's built-in "Remote
video" source only works with the providers listed on oembed.com — YouTube, Vimeo,
and friends. Media Remote covers the long tail: paste a Loom recording, a Google
Doc/Sheet/Slides deck published to the web, a Google My Map, a Box or Dropbox shared
link, a Brightcove or Panopto player, a Matterport 3D tour, an Apple Podcasts
episode, a Microsoft Form, an ArcGIS app, and more — around 20 providers in all — and
it becomes a structured, reusable, revisionable media entity instead of raw `<iframe>`
markup pasted into a body field.

It works through two pieces: one media **source** ("Remote Media URL") that stores the
URL in a plain text field, and a set of provider-specific **display formatters** that
turn that URL into the right embed. The clever part is that **you choose the provider
by picking its formatter on the media type's display** — that single choice also
drives URL validation (so an editor who pastes a Loom link into a Google Drive type
gets a helpful "valid URLs look like …" error) and auto-names new items from the URL.
Editors can add remote media straight from the Media Library modal by pasting a link.

Because the provider is selected via the display, there's a specific setup order to
follow — the module even nudges you to the display screen right after you create a
type. It depends on core's **Media** and **Media Library** modules, and has no
settings form or permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including all 20 formatter
IDs and their URL patterns — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — creating a Remote Media type, choosing
   the provider formatter, and adding remote media items.

## Where it lives in the admin menu

There's no dedicated settings page. You work on the standard media screens:

- **Structure → Media types → Add media type** (`/admin/structure/media/add`) —
  create a type using the "Remote Media URL" source.
- The type's **Manage display** tab — pick the provider formatter and set the iframe
  size.
- **Content → Media → Add media** (`/media/add/<type>`) — add an item by pasting a
  URL.

## How to use it

The short version: create a media type using the **Remote Media URL** source, then —
importantly — go to that type's **Manage display** and set the source field's format
to the provider you want (e.g. *Remote Media - Loom*). After that, add media items by
pasting a URL, which is validated against that provider. The full walkthrough is in
[Configuration](configuration/index.md).
