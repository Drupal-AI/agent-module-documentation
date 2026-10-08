# Media Kinescope — manual setup guide

**Media Kinescope** (`media_kinescope`) integrates the
[Kinescope.io](https://kinescope.io) video platform with Drupal so you can add
Kinescope‑hosted videos to your content. It adds a **"Kinescope Video URL"** field
that you can attach to any entity type, then displays that video in an iframe
player.

The module provides three pieces that work together:

- a **"Kinescope Video URL"** field for storing the video's URL,
- a **"Kinescope video" field widget** that renders the Kinescope player in an
  iframe, and
- a **field formatter** for outputting the player when the entity is displayed,
- plus a `media_kinescope.popup` JavaScript library that can open the player iframe
  inside a Drupal dialog when a button is clicked.

It's a media‑integration feature: the video content is loaded from Kinescope's own
servers, and the module plays no part in access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings form** for this module — you set it up per field, on
the entity you want to hold the video, as described below.

## Where it lives in the admin menu

The module adds no dedicated admin page. You configure it through the Field UI on
whatever entity should carry a video: **Structure → *(entity type)* → *(bundle)* →
Manage fields / Manage form display / Manage display**.

## How to use it

1. Go to the bundle you want to add a video to (a content type, paragraph, etc.)
   and, under **Manage fields**, add a **Kinescope Video URL** field.
2. On **Manage form display**, set that field's widget to **Kinescope video** so
   editors get the iframe player when entering content.
3. On **Manage display**, choose the Kinescope field formatter to render the player
   on the front end.
4. Editors then paste the Kinescope video URL into the field, and the player is
   embedded when the content is viewed. To show the player in a modal dialog on
   button click, attach the `media_kinescope.popup` library.
