# ReplayWeb.page — manual setup guide

**ReplayWeb.page** (`replaywebpage`) lets your Drupal site **play back web
archive files** — WARC and WACZ captures of web pages — directly in the browser,
using the [ReplayWeb.page](https://replayweb.page) viewer. It adds a **"Web
Archive" media type** and a **field formatter** that renders the uploaded archive
in the ReplayWeb.page player, so archived web content stored as media can be
browsed and replayed on your site.

It depends on core's **Media** module and sits in the *Custom* package. One hard
requirement to note up front: your site should be served over **HTTPS**, because
ReplayWeb.page relies on a service worker, which browsers only allow on secure
origins.

A word on trust: replaying a web archive means embedding what is essentially
**third‑party content** that you may not control. ReplayWeb.page sandboxes the
replay (it renders the archive in an isolated context via the service worker),
but you should still treat the archives you host the way you would any embedded
external content — host archives you trust, and understand that a replayed page
can contain its own scripts running inside that sandbox. The module has no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and core Media.

There is **no central settings form** for this module. Setup happens on the Web
Archive media type's *Manage display* and on a media reference field, described
below.

## Where it lives in the admin menu

ReplayWeb.page adds no dedicated configuration page. You work with it through the
standard Media administration screens: **Structure → Media types → Web Archive**
(and its *Manage display* tab) for the formatter, and **Content → Media** for
adding archive files.

## How to use it

Setting up playback is a three-part process — configure the display, add the
archive, and attach it to content:

1. **Set the formatter.** Go to **Structure → Media types → Web Archive → Manage
   display** and set the file field's display to the **ReplayWebPage** formatter.
2. **Allow the media type on your content.** Add or edit a media reference field
   on a content type and enable **Web Archive** as an allowed reference type.
3. **Add an archive.** Go to **Content → Media**, create a **Web Archive** media
   item, upload your WARC/WACZ file, and set its **Base URL** if applicable.
4. **Attach it to content.** Reference the Web Archive media from a node (or other
   content) via the media field you configured. The archive now replays in the
   ReplayWeb.page viewer when the content is displayed.
