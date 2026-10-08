# RumbleTalk — manual setup guide

**RumbleTalk** (project `rumbletalk`, module machine name `rumbletalk_chat`) embeds a
[RumbleTalk](https://rumbletalk.com/) group chat room on your site. RumbleTalk is a
hosted, HTML5 group‑chat service; this module places that chat on a Drupal page using
a **block**, so visitors can chat in real time — as a members‑only room or an open
social chat, which makes it a fit for live events and community pages.

You create and style the chat room on RumbleTalk's side (they offer ready‑made themes
and let you build your own), and each room has an identifier — a chat **hash/ID** —
that you paste into the block so Drupal knows which room to show. The module does the
embedding; RumbleTalk does the chatting.

**A couple of things to be aware of.** This is a third‑party integration: the chat
runs on RumbleTalk's servers, and the module loads **RumbleTalk's own JavaScript**
into your pages (it runs in your site's origin, so you're trusting the vendor's
script). Chat messages and participant data are handled by RumbleTalk, not stored in
your Drupal database — a privacy and consent consideration you may need to disclose to
visitors. The module has no access‑control role of its own; who can *see* the chat is
governed by where you place the block and its visibility settings, while who can
*post* is governed by your RumbleTalk room settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the chat block and enter your
   RumbleTalk chat ID.

## Where it lives in the admin menu

RumbleTalk adds no standalone settings page. You configure it entirely through
**Structure → Block layout**, by placing the RumbleTalk chat block and entering your
chat ID in the block's settings. See [Configuration](configuration/index.md).
