# Media Entity Calaméo — manual setup guide

**Media Entity Calaméo** (`media_entity_calameo`) adds a media source for
[Calaméo](https://www.calameo.com/), the online document and publication
platform. With it enabled, a Calaméo publication can be stored as a Drupal media
entity and embedded on your pages as a flipbook viewer, so publications live in
the media library and can be referenced and reused like any other media. It
depends only on Drupal core's Media module and runs on Drupal 9.3, 10, and 11.

Calaméo integration works a little differently from a plain oEmbed source: the
module talks to Calaméo's API, so you enter a Calaméo **API key** and **API
secret key** once, then set up a media type that uses the Calaméo source. From
then on editors add publications by their Calaméo reference and the module renders
the flipbook.

Keep in mind that the publication itself is hosted by Calaméo and embedded from
their servers. That means the viewer loads third‑party content in your visitors'
browsers, so it is an egress and privacy consideration in the same way any
embedded external widget is — Calaméo sees the visitors who load the flipbook.
Media access follows Drupal's normal media and file access; the module adds its
own permissions but no special access‑control role beyond them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

There is no standalone settings page linked from the admin menu for this module.
Setup is a matter of entering your Calaméo API credentials and creating a media
type that uses the Calaméo source, both described below.

## Where it lives in the admin menu

The Calaméo API credentials form is at
`/admin/config/media/media_entity_calameo`. The media types you create with the
Calaméo source appear under **Structure → Media types**
(`/admin/structure/media`), and individual publications are managed from
**Content → Media** (`/admin/content/media`).

## How to use it

1. **Enter your Calaméo API credentials.** Go to
   `/admin/config/media/media_entity_calameo` and fill in your Calaméo **API
   Key** and **API Secret Key** (you get these from your Calaméo account). Treat
   the secret key as a credential — do not share it or paste it anywhere public.
2. **Create a media type that uses the Calaméo source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), give it a name
   such as "Calaméo publication," and in the **Media source** field choose
   **Calaméo**. Save.
3. **Set up the display.** On that media type's **Manage display** tab, set the
   source field's **Format** to **Calaméo embed**, then click the format's
   settings gear to configure the flipbook iframe's width and height. Save.
4. **Add publications.** Editors can now go to **Content → Media → Add media** and
   create Calaméo items, which render as the Calaméo flipbook viewer wherever the
   media is displayed.
