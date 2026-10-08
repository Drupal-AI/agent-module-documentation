# Happy New Year — manual setup guide

**Happy New Year** (`happy_new_year`) adds a festive garland and gently falling
snow to your website, creating a New Year and Christmas atmosphere for you and
your visitors. It's a purely decorative front-end effect — nothing sensitive is
involved and it has no functional role beyond the seasonal look.

What sets it apart from similar decoration modules is that it bundles all the
New Year and Christmas trimmings in one place and behaves politely with your
site's chrome. You can set a **time interval** so the decoration only appears
during the holidays, the garland automatically drops **below the admin toolbar**
(rather than hiding behind it) and below a **fixed Bootstrap navbar**, you can
**choose the snow color** (handy on light-colored sites where white snow would be
invisible), and you can opt to use **minified libraries** for a lighter payload.

The only practical things to weigh are taste and performance: it's seasonal, so
it's usually switched on and off around the holidays, and an animated overlay
does cost a little client-side resource.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the active time interval, snow color,
   and minified-library options.

## Where it lives in the admin menu

Once enabled, the module provides a **settings** form (in the **Configuration**
area of the admin menu) where you set the active dates, snow color, and library
options — see [Configuration](configuration/index.md).
