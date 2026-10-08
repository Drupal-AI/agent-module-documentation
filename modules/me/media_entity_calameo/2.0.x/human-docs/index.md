# Media Entity Calaméo — manual setup guide

**Media Entity Calaméo** (`media_entity_calameo`) adds a media source for
[Calaméo](https://www.calameo.com/), the online document and publication
platform. With it enabled, a Calaméo publication can be stored as a Drupal media
entity and embedded on your pages as a flipbook viewer, so publications live in
the media library and can be referenced and reused like any other media. It
depends only on Drupal core's Media module and, in this **2.0.x** release, runs
on Drupal 10.6 and 11.

Calaméo integration works a little differently from a plain oEmbed source: the
module talks to Calaméo's API, so you enter a Calaméo **API key** and **API
secret key** once, then set up a media type that uses the Calaméo source. From
then on editors add publications by their Calaméo ID (shortcode) or a full
`calameo.com/read/…` URL, and the module fetches the publication's details and
renders the flipbook.

> **Upgrading from 1.0.x?** This is a major release. It drops Drupal 9 and
> Drupal 10 releases older than 10.6, and the Calaméo **API key and secret are
> now required** — until you enter them on the settings page the module reports a
> configuration error and cannot load publication data.

Keep in mind that the publication itself is hosted by Calaméo and embedded from
their servers. That means the viewer loads third‑party content in your visitors'
browsers, so it is an egress and privacy consideration in the same way any
embedded external widget is — Calaméo sees the visitors who load the flipbook.
The publication's cover thumbnail is downloaded and stored in your site's public
files. Media access follows Drupal's normal media and file access; the module
adds its own permission (`administer media_entity_calameo settings`) but no
special access‑control role beyond it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

## Where it lives in the admin menu

The Calaméo settings form (API credentials plus global display options) is at
`/admin/config/media/media_entity_calameo`, linked under **Configuration →
Media**. The media types you create with the Calaméo source appear under
**Structure → Media types** (`/admin/structure/media`), and individual
publications are managed from **Content → Media** (`/admin/content/media`).

## How to use it

1. **Enter your Calaméo API credentials.** Go to
   `/admin/config/media/media_entity_calameo` and fill in your Calaméo **API
   Key** and **API Secret Key** (you get these from your Calaméo Developers & API
   page). Both are required. Treat the secret key as a credential — do not share
   it or paste it anywhere public. On this page you can also set global default
   display **mode** and **view** options and a **Force domain** toggle for sites
   that hit X‑Frame embed errors.
2. **Create a media type that uses the Calaméo source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), give it a name
   such as "Calaméo publication," and in the **Media source** field choose
   **Calaméo**. Save.
3. **Set up the display.** On that media type's **Manage display** tab, set the
   source field's **Format** to **Calaméo embed**, then click the format's
   settings gear to configure the flipbook iframe's display mode, view, width,
   and height. Save.
4. **Add publications.** Editors can now go to **Content → Media → Add media** (or
   use the Media Library) and create Calaméo items by entering a Calaméo ID or a
   full Calaméo URL. The module fetches the publication details and renders the
   Calaméo flipbook viewer wherever the media is displayed.
