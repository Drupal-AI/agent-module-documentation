# Views Exclude Previous — manual setup guide

**Views Exclude Previous** (`views_exclude_previous`) stops the same entity from
appearing twice on one page. It quietly keeps track of every entity rendered during
a page request, and provides a Views contextual-filter default that excludes those
already-rendered entities from later views on the same page.

The classic use is a "Related articles" block that keeps re-showing the article you
are already reading, or a featured view and a main listing on the same page that
duplicate the same nodes. With this module wired into a view's contextual filter,
each view shows fresh, non-overlapping content — great for magazine-style landing
pages, hero-plus-grid layouts, and "you might also like" blocks.

It works even when entities come from Drupal's render cache, because it records
entities using a build hook that fires for cached entities too. There is **no admin
settings page, no permissions, and no configuration object** — you set it up
entirely inside a view.

Two things to note: version 3.x is a complete rewrite with **no upgrade path from
2.x**, and there is one easily-missed step (ticking the **Exclude** checkbox)
without which the filter does the opposite of what you want. Both are covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere of its own — it adds no admin page. You configure it on a view's
**contextual filter** at *Structure → Views → (your view)*.

## How to use it

Set it up on the view you want to de-duplicate:

1. Add a **contextual filter** (argument) for the entity id — for nodes, *Content:
   ID*.
2. Under **When the filter value is NOT available**, choose **Provide default
   value**.
3. For the default value type, choose **Previously rendered entities**.
4. Choose **Do not use a relationship** to check against the current page's entity
   (or use a relationship to check a related entity).
5. Set **Entity type** to the type to track — typically **Content** for nodes. This
   is required.
6. **The easily-missed step:** scroll to the bottom of the contextual-filter
   settings, expand **More**, and tick the **Exclude** checkbox. Without it, the
   filter *includes* rather than *excludes* the already-rendered ids.

A couple of gotchas: only entities rendered **before** this view on the page are
excluded, so the order of blocks and views matters; and when nothing has been
rendered yet, the filter is effectively a no-op and the view is unfiltered.
Developers can also use the render-history service directly to record or read
already-rendered entities — see the [`agent/`](../agent/start.md) docs.
