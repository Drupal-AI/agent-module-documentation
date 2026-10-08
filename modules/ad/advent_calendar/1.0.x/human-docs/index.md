# Advent Calendar — manual setup guide

**Advent Calendar** (`advent_calendar`) is a Views display that renders the rows
of a View as an advent-calendar grid — a set of dated "door" tiles that reveal
their content on their day. It is built for seasonal campaigns and promotions: a
countdown to a launch, a December advent calendar, a run of daily reveals.

You build a normal View of whatever content you like (nodes, media, and so on),
then choose the advent-calendar format so each result becomes a dated tile.
Because the tiles are just a presentation of view rows, they always respect the
access rules of the content behind them — a visitor only ever sees tiles for
content they are allowed to see.

One important caveat: the reveal-by-date behaviour is a *presentation
convenience*. It decides when a tile visually opens, but it is not a security
control. Do not rely on it to embargo sensitive material — if the underlying
content is published and viewable, treat it as available regardless of which
"door" it sits behind.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views.

## How to use it

Advent Calendar does not add its own admin settings page. You use it entirely
from within Views:

1. Go to **Structure → Views** (`/admin/structure/views`) and add or edit a View
   of the content you want to feature.
2. In the View's **Format** section, choose the **Advent Calendar** format. Each
   result row is then rendered as a dated tile.
3. Configure the View as usual — filters (for example, limit to a content type or
   a date range), sort order, and the fields shown inside each tile.
4. Save the View and place it wherever you display Views output (a page, a block,
   and so on).

The tiles reveal their content on the appropriate day, giving visitors the
familiar advent-calendar experience without any custom theming.
