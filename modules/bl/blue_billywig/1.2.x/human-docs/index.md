# Blue Billywig — manual setup guide

**Blue Billywig** (`blue_billywig`) connects Drupal's core Media system to the
[Blue Billywig](https://www.bluebillywig.com/) online video platform (OVP). Once
it's set up, your editors can browse and import videos that already live on the
platform, upload brand‑new videos straight from the browser, and embed any of
them on the front end through a configurable Blue Billywig "playout" (the
platform's word for a player skin/config). Adaptive streaming, monetization, and
delivery are all handled by Blue Billywig — Drupal just references the clips and
renders the embeds.

Under the hood the module adds a **Blue Billywig media source** so you can create
a media type whose items point at clips on the platform. It talks to Blue
Billywig through the `bluebillywig/bb-sapi-php-sdk` Composer library, so that
library is a hard requirement, and it depends on core's **Media** module (the
**Media Library** submodule is strongly recommended for the import/upload
experience). Large uploads (up to roughly 20 GB) go directly from the browser to
the platform's S3 storage using the bundled Uppy widget, so they never pass
through your web server — as long as you've entered API credentials. Without
credentials, uploads fall back to an ordinary Drupal file upload.

Nothing works until you configure the connection: the module needs your Blue
Billywig **publication subdomain**, an **API key ID and secret**, and (usually) a
**default playout** before it can search, import, upload, or embed anything. Those
live on a global settings form, and two optional per‑video workflows — requesting
Scribit.Pro accessibility assets and assigning a content‑protection policy — can
be toggled on or off there too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the full
`blue_billywig.client` service API — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — require the Composer package (it pulls
   in the Blue Billywig PHP SDK), enable the module, and confirm Media is on.
2. [Configuration](configuration/index.md) — the global connection settings form
   field by field, plus how to build the media type, reference field, and embed
   formatter, and the two per‑video workflows.

## Where it lives in the admin menu

The global settings form sits at **Configuration → Media → Blue Billywig
settings** (`/admin/config/media/blue-billywig`) and is gated by the *Administer
Blue Billywig* permission (`administer blue_billywig`). The media type you create
lives under **Structure → Media types**, and per‑video accessibility and
content‑protection forms are reached from each individual media item.

## How to use it

At a high level the flow is: install and enable the module, enter your platform
credentials on the settings form, create a media type that uses the Blue Billywig
source, then add a Media reference field to your content and pick the **Media
library** widget. From there, editors click *Add media* to search the platform
and import a clip, or upload a new one. On the media type's **Manage display**
tab, set the source field's formatter to **Blue Billywig embed code** and choose a
playout so the video renders on the front end. The step‑by‑step version of all of
this is in [Configuration](configuration/index.md).
