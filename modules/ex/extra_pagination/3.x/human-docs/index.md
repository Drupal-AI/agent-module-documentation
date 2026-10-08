# Extra Pagination — manual setup guide

**Extra Pagination** (`extra_pagination`) improves Drupal's pager on long,
multi-page listings. Core's pager shows a run of nearby page links plus a jump to
the last page, which can leave a big gap in the middle — awkward to navigate when
there are dozens or hundreds of pages. Extra Pagination inserts an additional set
of pager items *between* the last visible page link and the final page, so more of
the range is reachable in a click or two. The maintainer's stated goal is largely
an SEO one: making any page reachable in roughly three or four clicks.

It's about as simple as a module gets. There's nothing to configure — once you
install and enable it, the extra pager items appear automatically wherever Drupal
renders a pager. It has no settings form, no permissions, and no security surface
of its own: it only changes how an existing pager is drawn, and it paginates
exactly what your view or query already returns.

The one thing worth checking is fit: because it adds intermediate page links, it
helps most on listings with a genuinely large number of pages. On a short listing
it simply has little to do. It's a good idea to confirm the extra links look right
in your theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That's the whole setup.

There is **no configuration page** — the module works the moment it's enabled, so
there is no dedicated Configuration guide.

## Where it lives in the admin menu

Extra Pagination adds no admin page and no settings. Once enabled, the extra pager
items appear automatically on paged listings across the site.
