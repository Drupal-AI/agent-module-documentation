# RenderViz — manual setup guide

**RenderViz** (`renderviz`), short for Render Visualization, is a **developer
tool** that makes the cache properties of Drupal's render arrays visible. Drupal
attaches *cacheability metadata* — cache tags, cache contexts, and a max-age — to
the pieces of a rendered page, and that metadata drives how (and whether) output
is cached. RenderViz visualizes it so you can actually see which cache tags,
contexts, and max-age values apply where, and understand or fix caching
behaviour during development.

It requires **Drupal core 11.2+** and lives in the *Development* package. It
needs no modules outside core. RenderViz is a work in progress — the project
page invites contributions — and it deliberately has **no menu items and no
settings**: there is nothing to configure.

Because it is a debugging aid, keep it to **developers** and prefer **not to
enable it on production**. Like any debug tool it can surface internal
render/cache detail, which can hint at your site's structure and data
dependencies. It has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module in your development environment.

There is **no configuration page** and no settings for this module — it works as
a visualization tool once enabled.

## How to use it

Enable RenderViz in your local/development environment, then browse the site and
use the visualization it provides to inspect the cacheability metadata attached
to the render output. Because there are no settings, the module simply makes the
cache information visible once it is on.

When you are finished debugging, **uninstall it** (or at least keep it disabled on
production) so that internal cache detail is not exposed on a live site.

> **Tip:** Since Drupal 9.5.0, core can also output render-cache debug comments in
> the HTML source. RenderViz complements that by visualizing the same
> cacheability information rather than leaving it in raw markup.
