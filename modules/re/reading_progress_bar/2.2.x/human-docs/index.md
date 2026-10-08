# Reading Progress Bar — manual setup guide

**Reading Progress Bar** (`reading_progress_bar`) displays a thin horizontal bar
at the top of the page that fills up as the visitor scrolls through the content —
a "reading position indicator." On long articles, tutorials, and documentation,
it gives readers a sense of how much remains, which is why it has become a common
touch on content-heavy sites.

It is delivered as a **block**: you place the "Reading Progress Bar block" in a
region (usually the very top of the page), and its lightweight JavaScript measures
how far you have scrolled through the document — or through a specific container
you nominate — and grows a coloured bar accordingly. It handles dynamic content
with varying heights, can hide itself on short pages where a progress bar would be
pointless, and can auto-hide after scrolling pauses. For developers, it also
dispatches custom JavaScript events exposing the reading progress as a percentage,
so you can react to scroll behavior programmatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — place the block and tune its
   appearance and behavior, field by field.

## Where it lives in the admin menu

Reading Progress Bar adds no dedicated settings page. Everything is configured on
the block itself, which you place and edit from **Structure → Block layout**
(`/admin/structure/block`). It adds no custom permissions or routes of its own.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. At **Structure → Block layout**, add the **Reading Progress Bar block** to the
   region where you want it — typically the very top of the page or the header.
3. Configure the block's appearance and behavior (see
   [Configuration](configuration/index.md)), then save.
4. Clear caches and view a long page to see the bar fill as you scroll.

> **Tip:** because the bar renders fixed at the very top of the viewport, it can
> end up behind the admin toolbar for logged-in administrators. Check its
> appearance as an anonymous user (or in a private/incognito window) to see what
> visitors actually get.
