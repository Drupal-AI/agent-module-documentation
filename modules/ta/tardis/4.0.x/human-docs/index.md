# TARDIS — manual setup guide

**TARDIS** (`tardis`) is a Views style plugin that turns a date-bearing view into
a compact "archive by month" widget — the classic blog/news navigation that shows
a list of years, each expandable to months, with every link pointing at a
date-filtered listing of content. Selecting the TARDIS style on a view renders its
results as reverse-chronological year/month links (for example `/tardis/1963/11`),
newest first, instead of as a table or an unformatted list.

It is a lightweight, display-only alternative to a full calendar view. It depends
only on core **Views**, adds no routes, permissions or services, and introduces no
new endpoints — it simply renders links over whatever content the underlying view
already exposes, so it carries no access-control surface of its own.

TARDIS is not something you enable and forget: it is a style you choose on a
specific view, and it emits links like `/{prefix}/{year}/{month}` that you then
wire up to a destination — typically a companion view with contextual filters that
resolves the year and month arguments to show that month's content. The style
offers a few options (a link path prefix, a month date format, and whether month
links nest inside their year) covered on the configuration page.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — selecting the TARDIS style on a view,
   its options field by field, and how to wire up the link targets.

## How to use it

TARDIS surfaces as a **Format → Style** option inside the Views UI. Create or edit
a view of your dated content, set its format to **TARDIS**, give it a date
field/sort and enough rows to cover the range you want to link, and it will output
the year/month navigation. You then build the pages those links point to. See
[Configuration](configuration/index.md) for the full walkthrough.
