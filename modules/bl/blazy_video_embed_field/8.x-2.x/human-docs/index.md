# Blazy Video Embed Field — manual setup guide

**Blazy Video Embed Field** (`blazy_video_embed_field`) is a thin bridge between two
other contrib modules: [Video Embed Field](https://www.drupal.org/project/video_embed_field)
and [Blazy](https://www.drupal.org/project/blazy). It gives your embedded videos
Blazy's lazy-loading and display handling by adding Blazy-powered **field
formatters** you can choose on a Video Embed field's display settings.

Reach for it when you already use Video Embed Field and want Blazy to lazy-load the
video thumbnails and players — deferring off-screen video so a video-heavy page
loads lighter and feels faster. It reuses Blazy's responsive/display features for
video, rather than reinventing them.

The module is purely a set of field-formatter plugins. It adds no routes, no
permissions, and no settings page of its own — everything is configured on the
field's **Manage display** screen, and it works with your existing Video Embed
Field data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its two required
   dependencies, then enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You use the module on a view mode's
**Manage display** screen for any entity that has a Video Embed field — for example
**Structure → Content types → [type] → Manage display**.

## How to use it

1. Make sure you already have a **Video Embed field** on a content type (or other
   fieldable entity).
2. Go to that bundle's **Manage display** screen.
3. For the Video Embed field, choose the **Blazy-based formatter** (the Blazy video
   player / Blazy display) from the format dropdown.
4. Save.

The field now renders through Blazy, so the video's thumbnail and player are
lazy-loaded like Blazy handles images.
