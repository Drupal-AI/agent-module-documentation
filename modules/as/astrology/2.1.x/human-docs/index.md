# Astrology — manual setup guide

**Astrology** (`astrology`) displays horoscope content on your site — daily,
weekly, monthly, and yearly readings by zodiac sign. It is aimed at lifestyle and
entertainment sites that want a horoscope feature without building one from
scratch.

The module surfaces horoscope/zodiac information as content (typically through a
block you place in a region), and it runs on Drupal 10 and 11 with no module
dependencies. If it pulls horoscope data from an external source, that is public
content fetched over HTTPS — the module has no role in access control or private
data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Astrology has no dedicated top‑level admin section. You work with it where you
manage site content and layout — most commonly by placing its horoscope **block**
at **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout**, place the Astrology horoscope block in the
   region where you want horoscopes to appear, and configure the block's
   visibility as you would any other block.
3. The block then shows the daily / weekly / monthly / yearly horoscope content to
   visitors.

The specific display options depend on the release you install; the sibling
[`agent/`](../agent/start.md) docs track the machine‑level detail.
