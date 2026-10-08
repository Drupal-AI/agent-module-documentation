# Image Media Migrate — manual setup guide

**Image Media Migrate** (`image_media_migrate`) is a developer/admin tool for
modernising content: it converts values from a plain **image field** into **Media
(image)** entities and references, so your content uses the media library instead of
bare image fields. It provides a straightforward configuration form and a **batch
process** that can chew through large numbers of nodes safely.

It is flexible about the direction of migration — within the same node it can move
values **image → media, media → media, image → image, or media → image** — which
makes it handy not only for a one‑time "adopt Media" conversion but also for
reshuffling fields during a content restructure. It depends on core **Media** and
**Image**.

Two things to keep in mind. It currently supports **node entities only** — taxonomy
terms, users and other entity types are not handled. And, as with any content
migration, it transforms existing content, so **back up first** and test on a copy.
It follows core media/file access and has no access‑control role of its own. (This
release is minimally maintained and not covered by Drupal's security advisory
policy.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media/Image dependencies.

The module's form is an **operational batch form**, not a settings page — its use is
described in "How to use it" below.

## Where it lives in the admin menu

The migration form is at **Administration → Configuration → Media → Media Migrate**.

## How to use it

1. **Back up your database and files** before running any migration.
2. Enable the module (see [Installation](installation/index.md)).
3. Go to **Configuration → Media → Media Migrate**.
4. Select the **content type**, the **source field** and the **destination field**.
   The module validates your choices automatically to make sure the source and
   destination are compatible.
5. Click **Run batch** to start the migration. The batch processor works through the
   nodes, moving each node's image/media values from the source field into the
   destination field.
6. When it finishes, spot‑check some converted nodes to confirm the images now come
   through the destination (media) field as expected.

Remember: only **nodes** are processed — content on other entity types is left
untouched.
