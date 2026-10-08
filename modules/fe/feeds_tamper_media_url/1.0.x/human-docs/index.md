# Feeds Tamper Media URL — manual setup guide

**Feeds Tamper Media URL** (`feeds_tamper_media_url`) provides a
[Tamper](https://www.drupal.org/project/tamper) plugin that creates media entities
from the URL of a file during a Feeds import. When your source gives you a URL that
points at a file (for now, a browser-accessible image), this tamper fetches it and
turns it into a Drupal media entity so the value can populate a media-reference
field.

It's smart about duplicates: when the URL is reachable, it checks whether the file
already exists in the file system. If it doesn't, it creates the file entity and
the media entity; if it does, it reuses the existing media and associates it with
the content being imported. Note that the module currently only supports
browser-accessible images.

A Tamper plugin transforms one source value as it flows through the import, so you
add this plugin to the field that carries the file URL and configure it there — it
has no settings page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Feeds Tamper.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. The media type and file field are chosen per tamper instance on a
Feed type, as described below.

## Where it lives in the admin menu

The plugin adds no admin page of its own. You use it from a Feed type's **Tamper**
tab at **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create a Feed type and map a **media reference** field to the source key that
   holds the file URL.
3. Open the Feed type's **Tamper** tab, and on that source add the **Create Media
   from URL** tamper.
4. Choose the **type of media** to create, and the **File field** on that media
   type where the file should be stored.
5. Create a feed of that type and import. For each reachable URL the tamper creates
   (or reuses) the file and media entity and links it to the imported content.
