# Media Remote Image — manual setup guide

**Media Remote Image** (`media_remote_image`) adds a **media source for oEmbed
image providers**, letting you add remote images from supported providers as Drupal
media — much the way core Media handles oEmbed video. It's a small, focused
extension of the oEmbed support already built into Drupal core's Media module,
implementing `hook_media_source_info_alter()` to register additional image
providers.

Out of the box it enables these oEmbed image providers:

- **Flickr**
- **GIPHY**
- **Getty Images**

The images load from the **remote provider** (a third party), so the usual egress
and privacy considerations for embedding external content apply. Reassuringly,
like core's oEmbed handling, the remote content comes from these
**configured/allow‑listed providers** rather than arbitrary, attacker‑supplied
URLs — which bounds the server‑side‑request surface. The module has no
access‑control role of its own.

It depends on core's **Media** module and supports Drupal 10 and 11. It sits
alongside sibling modules **Media Remote Audio**, **Media Remote Social**, and
**Media Remote Document**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page**. You use it by creating a media type that
uses one of its image sources — described under "How to use it" below.

## Where it lives in the admin menu

The module adds no standalone settings form. You set it up on your media types at
**Structure → Media types** (`/admin/structure/media/types`).

## How to use it

1. After enabling the module, go to **Structure → Media types**
   (`/admin/structure/media/types`) and add a media type.
2. Choose the oEmbed **image source** it registers (Flickr / GIPHY / Getty Images)
   as the media type's source.
3. Create media of that type by pasting a supported provider's image URL; it embeds
   through the standard Media system. Configure its **Manage display** to control
   how the image renders.
