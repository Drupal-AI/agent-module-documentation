# Media Ubicast — manual setup guide

**Media Ubicast** (`media_ubicast`) connects Drupal's core Media system to
[Ubicast](https://www.ubicast.eu/), an enterprise video platform. It adds a
**media source** for Ubicast videos and a **field formatter** that embeds those
videos on your site through an iframe player. Editors add an Ubicast video the
same way they add any other media item — through the Media Library — and it renders
with the Ubicast player, while the actual video hosting and streaming stay on
Ubicast's servers.

The typical reason to use it is to keep video off your own infrastructure: your
organisation already stores and manages its videos in Ubicast, and this module
lets you reference and display them in Drupal without downloading or re-hosting
the files. It depends only on core **Media** and supports Drupal 10 and 11.

There is no site-wide settings form for this module. Setup is a one-time
structural step — creating a media type that uses the Ubicast source — after which
editors simply add videos. That step is described under "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Media.

There is **no module configuration page** — Media Ubicast has no global settings
form. The one-time setup happens on a media type and on your display settings,
described in "How to use it" below.

## Where it lives in the admin menu

Media Ubicast adds no settings page of its own. You work with it through core's
media administration:

- **Media types** at **Structure → Media types**
  (`/admin/structure/media/manage`) — where you create a type that uses the
  Ubicast media source.
- **Media Library / Content → Media** (`/admin/content/media`) — where editors add
  and manage individual Ubicast videos.

## How to use it

1. Go to **Structure → Media types → Add media type**.
2. Give the type a name (for example "Ubicast video") and choose **Ubicast** as
   the **Media source**. Save.
3. On the new type's **Manage display**, confirm the Ubicast field formatter is
   used so the video renders through the Ubicast iframe player.
4. Editors can now add Ubicast videos via **Content → Media → Add media** (or
   through the Media Library when inserting media into content), and the videos
   play back using the Ubicast player embedded in the page.

Because the video is embedded from Ubicast, the player is a third‑party request:
each view loads resources from Ubicast and reports playback to it, so treat it as
you would any external embed with regard to consent and privacy.
