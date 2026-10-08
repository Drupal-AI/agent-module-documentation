# Remote Document — manual setup guide

**Remote Document** (`media_remote_document`) adds a **media source for oEmbed
document providers**, so editors can add remotely‑hosted documents as media
entities simply by pasting their oEmbed URL. It's a small, focused extension of the
oEmbed support already built into Drupal core's Media module: it implements
`hook_media_source_info_alter()` to register additional document providers, so
remote documents can be embedded consistently through the standard Media system.

Out of the box it enables these oEmbed document providers:

- **Figma**
- **Canva**

Because the documents are hosted remotely and embedded via oEmbed, the content is
fetched from and rendered by the third‑party provider — it loads from the
provider's servers rather than being stored on your site. That means your visitors'
browsers (and, when resolving oEmbed, your server) reach out to those providers, so
consider the usual egress and privacy implications of embedding third‑party
content. As with core oEmbed, the providers are a defined allow‑list rather than
arbitrary URLs.

It depends on core's **Media** module and supports Drupal 10 and 11. It sits
alongside sibling modules **Media Remote Audio**, **Media Remote Social**, and
**Media Remote Image**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page**. You use it by creating a media type that
uses one of its document sources — described under "How to use it" below.

## Where it lives in the admin menu

The module adds no standalone settings form. You set it up on your media types at
**Structure → Media types** (`/admin/structure/media/types`).

## How to use it

1. After enabling the module, go to **Structure → Media types**
   (`/admin/structure/media/types`) and add a media type.
2. Choose the oEmbed **document source** it registers (Figma / Canva) as the media
   type's source.
3. Create media of that type by pasting a supported document's oEmbed URL; the
   document embeds through the standard Media system. Configure its **Manage
   display** to control how the embed renders.
