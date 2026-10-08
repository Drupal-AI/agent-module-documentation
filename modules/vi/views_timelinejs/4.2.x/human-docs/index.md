# Views TimelineJS — manual setup guide

**Views TimelineJS** (`views_timelinejs`) adds a Views **display format** that
renders the rows of any View as an interactive [Knight Lab
TimelineJS3](https://timeline.knightlab.com/) timeline — the scrollable,
horizontal timeline widget you have probably seen on news and history sites. Each
row becomes a slide (or an era band, or the title slide), built from the View
fields you map to timeline properties like start date, headline, media, and
background.

You use it like any other Views style: build a View of the content you want,
add the fields you need, then set the display's format to **TimelineJS** and map
each field to a slide property. Because it works from fields, you get all of
Views' power for free — exposed filters, contextual filters, sorting, and access
control all still apply, so you can show a filtered slice of history or a
chronological archive as an alternative to a plain list.

A start-date field is the one required mapping; everything else (end date,
headline, body, media, credit/caption, background image or color, group lanes,
and a per-row "type" that marks a row as an era or the title slide) is optional.
Presentation options mirror TimelineJS's own settings — width, height, font,
navigation position, language, and where the timeline opens. A small site-wide
settings form controls where the TimelineJS library itself loads from: the Knight
Lab CDN (latest or a pinned version) or a local copy for privacy or offline use.
The module depends only on core's Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — build a timeline View, map the
   fields, and choose where the TimelineJS library loads from.

## Where it lives in the admin menu

There is no standalone page for building timelines — you do that inside the Views
UI (*Structure → Views*) by choosing the **TimelineJS** format on a display. The
module's one small settings form, which picks the TimelineJS library source,
lives at **Configuration → Development → Views TimelineJS**
(`/admin/config/development/views-timelinejs`).
